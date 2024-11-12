import 'package:flutter/material.dart';

class PageviewButton extends StatelessWidget {
  const PageviewButton({
    required this.onPressed,
    required this.icon,
    super.key,
  });
  final void Function() onPressed;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: onPressed,
        child: CircleAvatar(
          child: Icon(icon, size: 30),
        ),
      ),
    );
  }
}
