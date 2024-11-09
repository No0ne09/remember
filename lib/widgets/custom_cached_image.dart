import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:remember/helpers/strings.dart';

class CustomCachedImage extends StatelessWidget {
  const CustomCachedImage({
    required this.imageUrl,
    super.key,
  });

  final String imageUrl;
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      placeholder: (context, url) => const Center(
        child: CircularProgressIndicator(),
      ),
      errorWidget: (context, url, error) {
        return Container(
          color: Colors.black,
          child: const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  size: 35,
                  Icons.error,
                  color: Colors.white,
                ),
                Text(
                  failedDownload,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        );
      },
      imageUrl: imageUrl,
      fit: BoxFit.cover,
    );
  }
}
