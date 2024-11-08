import 'package:flutter/material.dart';

class DrawerOption extends StatelessWidget {
  const DrawerOption({
    required this.onTap,
    required this.text,
    required this.icon,
    super.key,
  });
  final void Function() onTap;
  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: const Icon(Icons.exit_to_app_rounded),
      title: const Text("Wyloguj się"),
    );
  }
}
