import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:remember/helpers/constants.dart';
import 'package:remember/helpers/providers.dart';
import 'package:remember/helpers/strings.dart';
import 'package:remember/widgets/memories_gallery/memories_sliver.dart';
import 'package:remember/widgets/memories_gallery/memories_sliver_header.dart';

class MemoriesList extends ConsumerWidget {
  const MemoriesList({
    required this.memories,
    super.key,
  });
  final List<QueryDocumentSnapshot<Map<String, dynamic>>> memories;

  List<QueryDocumentSnapshot<Map<String, dynamic>>> _getSortedMemories(
      bool descending) {
    return List.of(memories)
      ..sort((a, b) {
        final memoryDateA = a.data()[firebaseDataKeys['memoryDate']]! as String;
        final memoryDateB = b.data()[firebaseDataKeys['memoryDate']]! as String;
        final comparison = descending
            ? memoryDateB.compareTo(memoryDateA)
            : memoryDateA.compareTo(memoryDateB);
        if (comparison != 0) return comparison;
        final uploadTimeStampA =
            a.data()[firebaseDataKeys['uploadTimeStamp']]! as Timestamp;
        final uploadTimeStampB =
            b.data()[firebaseDataKeys['uploadTimeStamp']]! as Timestamp;
        return descending
            ? uploadTimeStampB.compareTo(uploadTimeStampA)
            : uploadTimeStampA.compareTo(uploadTimeStampB);
      });
  }

  Map<String, List<QueryDocumentSnapshot<Map<String, dynamic>>>>
      _getGroupedMemories(
          List<QueryDocumentSnapshot<Map<String, dynamic>>> memories) {
    final Map<String, List<QueryDocumentSnapshot<Map<String, dynamic>>>>
        grouped = {
      'favouriteMemories': [],
      'basicMemories': [],
    };
    for (final memory in memories) {
      final isFavourite =
          memory.data()[firebaseDataKeys['isFavourite']]! as bool;
      isFavourite
          ? grouped["favouriteMemories"]!.add(memory)
          : grouped["basicMemories"]!.add(memory);
    }
    return grouped;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final overlay = ref.watch(memoryOverlayProvider);
    final descending = ref.watch(memoryOrderProvider);
    final sortedMemories = _getSortedMemories(descending);
    final groupedMemories = _getGroupedMemories(sortedMemories);
    final favouriteMemories = groupedMemories['favouriteMemories']!;
    final basicMemories = groupedMemories['basicMemories']!;

    return CustomScrollView(
      slivers: [
        if (favouriteMemories.isNotEmpty)
          const MemoriesSliverHeader(text: favMemories),
        MemoriesSliver(
          memories: favouriteMemories,
          overlay: overlay,
        ),
        if (basicMemories.isNotEmpty)
          const MemoriesSliverHeader(text: yourMemories),
        MemoriesSliver(
          memories: basicMemories,
          overlay: overlay,
        ),
      ],
    );
  }
}
