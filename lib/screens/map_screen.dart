import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.white,
        child: const Icon(Icons.my_location_outlined),
      ),
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
          Expanded(
            child: GoogleMap(
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
          ),
        ],
      ),
    );
  }
}
