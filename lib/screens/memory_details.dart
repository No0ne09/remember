import 'package:flutter/material.dart';
import 'package:remember/widgets/buttons/main_button.dart';
import 'package:remember/widgets/custom_cached_image.dart';

class MemoryDetails extends StatelessWidget {
  const MemoryDetails({required this.data, super.key});
  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Hero(
                  tag: data['imageUrl'],
                  child: CustomCachedImage(imageUrl: data['imageUrl'])),
              Text(data['title']),
              Text(data['memoryDate']),
              Text(data['description']),
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
