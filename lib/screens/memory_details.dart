import 'package:flutter/material.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: const TitleWidget(),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.star))],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              GestureDetector(
                onLongPress: _showFullScreenImage,
                child: Hero(
                    tag: widget.data['imageUrl'],
                    child: CustomCachedImage(
                      imageUrl: widget.data['imageUrl'],
                      fit: BoxFit.cover,
                    )),
              ),
              Text(widget.data['title']),
              Text(widget.data['memoryDate']),
              Text(widget.data['description']),
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
