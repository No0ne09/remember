import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

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
      decoration: const BoxDecoration(
        image: DecorationImage(
            opacity: 0.1,
            fit: BoxFit.contain,
            image: Svg(
              'assets/background.svg',
              color: Colors.transparent,
            )),
      ),
      child: child,
    );
  }
}
