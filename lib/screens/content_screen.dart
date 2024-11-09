import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:remember/helpers/providers.dart';
import 'package:remember/screens/new_memory.dart';
import 'package:remember/screens/map.dart';
import 'package:remember/screens/memories_gallery.dart';
import 'package:remember/widgets/background.dart';
import 'package:remember/widgets/buttons/animated_toggle_button.dart';
import 'package:remember/widgets/custom_app_bar.dart';
import 'package:remember/widgets/user_drawer/user_drawer.dart';

class ContentScreen extends ConsumerStatefulWidget {
  const ContentScreen({super.key});

  @override
  ConsumerState<ContentScreen> createState() => _ContentScreenState();
}

class _ContentScreenState extends ConsumerState<ContentScreen> {
  int _currentIndex = 0;

  Widget get _currentContent {
    switch (_currentIndex) {
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

  String get _pageTitle {
    switch (_currentIndex) {
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
    _currentIndex = ref.watch(indexProvider);
    return Scaffold(
      bottomNavigationBar: kIsWeb ? null : const CustomAppBar(),
      drawer: const UserDrawer(),
      appBar: AppBar(
        forceMaterialTransparency: true,
        centerTitle: true,
        title: Text(_pageTitle),
        bottom: kIsWeb
            ? const PreferredSize(
                preferredSize: Size.fromHeight(kToolbarHeight),
                child: CustomAppBar(),
              )
            : null,
        actions: ref.read(indexProvider) == 0
            ? [
                Tooltip(
                  message: "Zmień rozmiar kafelków",
                  child: AnimatedToggleButton(
                    activeIcon: Icons.view_comfy_sharp,
                    inactiveIcon: Icons.view_cozy_rounded,
                    provider: memoryOverlayProvider,
                  ),
                ),
                Tooltip(
                  message: "Odwróć sortowanie",
                  child: AnimatedToggleButton(
                    activeIcon: Icons.south_rounded,
                    inactiveIcon: Icons.north_outlined,
                    provider: memoryOrderProvider,
                  ),
                ),
              ]
            : [],
      ),
      body: Background(child: _currentContent),
    );
  }
}
