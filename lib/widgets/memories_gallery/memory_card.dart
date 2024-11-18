import 'package:flutter/material.dart';
import 'package:remember/helpers/constants.dart';
import 'package:remember/screens/memory_details.dart';
import 'package:remember/widgets/custom_cached_image.dart';

class MemoryCard extends StatelessWidget {
  const MemoryCard({required this.data, required this.id, super.key});
  final Map<String, dynamic> data;
  final String id;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: defaultBorderRadius,
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          CustomCachedImage(
            imageUrl: data[firebaseDataKeys['imageUrl']!],
            fit: BoxFit.cover,
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
                  data[firebaseDataKeys["title"]!],
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
                  builder: (context) => MemoryDetails(
                    data: data,
                    id: id,
                  ),
                ));
              },
            ),
          ),
        ],
      ),
    );
  }
}
