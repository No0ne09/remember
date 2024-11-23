import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exif/exif.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:remember/helpers/constants.dart';
import 'package:remember/helpers/functions.dart';
import 'package:remember/helpers/providers.dart';
import 'package:remember/helpers/strings.dart';
import 'package:remember/helpers/validators.dart';
import 'package:remember/models/map_data.dart';
import 'package:remember/widgets/textfields/base_textfield.dart';
import 'package:remember/widgets/buttons/main_button.dart';
import 'package:remember/widgets/textfields/multiline_textfield.dart';
import 'package:remember/widgets/new_memory/new_location_widget.dart';
import 'package:remember/widgets/new_memory/new_photo_widget.dart';

class NewMemory extends ConsumerStatefulWidget {
  const NewMemory({super.key});

  @override
  ConsumerState<NewMemory> createState() => _NewMemoryState();
}

class _NewMemoryState extends ConsumerState<NewMemory> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  File? _chosenImage;
  String? _chosenDate;
  MapData? _chosenLocation;
  bool _isSubmitting = false;

  Future<void> _checkDateTime() async {
    if (_chosenImage == null) return;
    final exif = await readExifFromFile(_chosenImage!);
    final exifDateTime = exif["EXIF DateTimeOriginal"]?.toString();

    if (exifDateTime == null) {
      if (!mounted) return;
      await showInfoPopup(context, noExif, title: warning);
      return;
    }
    setState(() {
      _chosenDate = exifDateTime.split(' ')[0].replaceAll(':', '-');
    });
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
    if (tempDateTime == null) return;
    setState(() {
      _chosenDate = tempDateTime.toString().split(' ')[0];
    });
  }

  Future<String?> _uploadImage(User user, String id) async {
    final storageRef = FirebaseStorage.instance
        .ref()
        .child(firebaseDbKeys['user_memories']!)
        .child(user.uid)
        .child('$id.jpg');
    try {
      final uploadTask = storageRef.putFile(_chosenImage!);
      await uploadTask.timeout(
        const Duration(seconds: 30),
        onTimeout: () async {
          await uploadTask.cancel();
          throw TimeoutException(
            uploadError,
          );
        },
      );
      final url = await storageRef.getDownloadURL();
      return url;
    } on TimeoutException catch (e) {
      if (!mounted) return null;
      showInfoPopup(context, e.message!);
      return null;
    } on FirebaseException catch (e) {
      if (!mounted) return null;
      await handleFireBaseError(e.code, context);
      return null;
    } catch (_) {
      if (!mounted) return null;
      await showInfoPopup(context, unknownError);
      return null;
    }
  }

  Future<void> _submitMemory() async {
    if (!_formKey.currentState!.validate() ||
        _chosenImage == null ||
        _chosenDate == null ||
        _chosenLocation == null) {
      await showInfoPopup(context, notFilled);
      return;
    }
    final status = await checkConnection();
    if (!status) {
      if (!mounted) return;
      await showInfoPopup(context, noConnection);
      return;
    }
    setState(() {
      _isSubmitting = true;
    });
    final title = _titleController.text.trim();
    final desc = _descriptionController.text.trim();
    final user = FirebaseAuth.instance.currentUser!;
    final id = uuid.v4();
    final imageUrl = await _uploadImage(user, id);
    if (imageUrl == null) {
      if (!mounted) return;
      setState(() {
        _isSubmitting = false;
      });
      return;
    }
    try {
      await FirebaseFirestore.instance
          .collection(firebaseDbKeys['memories_by_user']!)
          .doc(user.uid)
          .collection(firebaseDbKeys["memories"]!)
          .doc(id)
          .set({
        firebaseDataKeys["geopoint"]!: _chosenLocation!.coordinates,
        firebaseDataKeys["address"]!: _chosenLocation!.address,
        firebaseDataKeys["title"]!: title,
        firebaseDataKeys["description"]!: desc,
        firebaseDataKeys["memoryDate"]!: _chosenDate,
        firebaseDataKeys["uploadTimeStamp"]!: Timestamp.now(),
        firebaseDataKeys["username"]!: user.displayName,
        firebaseDataKeys["email"]!: user.email,
        firebaseDataKeys["userId"]!: user.uid,
        firebaseDataKeys["imageUrl"]!: imageUrl,
        firebaseDataKeys["isFavourite"]!: false,
      });
    } on FirebaseException catch (e) {
      if (!mounted) return;
      await handleFireBaseError(e.code, context);
      return;
    } catch (_) {
      if (!mounted) return;
      await showInfoPopup(context, unknownError);
      return;
    } finally {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
      }
    }

    appBarKey.currentState!.animateTo(0);
    ref.read(indexProvider.notifier).state = 0;
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
                hint: nameMemory,
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
                      onPressed: () async {
                        await _pickDateTime();
                      },
                      text: _chosenDate == null ? unknownDate : _chosenDate!,
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
                label: describeMemory,
                controller: _descriptionController,
              ),
              const SizedBox(
                height: 8,
              ),
              _isSubmitting
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : MainButton(
                      onPressed: _submitMemory,
                      text: saveMemory,
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
