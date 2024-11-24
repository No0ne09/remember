import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:remember/helpers/functions.dart';
import 'package:remember/helpers/theme.dart';
import 'package:remember/screens/base_map_screen.dart';
import 'package:remember/widgets/custom_cached_image.dart';
import 'package:remember/widgets/memory_details/pageview_button.dart';

class MemoryPageview extends StatefulWidget {
  const MemoryPageview({
    required this.imageUrl,
    required this.location,
    required this.title,
    required this.size,
    super.key,
  });
  final String imageUrl;
  final GeoPoint location;
  final String title;
  final Size size;

  @override
  State<MemoryPageview> createState() => _MemoryPageviewState();
}

class _MemoryPageviewState extends State<MemoryPageview> {
  late final PageController _pageController;
  int _currentPage = 0;
  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _showFullScreenImage() {
    showDialog(
      barrierColor: Colors.black,
      context: context,
      builder: (context) {
        return GestureDetector(
          child: CustomCachedImage(
            imageUrl: widget.imageUrl,
            fit: BoxFit.contain,
          ),
          onTap: () {
            Navigator.pop(context);
          },
        );
      },
    );
  }

  void _changePage() {
    final direction = _currentPage == 0
        ? _pageController.nextPage
        : _pageController.previousPage;
    direction(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _showMap() {
    final position =
        LatLng(widget.location.latitude, widget.location.longitude);
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => BaseMapScreen(
        initialPosition: position,
        markers: {
          Marker(
              markerId: MarkerId(widget.title),
              infoWindow: InfoWindow(
                title: widget.title,
              ),
              position: position),
        },
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: defaultBorderRadius,
          ),
          clipBehavior: Clip.antiAlias,
          child: SizedBox(
            width: widget.size.width,
            height: widget.size.height / 1.7,
            child: Hero(
              tag: widget.imageUrl,
              child: ClipRRect(
                borderRadius: defaultBorderRadius,
                child: PageView(
                  onPageChanged: (value) {
                    setState(() {
                      _currentPage = value;
                    });
                  },
                  controller: _pageController,
                  children: [
                    GestureDetector(
                      onLongPress: _showFullScreenImage,
                      child: Container(
                        color: Colors.black,
                        child: CustomCachedImage(
                          imageUrl: widget.imageUrl,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onLongPress: _showMap,
                      child: CustomCachedImage(
                        imageUrl: getStaticMap(widget.location),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        PageviewButton(
          onPressed: _changePage,
          icon: _currentPage == 0 ? Icons.arrow_forward : Icons.arrow_back,
        )
      ],
    );
  }
}
