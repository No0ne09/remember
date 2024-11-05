import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatefulWidget {
  const CustomAppBar({super.key});

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return ConvexAppBar(
        activeColor: Colors.white,
        initialActiveIndex: 0,
        top: 0,
        height: 60,
        style: TabStyle.custom,
        items: const [
          TabItem(
            icon: Icons.library_books_outlined,
            title: 'Wspomnienia',
            activeIcon: Icon(
              Icons.library_books_sharp,
            ),
          ),
          TabItem(
            icon: Icons.browse_gallery_outlined,
            title: 'Zapamiętaj',
            activeIcon: Icon(
              Icons.browse_gallery,
            ),
          ),
          TabItem(
            icon: Icons.map_outlined,
            title: 'Mapa wspomnień',
            activeIcon: Icon(Icons.map),
          ),
        ]);
  }
}
