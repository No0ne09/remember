import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:remember/widgets/custom_cached_image.dart';
import 'package:remember/widgets/memory_details/pageview_button.dart';

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

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Card(
      clipBehavior: Clip.antiAlias,
      child: SizedBox(
        width: width,
        height: height / 2,
        child: Stack(
          children: [
            PageView(
              onPageChanged: (value) {
                setState(() {
                  _currentPage = value;
                });
              },
              controller: _pageController,
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
            Align(
              alignment:
                  _currentPage == 0 ? Alignment.topRight : Alignment.topLeft,
              child: PageviewButton(
                onPressed: () {
                  final direction = _currentPage == 0
                      ? _pageController.nextPage
                      : _pageController.previousPage;
                  direction(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
                icon:
                    _currentPage == 0 ? Icons.arrow_forward : Icons.arrow_back,
              ),
            )
          ],
        ),
      ),
    );
  }
}
