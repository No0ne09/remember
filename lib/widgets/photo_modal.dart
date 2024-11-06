import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:remember/widgets/exit_button.dart';
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
            Expanded(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
