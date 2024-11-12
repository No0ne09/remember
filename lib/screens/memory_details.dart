import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gal/gal.dart';
import 'package:remember/helpers/functions.dart';
import 'package:remember/helpers/strings.dart';
import 'package:remember/widgets/buttons/main_button.dart';
import 'package:remember/widgets/decoration/background.dart';
import 'package:remember/widgets/decoration/title_widget.dart';
import 'package:remember/widgets/memory_details/memory_pageview.dart';
import 'package:path_provider/path_provider.dart';

class MemoryDetails extends StatefulWidget {
  const MemoryDetails({required this.data, super.key});
  final Map<String, dynamic> data;

  @override
  State<MemoryDetails> createState() => _MemoryDetailsState();
}

class _MemoryDetailsState extends State<MemoryDetails> {
  Widget get _dataColumn {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          '${widget.data['description']}',
          style: Theme.of(context).textTheme.headlineMedium,
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 12,
        ),
        Text(
          "${widget.data["address"]}\n${widget.data['memoryDate']}",
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Future<void> _downloadImage() async {
    final status = await checkConnection();
    if (!status) {
      if (!mounted) return;
      await showInfoPopup(context, noConnection);
      return;
    }
    final directory = await getDownloadsDirectory();
    final path = '${directory!.path}/${widget.data["title"]}.jpg';
    try {
      await Dio().download(widget.data['imageUrl'], path);
    } on SocketException catch (_) {
      if (!mounted) return;
      await showInfoPopup(context, noConnection);
      return;
    } catch (_) {
      if (!mounted) return;
      await showInfoPopup(context, unknownError);
      return;
    }
    await Gal.putImage(path);
    final file = File(path);
    await file.delete();
    if (!mounted) return;
    showToast(imageSaved, context);
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final landscape = width > height;
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        automaticallyImplyLeading: !kIsWeb,
        title: const TitleWidget(),
        actions: [
          if (!kIsWeb)
            IconButton(
              onPressed: _downloadImage,
              icon: const Icon(Icons.download),
            ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.star),
          ),
        ],
      ),
      body: Background(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    textAlign: TextAlign.center,
                    widget.data['title'],
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
                            imageUrl: widget.data['imageUrl'],
                            location: widget.data["geopoint"],
                            title: widget.data['title'],
                          ),
                        ),
                        if (landscape)
                          Expanded(
                            child: _dataColumn,
                          ),
                      ],
                    ),
                  ),
                  if (!landscape)
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: _dataColumn,
                      ),
                    ),
                  const SizedBox(
                    height: 8,
                  ),
                  MainButton(
                    text: "Usuń",
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
