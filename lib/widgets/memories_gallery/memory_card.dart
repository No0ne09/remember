import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:remember/helpers/constants.dart';

class MemoryCard extends StatelessWidget {
  const MemoryCard({required this.data, super.key});
  final Map<String, dynamic> data;
  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(borderRadius: defaultBorderRadius),
      child: CachedNetworkImage(
        imageUrl: data["imageUrl"],
        fit: BoxFit.cover,
      ),
    );
  }
}
