import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class NewPhotoWidget extends StatefulWidget {
  const NewPhotoWidget({super.key});

  @override
  State<NewPhotoWidget> createState() => _NewPhotoWidgetState();
}

class _NewPhotoWidgetState extends State<NewPhotoWidget> {
  File? _chosenPhoto;
  Future<void> _choosePhoto(ImageSource source) async {
    final ImagePicker picker = ImagePicker();

    final XFile? image = await picker.pickImage(source: source);
    if (image == null) {
      return;
    }
    setState(() {
      _chosenPhoto = File(image.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
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
        SizedBox(
          height: 8,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () async {
                  await _choosePhoto(ImageSource.gallery);
                },
                child: Text("Wybierz z galerii"),
              ),
            ),
            SizedBox(
              width: 16,
            ),
            Expanded(
              child: ElevatedButton(
                onPressed: () async {
                  await _choosePhoto(
                    ImageSource.camera,
                  );
                },
                child: Text("Zrób nowe zdjęcie"),
              ),
            ),
          ],
        )
      ],
    );
  }
}
