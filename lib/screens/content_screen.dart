import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:remember/helpers/providers.dart';
import 'package:remember/screens/add_memory.dart';
import 'package:remember/screens/map.dart';
import 'package:remember/screens/memories_gallery.dart';
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
    switch (currentIndex) {
      case 0:
        return const MemoriesGallery();
      case 1:
        return const AddMemory();
      case 2:
        return const MapWidget();
      default:
        return const MemoriesGallery();
    }
  }

  @override
  Widget build(BuildContext context) {
    currentIndex = ref.watch(indexProvider);

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
              FirebaseAuth.instance.signOut();
              ref.read(indexProvider.notifier).state = 0;
            },
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: currentContent,
    );
  }
}
