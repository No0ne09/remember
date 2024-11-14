import 'package:flutter/material.dart';
import 'package:remember/helpers/strings.dart';
import 'package:remember/helpers/theme.dart';

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
          child: const Text(no),
        ),
        ElevatedButton(
          style: getSmallRedButtonStyle(context),
          onPressed: () {
            Navigator.pop(context, true);
          },
          child: const Text(yes),
        ),
      ],
    );
  }
}
