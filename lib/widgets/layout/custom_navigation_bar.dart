import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:remember/helpers/constants.dart';
import 'package:remember/helpers/providers.dart';
import 'package:remember/helpers/strings.dart';

class CustomNavigationBar extends ConsumerWidget {
  const CustomNavigationBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    return ConvexAppBar(
      backgroundColor: colorScheme.surface,
      color: colorScheme.primary,
      activeColor: colorScheme.primary,
      elevation: 0,
      key: appBarKey,
      initialActiveIndex: 0,
      top: 0,
      height: 60,
      style: TabStyle.custom,
      items: [
        TabItem(
          isIconBlend: true,
          icon: Icons.browse_gallery_outlined,
          title: memories,
          activeIcon: Icon(
            Icons.browse_gallery,
            color: colorScheme.surface,
          ),
        ),
        if (!kIsWeb)
          TabItem(
            icon: Icons.add_a_photo_outlined,
            title: remember,
            activeIcon: Icon(
              Icons.add_a_photo,
              color: colorScheme.surface,
            ),
          ),
        TabItem(
          icon: Icons.map_outlined,
          title: memoryMap,
          activeIcon: Icon(
            Icons.map,
            color: colorScheme.surface,
          ),
        ),
      ],
      onTap: (index) {
        ref.read(indexProvider.notifier).state = index;
      },
    );
  }
}
