import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:remember/widgets/buttons/main_button.dart';
import 'package:remember/widgets/decoration/background.dart';
import 'package:remember/widgets/decoration/title_widget.dart';
import 'package:remember/widgets/memory_details/memory_pageview.dart';

class MemoryDetails extends StatefulWidget {
  const MemoryDetails({required this.data, super.key});
  final Map<String, dynamic> data;

  @override
  State<MemoryDetails> createState() => _MemoryDetailsState();
}

class _MemoryDetailsState extends State<MemoryDetails> {
  Widget get dataColum {
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
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.star))],
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
                            child: dataColum,
                          ),
                      ],
                    ),
                  ),
                  if (!landscape)
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: dataColum,
                      ),
                    ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
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
