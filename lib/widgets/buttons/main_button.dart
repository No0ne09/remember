import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  const MainButton({
    required this.text,
    required this.onPressed,
    this.backgroundColor = Colors.blueAccent,
    this.foregroundColor = Colors.white,
    super.key,
  });
  final String text;
  final void Function() onPressed;
  final Color backgroundColor;
  final Color foregroundColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(
        textAlign: TextAlign.center,
        text,
        style: Theme.of(context).textTheme.titleMedium!.copyWith(
              color: foregroundColor,
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }
}
