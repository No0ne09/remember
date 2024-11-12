import 'package:flutter/material.dart';
import 'package:remember/helpers/strings.dart';

class ConfirmationPopup extends StatelessWidget {
  const ConfirmationPopup({
    required this.text,
    super.key,
  });
  final String text;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text(text),
      title: const Text(warning),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text("NIE"),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context, true);
          },
          child: Text("TAK"),
        ),
      ],
    );
  }
}
