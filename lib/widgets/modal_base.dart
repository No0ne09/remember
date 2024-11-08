import 'package:flutter/material.dart';
import 'package:remember/widgets/buttons/exit_button.dart';

class ModalBase extends StatelessWidget {
  const ModalBase({required this.child, super.key});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: MediaQuery.of(context).size.height / 2,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const Row(
              children: [
                Spacer(),
                ExitButton(),
              ],
            ),
            child,
          ],
        ),
      ),
    );
  }
}
