import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:remember/helpers/strings.dart';
import 'package:remember/widgets/memories_gallery/memories_list.dart';

class MemoriesGallery extends StatelessWidget {
  const MemoriesGallery({super.key});

  @override
  Widget build(BuildContext context) {
    return Placeholder();
    final user = FirebaseAuth.instance.currentUser!;
    final stream = FirebaseFirestore.instance
        .collection('memories_by_user')
        .doc(user.uid)
        .collection("memories")
        .snapshots();
    print("tset");

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: StreamBuilder(
        stream: stream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return const Center(
              child: Text(unknownError),
            );
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text(noMemories),
            );
          }

          final memories = snapshot.data!.docs;
          return MemoriesList(memories: memories);
        },
      ),
    );
  }
}
