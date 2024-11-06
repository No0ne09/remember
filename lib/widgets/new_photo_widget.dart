import 'dart:io';

import 'package:flutter/material.dart';
import 'package:remember/helpers/constants.dart';
import 'package:remember/widgets/new_memory_container.dart';
import 'package:remember/widgets/photo_modal.dart';

class NewPhotoWidget extends StatefulWidget {
  const NewPhotoWidget({
    required this.onChooseImage,
    super.key,
  });
  final void Function(File image) onChooseImage;
  @override
  State<NewPhotoWidget> createState() => _NewPhotoWidgetState();
}

class _NewPhotoWidgetState extends State<NewPhotoWidget> {
  File? _chosenPhoto;
  Future<void> _showPhotoModal() async {
    await showModalBottomSheet(
      context: context,
      builder: (context) {
        return PhotoModal(
          onChooseImage: (image) {
            widget.onChooseImage(image);
            setState(() {
              _chosenPhoto = image;
            });
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return NewMemoryContainer(
      height: MediaQuery.of(context).size.width,
      text: "Nie wybrano zdjęcia",
      icon: Icons.camera_alt,
      onTap: () async {
        await _showPhotoModal();
      },
      child: _chosenPhoto != null
          ? ClipRRect(
              borderRadius: defaultBorderRadius,
              child: Image.file(
                _chosenPhoto!,
                fit: BoxFit.contain,
                width: double.infinity,
                height: double.infinity,
              ),
            )
          : null,
    );
  }
}
