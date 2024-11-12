import 'package:flutter/material.dart';
import 'package:remember/helpers/strings.dart';

class TitleWidget extends StatelessWidget {
  const TitleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: kToolbarHeight,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset("assets/logo.png"),
            ),
          ),
          const Text(appName),
        ],
      ),
    );
  }
}
