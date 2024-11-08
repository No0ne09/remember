import 'package:flutter/material.dart';
import 'package:remember/helpers/constants.dart';

class NewMemoryContainer extends StatelessWidget {
  const NewMemoryContainer({
    required this.height,
    this.child,
    required this.text,
    required this.icon,
    super.key,
    required this.onTap,
  });
  final double height;
  final Widget? child;
  final String text;
  final IconData icon;
  final Future<void>? Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: defaultBorderRadius,
        ),
        height: height,
        width: double.infinity,
        child: child ??
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    size: 50,
                    icon,
                    color: Colors.white,
                  ),
                  Text(
                    text,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
      ),
    );
  }
}
