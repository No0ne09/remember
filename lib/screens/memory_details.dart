import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:remember/widgets/buttons/main_button.dart';
import 'package:remember/widgets/decoration/title_widget.dart';
import 'package:remember/widgets/memory_details/memory_pageview.dart';

class MemoryDetails extends StatefulWidget {
  const MemoryDetails({required this.data, super.key});
  final Map<String, dynamic> data;

  @override
  State<MemoryDetails> createState() => _MemoryDetailsState();
}

class _MemoryDetailsState extends State<MemoryDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: !kIsWeb,
        title: const TitleWidget(),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.star))],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MemoryPageview(
                imageUrl: widget.data['imageUrl'],
                location: widget.data["geopoint"],
                title: widget.data['title'],
              ),
              Text(
                textAlign: TextAlign.start,
                "${widget.data['memoryDate']},\n${widget.data['title']}",
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
              Text(widget.data["address"]),
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
