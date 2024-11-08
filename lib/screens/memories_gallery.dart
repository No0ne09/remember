import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:remember/helpers/providers.dart';
import 'package:remember/widgets/memories_gallery/memory_card.dart';

class MemoriesGallery extends ConsumerWidget {
  const MemoriesGallery({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = FirebaseAuth.instance.currentUser!;
    final descending = ref.watch(memoryOrderProvider);
    final overlay = ref.watch(memoryOrderProvider);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('memories_by_user')
            .doc(user.uid)
            .collection("memories")
            .orderBy('dateTime', descending: descending)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return const Center(
              child: Text("Wystąpił błąd."),
            );
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text("Brak wspomnień"),
            );
          }
          final memories = snapshot.data!.docs;
          return CustomScrollView(
            slivers: [
              SliverGrid(
                delegate: SliverChildBuilderDelegate(
                  childCount: memories.length,
                  (context, index) => MemoryCard(
                    data: memories[index].data(),
                  ),
                ),
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: overlay ? 500 : 300,
                    crossAxisSpacing: 4.0,
                    mainAxisSpacing: 4.0,
                    childAspectRatio: 3 / 3),
              ),
            ],
          );
        },
      ),
    );
  }
}
