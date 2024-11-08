import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:remember/helpers/providers.dart';
import 'package:remember/widgets/memories_gallery/memories_sliver.dart';
import 'package:remember/widgets/memories_gallery/memories_sliver_header.dart';

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
    final List<QueryDocumentSnapshot<Map<String, dynamic>>> favouriteMemories =
        [];
    final List<QueryDocumentSnapshot<Map<String, dynamic>>> basicMemories = [];
    for (final memory in sortedMemories) {
      final isFavourite = memory.data()['isFavourite'] as bool? ?? false;
      isFavourite ? favouriteMemories.add(memory) : basicMemories.add(memory);
    }

    return CustomScrollView(
      slivers: [
        if (favouriteMemories.isNotEmpty)
          const MemoriesSliverHeader(text: "Ulubione wspomnienia"),
        MemoriesSliver(
          memories: favouriteMemories,
          overlay: overlay,
        ),
        if (basicMemories.isNotEmpty)
          const MemoriesSliverHeader(text: "Twoje wspomnienia"),
        MemoriesSliver(
          memories: basicMemories,
          overlay: overlay,
        ),
      ],
    );
  }
}
