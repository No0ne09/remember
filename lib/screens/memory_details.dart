import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gal/gal.dart';
import 'package:image_downloader_web/image_downloader_web.dart';
import 'package:remember/helpers/constants.dart';
import 'package:remember/helpers/functions.dart';
import 'package:remember/helpers/strings.dart';
import 'package:remember/widgets/buttons/main_button.dart';
import 'package:remember/widgets/layout/background.dart';
import 'package:remember/widgets/layout/title_widget.dart';
import 'package:remember/widgets/memory_details/memory_pageview.dart';
import 'package:path_provider/path_provider.dart';
import 'package:remember/widgets/popups/confirmation_popup.dart';

class MemoryDetails extends StatefulWidget {
  const MemoryDetails({
    required this.data,
    required this.id,
    super.key,
  });
  final Map<String, dynamic> data;
  final String id;

  @override
  State<MemoryDetails> createState() => _MemoryDetailsState();
}

class _MemoryDetailsState extends State<MemoryDetails> {
  bool _isDownloading = false;
  late bool _isFavourite;
  final _firestore = FirebaseFirestore.instance;
  final _user = FirebaseAuth.instance.currentUser!.uid;

  Widget get _memoryDetailsColumn {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          '${widget.data[firebaseDataKeys['description']!]}',
          style: Theme.of(context).textTheme.headlineMedium,
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 12,
        ),
        SelectableText(
          enableInteractiveSelection: kIsWeb,
          "${widget.data[firebaseDataKeys["address"]]!}\n${widget.data[firebaseDataKeys['memoryDate']]!}",
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Future<bool> _checkInternet() async {
    final status = await checkConnection();
    if (!status) {
      if (!mounted) return false;
      await showInfoPopup(context, noConnection);
      return false;
    }
    return true;
  }

  Future<void> _downloadImage() async {
    final check = await _checkInternet();
    if (!check) return;
    setState(() {
      _isDownloading = true;
    });
    kIsWeb
        ? await WebImageDownloader.downloadImageFromWeb(
            widget.data[firebaseDataKeys['imageUrl']!],
            imageType: ImageType.jpeg,
            name: widget.id)
        : await _downloadAndroid();
    if (!mounted) return;
    setState(() {
      _isDownloading = false;
    });
  }

  Future<void> _downloadAndroid() async {
    final directory = await getDownloadsDirectory();
    final path = '${directory!.path}/${widget.id}.jpg';
    try {
      await Dio().download(widget.data[firebaseDataKeys['imageUrl']!], path);
    } on SocketException catch (_) {
      if (!mounted) return;
      await showInfoPopup(context, noConnection);
      setState(() {
        _isDownloading = false;
      });
      return;
    } catch (_) {
      if (!mounted) return;
      await showInfoPopup(context, unknownError);
      setState(() {
        _isDownloading = false;
      });
      return;
    }
    await Gal.putImage(path);
    final file = File(path);
    await file.delete();
    if (!mounted) return;
    showToast(imageSaved, context);
  }

  Future<void> _deleteMemory() async {
    final status = await _checkInternet();
    if (!status || !mounted) return;
    final ensure = await showDialog(
      context: context,
      builder: (context) => const ConfirmationPopup(
        text: ensureErase,
      ),
    );
    if (ensure != true) return;
    try {
      _firestore
          .collection(firebaseDbKeys['memories_by_user']!)
          .doc(_user)
          .collection(firebaseDbKeys['memories']!)
          .doc(widget.id)
          .delete();
      final image = FirebaseStorage.instance
          .ref()
          .child(firebaseDbKeys['user_memories']!)
          .child(_user)
          .child('${widget.id}.jpg');
      image.delete();
    } on FirebaseException catch (e) {
      if (!mounted) return;
      await handleFireBaseError(e.code, context);
      return;
    } catch (_) {
      if (!mounted) return;
      await showInfoPopup(context, unknownError);
      return;
    }
    if (!mounted) return;
    Navigator.pop(context);
  }

  void _toggleFavourite() {
    setState(() {
      _isFavourite = !_isFavourite;
    });
    try {
      _firestore
          .collection(firebaseDbKeys['memories_by_user']!)
          .doc(_user)
          .collection(firebaseDbKeys['memories']!)
          .doc(widget.id)
          .update({firebaseDataKeys["isFavourite"]!: _isFavourite});
    } on FirebaseException catch (e) {
      if (!mounted) return;
      handleFireBaseError(e.code, context);
    }
  }

  @override
  void initState() {
    super.initState();
    _isFavourite = widget.data[firebaseDataKeys["isFavourite"]!];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: const TitleWidget(),
        actions: [
          Tooltip(
            message: download,
            child: IconButton(
              onPressed: _isDownloading ? null : _downloadImage,
              icon: _isDownloading
                  ? const CircularProgressIndicator()
                  : const Icon(Icons.download),
            ),
          ),
          Tooltip(
            message: toggleFavourite,
            child: IconButton(
              onPressed: _toggleFavourite,
              icon: _isFavourite
                  ? const Icon(Icons.star)
                  : const Icon(Icons.star_border),
            ),
          ),
        ],
      ),
      body: Background(
        child: Center(
          child: LayoutBuilder(builder: (context, constraints) {
            final width = constraints.maxWidth;
            final height = constraints.maxHeight;
            final landscape = width > height;
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      textAlign: TextAlign.center,
                      widget.data[firebaseDataKeys['title']!],
                      style: Theme.of(context)
                          .textTheme
                          .displaySmall!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Card(
                      clipBehavior: Clip.antiAlias,
                      child: Row(
                        children: [
                          Expanded(
                            child: MemoryPageview(
                              size: Size(width, height),
                              imageUrl:
                                  widget.data[firebaseDataKeys['imageUrl']!],
                              location:
                                  widget.data[firebaseDataKeys["geopoint"]!],
                              title: widget.data[firebaseDataKeys['title']!],
                            ),
                          ),
                          if (landscape)
                            Expanded(
                              child: _memoryDetailsColumn,
                            ),
                        ],
                      ),
                    ),
                    if (!landscape)
                      SizedBox(
                        width: double.infinity,
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: _memoryDetailsColumn,
                          ),
                        ),
                      ),
                    const SizedBox(
                      height: 50,
                    ),
                    MainButton(
                      color: Colors.red,
                      text: eraseMemory,
                      onPressed: _deleteMemory,
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
