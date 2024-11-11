import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:remember/helpers/constants.dart';
import 'package:remember/helpers/providers.dart';
import 'package:remember/helpers/strings.dart';

class CustomAppBar extends ConsumerWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ConvexAppBar(
      key: appBarKey,
      initialActiveIndex: 0,
      top: 0,
      height: 60,
      style: TabStyle.custom,
      items: const [
        TabItem(
          icon: Icons.browse_gallery_outlined,
          title: memories,
          activeIcon: Icon(
            Icons.browse_gallery,
          ),
        ),
        if (!kIsWeb)
          TabItem(
            icon: Icons.add_a_photo_outlined,
            title: remember,
            activeIcon: Icon(
              Icons.add_a_photo,
            ),
          ),
        TabItem(
          icon: Icons.map_outlined,
          title: memoryMap,
          activeIcon: Icon(Icons.map),
        ),
      ],
      onTap: (index) {
        ref.read(indexProvider.notifier).state = index;
      },
    );
  }
}
