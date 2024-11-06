import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:remember/helpers/constants.dart';
import 'package:remember/models/map_data.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({
    required this.isSelecting,
    this.initialPosition = const LatLng(51.77689791254236, 19.489274125911784),
    this.markers = const {},
    super.key,
  });

  final bool isSelecting;
  final LatLng initialPosition;
  final Set<Marker> markers;

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late final GoogleMapController _controller;
  bool _isGettingCurrentLocation = false;
  LatLng? _pickedPosition;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _getCurrentLocation() async {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;
    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted != PermissionStatus.granted) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    setState(() {
      _isGettingCurrentLocation = true;
    });
    locationData = await location.getLocation();
    setState(() {
      _isGettingCurrentLocation = false;
    });
    final lat = locationData.latitude;
    final lng = locationData.longitude;
    if (lat == null || lng == null) {
      return;
    }

    setState(() {
      _pickedPosition = LatLng(lat, lng);
    });
    _controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: _pickedPosition!,
          zoom: zoom,
        ),
      ),
    );
    _savePlace(lat, lng);
  }

  Future<void> _savePlace(double lat, double lng) async {
    final test = MapData(coordinates: GeoPoint(lat, lng), address: "test");
  }

  Set<Marker> get markersList {
    if (widget.isSelecting && _pickedPosition != null) {
      return {
        Marker(
          markerId: const MarkerId('m1'),
          position: _pickedPosition!,
        ),
      };
    }

    if (!widget.isSelecting) {
      return widget.markers;
    }
    return {};
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: widget.isSelecting
          ? FloatingActionButton(
              onPressed: _getCurrentLocation,
              backgroundColor: Colors.white,
              child: _isGettingCurrentLocation
                  ? const CircularProgressIndicator()
                  : const Icon(Icons.my_location_outlined),
            )
          : null,
      extendBodyBehindAppBar: true,
      appBar: widget.isSelecting
          ? AppBar(
              forceMaterialTransparency: true,
              automaticallyImplyLeading: false,
              actions: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(Icons.save_rounded),
                  ),
                ),
              ],
            )
          : null,
      body: Stack(
        children: [
          GoogleMap(
            zoomControlsEnabled: false,
            onMapCreated: (controller) {
              _controller = controller;
            },
            initialCameraPosition: CameraPosition(
              target: widget.initialPosition,
              zoom: zoom,
            ),
            markers: markersList,
            onTap: widget.isSelecting == false
                ? null
                : (markerPosition) {
                    setState(() {
                      _pickedPosition = markerPosition;
                    });
                  },
          ),
        ],
      ),
    );
  }
}
