import 'package:flutter/material.dart';
import 'package:remember/screens/map_screen.dart';
import 'package:remember/widgets/new_memory/new_memory_container.dart';

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
      onTap: () async {
        final location = await Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => MapScreen(isSelecting: true),
        ));
        print(location);
        if (location == null) return;
      },
    );
  }
}
