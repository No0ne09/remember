import 'package:flutter/material.dart';

class ExitButton extends StatelessWidget {
  const ExitButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.pop(context);
      },
      icon: const CircleAvatar(
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        child: Icon(Icons.close),
      ),
    );
  }
}
