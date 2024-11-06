import 'dart:io';

import 'package:flutter/material.dart';
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
  Future<void> _retrievePhoto() async {
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
    return Column(
      children: [
        InkWell(
          onTap: () async {
            await _retrievePhoto();
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black,
              border: Border.all(),
              borderRadius: BorderRadius.circular(40),
            ),
            height: MediaQuery.of(context).size.width,
            width: double.infinity,
            alignment: Alignment.center,
            child: _chosenPhoto != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(40),
                    child: Image.file(
                      _chosenPhoto!,
                      fit: BoxFit.contain,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  )
                : const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          size: 50,
                          Icons.camera_alt,
                          color: Colors.white,
                        ),
                        Text(
                          "Nie wybrano zdjęcia",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
          ),
        ),
      ],
    );
  }
}
