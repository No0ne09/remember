import 'package:flutter/material.dart';
import 'package:remember/widgets/new_memory_container.dart';

class NewLocationWidget extends StatefulWidget {
  const NewLocationWidget({super.key});

  @override
  State<NewLocationWidget> createState() => _NewLocationWidgetState();
}

class _NewLocationWidgetState extends State<NewLocationWidget> {
  @override
  Widget build(BuildContext context) {
    return NewMemoryContainer(
      height: 150,
      text: "Nie podano lokalizacji",
      icon: Icons.location_off,
      onTap: () {
        return;
      },
    );
  }
}
