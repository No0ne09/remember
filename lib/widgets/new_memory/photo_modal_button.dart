import 'package:flutter/material.dart';

class PhotoModalButton extends StatelessWidget {
  const PhotoModalButton({
    required this.onTap,
    required this.text,
    required this.icon,
    super.key,
  });
  final Future<void> Function()? onTap;
  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: CircleAvatar(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 35,
              ),
              Text(text),
            ],
          ),
        ),
      ),
    );
  }
}
