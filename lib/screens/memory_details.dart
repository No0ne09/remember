import 'package:flutter/material.dart';
import 'package:remember/helpers/functions.dart';
import 'package:remember/widgets/buttons/main_button.dart';
import 'package:remember/widgets/custom_cached_image.dart';
import 'package:remember/widgets/decoration/title_widget.dart';

class MemoryDetails extends StatefulWidget {
  const MemoryDetails({required this.data, super.key});
  final Map<String, dynamic> data;

  @override
  State<MemoryDetails> createState() => _MemoryDetailsState();
}

class _MemoryDetailsState extends State<MemoryDetails> {
  void _showFullScreenImage() {
    showDialog(
      barrierColor: Colors.black,
      context: context,
      builder: (context) {
        return GestureDetector(
          child: Hero(
            tag: widget.data["imageUrl"],
            child: CustomCachedImage(
              imageUrl: widget.data['imageUrl'],
              fit: BoxFit.contain,
            ),
          ),
          onTap: () {
            Navigator.pop(context);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const TitleWidget(),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.star))],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: Colors.red,
                child: SizedBox(
                  width: width,
                  height: height / 2,
                  child: PageView(
                    children: [
                      GestureDetector(
                        onLongPress: _showFullScreenImage,
                        child: Hero(
                            tag: widget.data['imageUrl'],
                            child: CustomCachedImage(
                              imageUrl: widget.data['imageUrl'],
                              fit: BoxFit.contain,
                            )),
                      ),
                      Container(
                        color: Colors.green,
                      )
                    ],
                  ),
                ),
              ),
              Text(
                textAlign: TextAlign.start,
                "${widget.data['memoryDate']}, ${widget.data['title']}",
                style: Theme.of(context)
                    .textTheme
                    .displaySmall!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              Container(
                color: Colors.red,
                child: Text(' ${widget.data['description']}',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.displaySmall),
              ),
              Row(
                children: [
                  Expanded(
                    child: CustomCachedImage(
                        imageUrl: getStaticMap(widget.data["geopoint"]),
                        fit: BoxFit.cover),
                  ),
                  Text(widget.data["address"])
                ],
              ),
              Row(
                children: [
                  MainButton(
                    text: "Zapisz",
                    onPressed: () {},
                  ),
                  MainButton(
                    text: "Usuń",
                    onPressed: () {},
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
