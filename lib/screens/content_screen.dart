import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:remember/helpers/functions.dart';
import 'package:remember/helpers/providers.dart';
import 'package:remember/helpers/strings.dart';
import 'package:remember/screens/new_memory.dart';
import 'package:remember/screens/memories_map.dart';
import 'package:remember/screens/memories_gallery.dart';
import 'package:remember/widgets/layout/background.dart';
import 'package:remember/widgets/buttons/animated_toggle_button.dart';
import 'package:remember/widgets/layout/custom_app_bar.dart';
import 'package:remember/widgets/layout/title_widget.dart';
import 'package:remember/widgets/user_drawer/user_drawer.dart';

class ContentScreen extends ConsumerStatefulWidget {
  const ContentScreen({super.key});

  @override
  ConsumerState<ContentScreen> createState() => _ContentScreenState();
}

class _ContentScreenState extends ConsumerState<ContentScreen>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  late final AnimationController _animationController;

  Widget get _currentContent {
    switch (_currentIndex) {
      case 0:
        return const MemoriesGallery();
      case 1:
        return kIsWeb ? const MemoriesMap() : const NewMemory();
      case 2:
        return const MemoriesMap();
      default:
        return const MemoriesGallery();
    }
  }

  void _showOfflineWarning() async {
    final status = await checkConnection();
    if (status || !mounted) return;
    await showInfoPopup(
      context,
      noConnectionPopUpInfo,
    );
  }

  void _checkIdToken() {
    FirebaseAuth.instance.currentUser!.getIdToken(true).catchError(
      (error) {
        return null;
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _checkIdToken();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) => _showOfflineWarning(),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _currentIndex = ref.watch(indexProvider);
    _animationController.reset();
    _animationController.forward();
    return Scaffold(
      bottomNavigationBar: kIsWeb ? null : const CustomAppBar(),
      drawer: const UserDrawer(),
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: const TitleWidget(),
        bottom: kIsWeb
            ? const PreferredSize(
                preferredSize: Size.fromHeight(kToolbarHeight),
                child: CustomAppBar(),
              )
            : null,
        actions: ref.read(indexProvider) == 0
            ? [
                Tooltip(
                  message: changeSize,
                  child: AnimatedToggleButton(
                    activeIcon: Icons.view_comfy_sharp,
                    inactiveIcon: Icons.view_cozy_rounded,
                    provider: memoryOverlayProvider,
                  ),
                ),
                Tooltip(
                  message: sort,
                  child: AnimatedToggleButton(
                    activeIcon: Icons.south_rounded,
                    inactiveIcon: Icons.north_outlined,
                    provider: memoryOrderProvider,
                  ),
                ),
              ]
            : [],
      ),
      body: Background(
          child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) => FadeTransition(
          opacity: Tween(begin: 0.0, end: 1.0).animate(_animationController),
          child: child,
        ),
        child: _currentContent,
      )),
    );
  }
}
