import 'package:flutter/material.dart';
import 'package:remember/helpers/theme.dart';

class InfoPopup extends StatelessWidget {
  const InfoPopup({
    required this.title,
    required this.desc,
    super.key,
  });

  final String title;
  final String desc;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          style: getSmallRedButtonStyle(context),
          child: const Text("Ok"),
        ),
      ],
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      content: Text(
        desc,
        style: const TextStyle(fontSize: 16),
      ),
    );
  }
}
