import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  const MainButton({
    required this.text,
    required this.onPressed,
    super.key,
  });
  final String text;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(
        textAlign: TextAlign.center,
        text,
        style: Theme.of(context).textTheme.titleMedium!.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
      ),
    );
  }
}
