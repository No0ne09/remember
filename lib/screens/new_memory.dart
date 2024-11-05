import 'package:flutter/material.dart';
import 'package:remember/helpers/validators.dart';
import 'package:remember/widgets/base_textfield.dart';
import 'package:remember/widgets/multiline_textfield.dart';

class NewMemory extends StatefulWidget {
  const NewMemory({super.key});

  @override
  State<NewMemory> createState() => _NewMemoryState();
}

class _NewMemoryState extends State<NewMemory> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: [
            BaseTextfield(
              validator: basicValidator,
              hint: "Tytuł",
              controller: _titleController,
            ),
            Container(),
            ElevatedButton(
              onPressed: () {},
              child: Text("Location"),
            ),
            MultilineTextfield(
              validator: basicValidator,
              label: "Opisz swoje wspomnienie",
              controller: _descriptionController,
            ),
            ElevatedButton(
              onPressed: () {},
              child: Text("Save memory"),
            ),
          ],
        ),
      ),
    );
  }
}
