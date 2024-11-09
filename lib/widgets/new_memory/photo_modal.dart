import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:remember/helpers/strings.dart';
import 'package:remember/widgets/buttons/exit_button.dart';

import 'package:remember/widgets/new_memory/photo_modal_button.dart';

class PhotoModal extends StatelessWidget {
  const PhotoModal({
    required this.onChooseImage,
    super.key,
  });
  final void Function(File image) onChooseImage;

  Future<void> _choosePhoto(ImageSource source, BuildContext context) async {
    final ImagePicker picker = ImagePicker();

    final XFile? image = await picker.pickImage(source: source);

    if (image == null) return;

    onChooseImage(File(image.path));
    if (!context.mounted) return;
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
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: PhotoModalButton(
                      onTap: () async {
                        await _choosePhoto(ImageSource.gallery, context);
                      },
                      text: pickGallery,
                      icon: Icons.image_rounded,
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: PhotoModalButton(
                      onTap: () async {
                        await _choosePhoto(ImageSource.camera, context);
                      },
                      text: takePhoto,
                      icon: Icons.camera_enhance_rounded,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
