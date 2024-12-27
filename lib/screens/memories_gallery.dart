import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:remember/helpers/constants.dart';
import 'package:remember/helpers/strings.dart';
import 'package:remember/widgets/layout/infotext.dart';
import 'package:remember/widgets/memories_gallery/memories_list.dart';

class MemoriesGallery extends StatelessWidget {
  const MemoriesGallery({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    final stream = FirebaseFirestore.instance
        .collection(firebaseDataKeys['memories_by_user']!)
        .doc(user.uid)
        .collection(firebaseDataKeys["memories"]!)
        .snapshots();

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
            return const Infotext(text: unknownError);
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Infotext(text: noMemories);
          }
          return MemoriesList(memories: snapshot.data!.docs);
        },
      ),
    );
  }
}
