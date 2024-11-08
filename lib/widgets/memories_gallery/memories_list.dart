import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:remember/helpers/providers.dart';
import 'package:remember/widgets/memories_gallery/memory_card.dart';

class MemoriesList extends ConsumerWidget {
  const MemoriesList({required this.memories, super.key});
  final List<QueryDocumentSnapshot<Map<String, dynamic>>> memories;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final overlay = ref.watch(memoryOverlayProvider);
    final descending = ref.watch(memoryOrderProvider);
    final sortedMemories = List.from(memories)
      ..sort((a, b) {
        final dateA = a.data()['dateTime'] as String;
        final dateB = b.data()['dateTime'] as String;
        return descending ? dateB.compareTo(dateA) : dateA.compareTo(dateB);
      });
    return CustomScrollView(
      slivers: [
        SliverGrid(
          delegate: SliverChildBuilderDelegate(
            childCount: sortedMemories.length,
            (context, index) => MemoryCard(
              data: sortedMemories[index].data(),
            ),
          ),
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: overlay ? 500 : 300,
            crossAxisSpacing: 4.0,
            mainAxisSpacing: 4.0,
          ),
        ),
      ],
    );
  }
}
