import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exif/exif.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:remember/helpers/constants.dart';

import 'package:remember/helpers/functions.dart';
import 'package:remember/helpers/validators.dart';
import 'package:remember/models/map_data.dart';
import 'package:remember/widgets/base_textfield.dart';
import 'package:remember/widgets/main_button.dart';
import 'package:remember/widgets/multiline_textfield.dart';
import 'package:remember/widgets/new_memory/new_location_widget.dart';
import 'package:remember/widgets/new_memory/new_photo_widget.dart';
import 'package:uuid/uuid.dart';

class NewMemory extends StatefulWidget {
  const NewMemory({super.key});

  @override
  State<NewMemory> createState() => _NewMemoryState();
}

class _NewMemoryState extends State<NewMemory> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  File? _chosenImage;
  String? _chosenDate;
  MapData? _chosenLocation;

  Future<void> _checkDateTime() async {
    if (_chosenImage == null) return;
    final exif = await readExifFromFile(_chosenImage!);
    final exifDateTime = exif["EXIF DateTimeOriginal"]?.toString();

    if (exifDateTime == null) return;
    final tempDateTime =
        DateTime.tryParse(exifDateTime.substring(0, 10).replaceAll(":", '-'));

    _formatDate(tempDateTime);
  }

  Future<void> _pickDateTime() async {
    final tempDateTime = await showDatePicker(
      locale: const Locale("pl"),
      initialDate: _chosenDate == null
          ? DateTime.now()
          : DateTime.tryParse(_chosenDate!),
      context: context,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime.now(),
    );
    _formatDate(tempDateTime);
  }

  void _formatDate(DateTime? tempDateTime) {
    if (tempDateTime == null) return;
    final dateTime = getFormattedDate(tempDateTime);
    setState(() {
      _chosenDate = dateTime;
    });
  }

  Future<void> _submitMemory() async {
    if (!_formKey.currentState!.validate() ||
        _chosenImage == null ||
        _chosenDate == null ||
        _chosenLocation == null) {
      await showInfoPopup(
          context, "Upewnij się, że uzupełniłeś wszystkie pola.");
      return;
    }
    final status = await checkConnection();
    if (!status) {
      if (!mounted) return;
      await showInfoPopup(context, "Brak połączenia z internetem.");
      return;
    }
    final title = _titleController.text;
    final desc = _descriptionController.text;
    final user = FirebaseAuth.instance.currentUser!;
    final id = uuid.v4();
    final storageRef = FirebaseStorage.instance
        .ref()
        .child('user_memories')
        .child(user.uid)
        .child('$id.jpg');

    await storageRef.putFile(_chosenImage!);
    final imageUrl = await storageRef.getDownloadURL();

    await FirebaseFirestore.instance
        .collection('memories by user')
        .doc(user.uid)
        .collection("memories")
        .doc(id)
        .set({
      "geopoint": _chosenLocation!.coordinates,
      "address": _chosenLocation!.address,
      "title": title,
      "description": desc,
      "dateTime": _chosenDate,
      "username": user.displayName,
      "Email": user.email,
      "imageUrl": imageUrl,
    });
    print("test");
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
        child: Form(
          key: _formKey,
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
              Stack(
                alignment: Alignment.center,
                children: [
                  NewPhotoWidget(
                    onChooseImage: (image) async {
                      setState(() {
                        _chosenImage = image;
                      });
                      await _checkDateTime();
                    },
                  ),
                  Positioned(
                    bottom: 8,
                    child: MainButton(
                      backgroundColor: Colors.blue,
                      onPressed: () async {
                        await _pickDateTime();
                      },
                      text:
                          _chosenDate == null ? "Data nieznana" : _chosenDate!,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              const SizedBox(
                height: 8,
              ),
              NewLocationWidget(
                onPickedLocation: (locationInfo) {
                  setState(() {
                    _chosenLocation = locationInfo;
                  });
                },
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
                onPressed: _submitMemory,
                text: "Save memory",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
