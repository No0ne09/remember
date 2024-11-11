import 'package:flutter/material.dart';
import 'package:remember/helpers/theme.dart';

class Background extends StatelessWidget {
  const Background({
    required this.child,
    super.key,
  });
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      decoration: getBackgroundDecoration(context),
      child: child,
    );
  }
}
