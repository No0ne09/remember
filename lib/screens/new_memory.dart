import 'package:flutter/material.dart';
import 'package:remember/helpers/validators.dart';
import 'package:remember/widgets/base_textfield.dart';
import 'package:remember/widgets/main_button.dart';
import 'package:remember/widgets/multiline_textfield.dart';
import 'package:remember/widgets/new_photo_widget.dart';

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
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            BaseTextfield(
              validator: basicValidator,
              label: "Tytuł",
              controller: _titleController,
            ),
            const SizedBox(
              height: 8,
            ),
            const NewPhotoWidget(),
            const SizedBox(
              height: 8,
            ),
            MainButton(
              onPressed: () {},
              text: "Location",
            ),
            const SizedBox(
              height: 8,
            ),
            MultilineTextfield(
              validator: basicValidator,
              label: "Opisz swoje wspomnienie",
              controller: _descriptionController,
            ),
            const SizedBox(
              height: 8,
            ),
            MainButton(
              onPressed: () {},
              text: "Save memory",
            ),
          ],
        ),
      ),
    );
  }
}
