import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MemoriesList extends StatefulWidget {
  const MemoriesList({super.key});

  @override
  State<MemoriesList> createState() => _MemoriesListState();
}

class _MemoriesListState extends State<MemoriesList> {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('memories_by_user')
          .doc(user.uid)
          .collection("memories")
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
                (context, index) => Text(
                  memories[index].data().toString(),
                ),
              ),
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 500.0,
                crossAxisSpacing: 5.0,
                mainAxisSpacing: 5.0,
              ),
            ),
          ],
        );
        return ListView.builder(
          itemCount: memories.length,
          itemBuilder: (context, index) =>
              Text(memories[index].data().toString()),
        );
      },
    );
  }
}
