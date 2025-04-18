import 'dart:io';

import 'package:flutter/material.dart';
import 'package:remember/helpers/theme.dart';
import 'package:remember/helpers/strings.dart';
import 'package:remember/widgets/new_memory/new_memory_container.dart';
import 'package:remember/widgets/new_memory/photo_modal.dart';

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
      constraints: const BoxConstraints.expand(),
      context: context,
      builder: (context) {
        return PhotoModal(
          onChooseImage: (image) {
            setState(() {
              _chosenPhoto = image;
            });
            widget.onChooseImage(image);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return NewMemoryContainer(
      height: MediaQuery.sizeOf(context).width,
      text: noPhotoChosen,
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
