import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:remember/helpers/providers.dart';
import 'package:remember/screens/new_memory.dart';
import 'package:remember/screens/map.dart';
import 'package:remember/screens/memories_gallery.dart';
import 'package:remember/widgets/background.dart';
import 'package:remember/widgets/custom_app_bar.dart';

class ContentScreen extends ConsumerStatefulWidget {
  const ContentScreen({super.key});

  @override
  ConsumerState<ContentScreen> createState() => _ContentScreenState();
}

class _ContentScreenState extends ConsumerState<ContentScreen> {
  int counter = 0;
  int currentIndex = 0;
  final _authInstance = FirebaseAuth.instance;

  Widget get currentContent {
    switch (currentIndex) {
      case 0:
        return const MemoriesGallery();
      case 1:
        return kIsWeb ? const MapWidget() : const NewMemory();
      case 2:
        return const MapWidget();
      default:
        return const MemoriesGallery();
    }
  }

  String get pageTitle {
    switch (currentIndex) {
      case 0:
        return "Re(me)mber";
      case 1:
        return kIsWeb ? "Mapa wspomnień" : "Zapisz wspomnienie";
      case 2:
        return "Mapa wspomnień";
      default:
        return "Re(me)mber";
    }
  }

  @override
  Widget build(BuildContext context) {
    currentIndex = ref.watch(indexProvider);

    return Scaffold(
      bottomNavigationBar: kIsWeb ? null : const CustomAppBar(),
      drawer: Drawer(
        child: SafeArea(
          child: Column(
            children: [
              IconButton(
                onPressed: () {
                  ref.read(indexProvider.notifier).state = 0;
                  _authInstance.signOut();
                },
                icon: const Icon(Icons.account_circle_rounded),
              )
            ],
          ),
        ),
      ),
      appBar: AppBar(
        forceMaterialTransparency: true,
        centerTitle: true,
        title: Text(pageTitle),
        bottom: kIsWeb
            ? const PreferredSize(
                preferredSize: Size.fromHeight(kToolbarHeight),
                child: CustomAppBar(),
              )
            : null,
        actions: ref.read(indexProvider) == 0
            ? [
                IconButton(
                  onPressed: () {
                    ref.read(memoryOverlayProvider.notifier).update(
                          (state) => !state,
                        );
                  },
                  icon: const Icon(Icons.view_comfortable),
                ),
                IconButton(
                  onPressed: () {
                    ref.read(memoryOrderProvider.notifier).update(
                          (state) => !state,
                        );
                  },
                  icon: const Icon(Icons.sort_outlined),
                ),
              ]
            : [],
      ),
      body: Background(child: currentContent),
    );
  }
}
