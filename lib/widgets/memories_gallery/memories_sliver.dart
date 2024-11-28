import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:remember/widgets/memories_gallery/memory_card.dart';

class MemoriesSliver extends StatelessWidget {
  const MemoriesSliver({
    required this.memories,
    required this.overlay,
    super.key,
  });
  final List<QueryDocumentSnapshot<Map<String, dynamic>>> memories;
  final bool overlay;
  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      delegate: SliverChildBuilderDelegate(
        childCount: memories.length,
        (context, index) => MemoryCard(
          data: memories[index].data(),
          id: memories[index].id,
        ),
      ),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: overlay ? 500 : 300,
        crossAxisSpacing: 4.0,
        mainAxisSpacing: 4.0,
      ),
    );
  }
}
