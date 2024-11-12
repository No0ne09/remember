import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  const MainButton({
    required this.text,
    required this.onPressed,
    this.color,
    super.key,
  });
  final String text;
  final void Function() onPressed;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: color),
      onPressed: onPressed,
      child: Text(
        textAlign: TextAlign.center,
        text,
        style: Theme.of(context).textTheme.titleMedium!.copyWith(
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }
}
