import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:remember/helpers/constants.dart';
import 'package:remember/helpers/functions.dart';
import 'package:remember/helpers/strings.dart';
import 'package:remember/helpers/theme.dart';

class BaseMapScreen extends StatefulWidget {
  const BaseMapScreen({
    this.isSelecting = false,
    this.initialPosition = const LatLng(51.77689791254236, 19.489274125911784),
    this.markers = const {},
    this.isMemoriesMap = false,
    super.key,
  });

  final bool isSelecting;
  final LatLng initialPosition;
  final Set<Marker> markers;
  final bool isMemoriesMap;

  @override
  State<BaseMapScreen> createState() => _BaseMapScreenState();
}

class _BaseMapScreenState extends State<BaseMapScreen> {
  late final GoogleMapController? _controller;
  bool _isGettingCurrentLocation = false;
  LatLng? _pickedPosition;

  Future<void> _getCurrentLocation() async {
    final location = Location();
    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;
    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        if (!mounted) return;
        await showInfoPopup(context, locationTurnedOff);
        return;
      }
    }
    permissionGranted = await location.hasPermission();
    if (permissionGranted != PermissionStatus.granted) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        if (!mounted) return;
        await showInfoPopup(context, noLocationPermission);
        return;
      }
    }
    setState(() {
      _isGettingCurrentLocation = true;
    });
    locationData = await location.getLocation();

    final lat = locationData.latitude;
    final lng = locationData.longitude;
    if (lat == null || lng == null || !mounted) return;
    setState(() {
      _isGettingCurrentLocation = false;
      _pickedPosition = LatLng(lat, lng);
    });
    _moveCamera(_pickedPosition!, zoom);
  }

  void _savePlace() {
    if (_pickedPosition == null) {
      Navigator.pop(context);
      return;
    }
    Navigator.pop(
      context,
      GeoPoint(
        _pickedPosition!.latitude,
        _pickedPosition!.longitude,
      ),
    );
  }

  Set<Marker> get _markersList {
    if (widget.isSelecting && _pickedPosition != null) {
      return {
        Marker(
            markerId: const MarkerId('picked_location'),
            position: _pickedPosition!,
            infoWindow: const InfoWindow(title: yourLocation)),
      };
    }
    if (!widget.isSelecting) return widget.markers;
    return {};
  }

  void _moveCamera(LatLng position, double zoom) {
    if (_controller == null) return;
    _controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: position, zoom: zoom),
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller = controller;
    _moveCamera(widget.initialPosition, zoom + 1);
  }

  @override
  Widget build(BuildContext context) {
    final Widget content = GoogleMap(
      style:
          Theme.of(context).brightness == Brightness.dark ? darkMapStyle : null,
      zoomControlsEnabled: false,
      mapToolbarEnabled: !widget.isSelecting,
      onMapCreated: _onMapCreated,
      initialCameraPosition: CameraPosition(
        target: widget.initialPosition,
        zoom: zoom,
      ),
      markers: _markersList,
      onTap: widget.isSelecting == false
          ? null
          : (markerPosition) {
              setState(() {
                _pickedPosition = markerPosition;
              });
            },
    );

    return !widget.isMemoriesMap
        ? Scaffold(
            floatingActionButton: widget.isSelecting
                ? FloatingActionButton(
                    heroTag: "Locate",
                    onPressed: _getCurrentLocation,
                    child: _isGettingCurrentLocation
                        ? const CircularProgressIndicator()
                        : const Icon(Icons.my_location_outlined),
                  )
                : null,
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              forceMaterialTransparency: true,
              automaticallyImplyLeading: true,
              actions: widget.isSelecting
                  ? [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: FloatingActionButton.large(
                          heroTag: "Save",
                          onPressed: _savePlace,
                          child: const Icon(
                            Icons.save_rounded,
                          ),
                        ),
                      ),
                    ]
                  : [],
            ),
            body: content,
          )
        : content;
  }
}
