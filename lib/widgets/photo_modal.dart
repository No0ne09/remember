import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:remember/widgets/main_button.dart';

class PhotoModal extends StatefulWidget {
  const PhotoModal({
    required this.onChooseImage,
    super.key,
  });
  final void Function(File image) onChooseImage;

  @override
  State<PhotoModal> createState() => _PhotoModalState();
}

class _PhotoModalState extends State<PhotoModal> {
  Future<void> _choosePhoto(ImageSource source) async {
    final ImagePicker picker = ImagePicker();

    final XFile? image = await picker.pickImage(source: source);

    if (image == null) return;

    widget.onChooseImage(File(image.path));
    if (!mounted) return;
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 8,
        ),
        MainButton(
            onPressed: () async {
              await _choosePhoto(ImageSource.gallery);
            },
            text: "Wybierz z galerii"),
        const SizedBox(
          width: 16,
        ),
        MainButton(
            onPressed: () async {
              await _choosePhoto(
                ImageSource.camera,
              );
            },
            text: "Zrób zdjęcie")
      ],
    );
  }
}
