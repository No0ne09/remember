import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({
    required this.isSelecting,
    super.key,
  });

  final bool isSelecting;
  //final LatLng initialPosition;

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late final GoogleMapController _controller;
  bool _isGettingCurrentLocation = false;
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
    print(locationData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: widget.isSelecting
          ? FloatingActionButton(
              onPressed: _getCurrentLocation,
              backgroundColor: Colors.white,
              child: _isGettingCurrentLocation
                  ? CircularProgressIndicator()
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
                    onPressed: () {},
                    child: const Icon(Icons.search_rounded),
                  ),
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {},
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
            initialCameraPosition: const CameraPosition(
              target: LatLng(
                21,
                37,
              ),
              zoom: 16,
            ),
            onTap: widget.isSelecting == false ? null : (markerPosition) {},
          ),
        ],
      ),
    );
  }
}
