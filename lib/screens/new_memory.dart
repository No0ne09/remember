import 'dart:io';

import 'package:exif/exif.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

import 'package:remember/helpers/functions.dart';
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
  File? _chosenImage;
  String? _memoryDate;

  Future<void> _checkDateTime() async {
    if (_chosenImage == null) return;
    final exif = await readExifFromFile(_chosenImage!);
    final exifDateTime = exif["EXIF DateTimeOriginal"]?.toString();

    if (exifDateTime == null) return;
    final tempDateTime =
        DateTime.tryParse(exifDateTime.substring(0, 10).replaceAll(":", '-'));

    if (tempDateTime == null) return;

    final dateTime = getFormattedDate(tempDateTime);
    setState(() {
      _memoryDate = dateTime;
    });
  }

  Future<void> _pickDateTime() async {
    final tempDateTime = await showDatePicker(
      locale: const Locale("pl"),
      initialDate: _memoryDate == null
          ? DateTime.now()
          : DateTime.tryParse(_memoryDate!),
      context: context,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime.now(),
    );
    if (tempDateTime == null) return;
    final dateTime = getFormattedDate(tempDateTime);
    setState(() {
      _memoryDate = dateTime;
    });
  }

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
              hint: "Nazwij swoje wspomnienie",
              controller: _titleController,
              inputAction: TextInputAction.done,
            ),
            const SizedBox(
              height: 8,
            ),
            NewPhotoWidget(
              onChooseImage: (image) async {
                setState(() {
                  _chosenImage = image;
                });
                await _checkDateTime();
              },
            ),
            const SizedBox(
              height: 8,
            ),
            MainButton(
              backgroundColor: Colors.amber,
              onPressed: () async {
                await _pickDateTime();
              },
              text: _memoryDate == null ? "Data nieznana" : _memoryDate!,
            ),
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
