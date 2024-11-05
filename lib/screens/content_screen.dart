import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:remember/helpers/functions.dart';
import 'package:remember/helpers/providers.dart';
import 'package:remember/widgets/custom_app_bar.dart';

class ContentScreen extends ConsumerStatefulWidget {
  const ContentScreen({super.key});

  @override
  ConsumerState<ContentScreen> createState() => _ContentScreenState();
}

class _ContentScreenState extends ConsumerState<ContentScreen> {
  int counter = 0;
  int currentIndex = 0;

  Widget get currentContent {
    return Placeholder();
  }

  @override
  Widget build(BuildContext context) {
    currentIndex = ref.watch(indexProvider);
    print(currentIndex);

    return Scaffold(
      bottomNavigationBar: kIsWeb ? null : const CustomAppBar(),
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Re(me)mber"),
            SizedBox(
              height: kToolbarHeight,
              child: Image.asset("assets/logo.png"),
            )
          ],
        ),
        bottom: kIsWeb
            ? const PreferredSize(
                preferredSize: Size.fromHeight(kToolbarHeight),
                child: CustomAppBar(),
              )
            : null,
        actions: [
          IconButton(
            onPressed: () {
              ref.read(indexProvider.notifier).state = 0;
              FirebaseAuth.instance.signOut();
            },
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: Center(
        child: ElevatedButton(
            onPressed: () async {
              final status = await checkConnection();
              if (!status) {
                return;
              }
              await FirebaseFirestore.instance
                  .collection("test")
                  .add({"test1": "test2"});
            },
            child: const Text("siup")),
      ),
    );
  }
}
