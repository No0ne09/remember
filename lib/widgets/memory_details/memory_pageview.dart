import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:remember/widgets/custom_cached_image.dart';

class MemoryPageview extends StatefulWidget {
  const MemoryPageview({
    required this.imageUrl,
    required this.location,
    super.key,
  });
  final String imageUrl;
  final GeoPoint location;

  @override
  State<MemoryPageview> createState() => _MemoryPageviewState();
}

class _MemoryPageviewState extends State<MemoryPageview> {
  late final PageController _pageController;
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

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return SizedBox(
      width: width,
      height: height / 2,
      child: PageView(
        children: [
          GestureDetector(
            onLongPress: _showFullScreenImage,
            child: CustomCachedImage(
              imageUrl: widget.imageUrl,
              fit: BoxFit.contain,
            ),
          ),
          Container(
            color: Colors.green,
          )
        ],
      ),
    );
  }
}
