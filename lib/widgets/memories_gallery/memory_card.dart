import 'package:flutter/material.dart';
import 'package:remember/helpers/constants.dart';
import 'package:remember/screens/memory_details.dart';
import 'package:remember/widgets/custom_cached_image.dart';

class MemoryCard extends StatelessWidget {
  const MemoryCard({required this.data, super.key});
  final Map<String, dynamic> data;
  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(
        borderRadius: defaultBorderRadius,
        side: const BorderSide(color: Colors.black, width: 2),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Hero(
            tag: data['imageUrl'],
            child: CustomCachedImage(
              imageUrl: data['imageUrl'],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.black.withOpacity(0.5),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                child: Text(
                  data["title"],
                  style: const TextStyle(color: Colors.white),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ),
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => MemoryDetails(data: data),
                ));
              },
            ),
          ),
        ],
      ),
    );
  }
}
