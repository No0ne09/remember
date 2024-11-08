import 'package:flutter/material.dart';

class MemoriesSliverHeader extends StatelessWidget {
  const MemoriesSliverHeader({required this.text, super.key});
  final String text;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          text,
          style: Theme.of(context)
              .textTheme
              .headlineMedium!
              .copyWith(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
