import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:remember/helpers/functions.dart';
import 'package:remember/widgets/custom_app_bar.dart';

class ContentScreen extends StatefulWidget {
  const ContentScreen({super.key});

  @override
  State<ContentScreen> createState() => _ContentScreenState();
}

class _ContentScreenState extends State<ContentScreen> {
  int counter = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: kIsWeb ? null : const CustomAppBar(),
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Re(me)mber"),
            SizedBox(
              height: kToolbarHeight,
              child: Image.asset("assets/logo.png"),
            )
          ],
        ),
        bottom: kIsWeb
            ? const PreferredSize(
                preferredSize: Size.fromHeight(kToolbarHeight),
                child: CustomAppBar(),
              )
            : null,
        actions: [
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: Center(
        child: ElevatedButton(
            onPressed: () async {
              final status = await checkConnection();
              if (!status) {
                return;
              }
              await FirebaseFirestore.instance
                  .collection("test")
                  .add({"test1": "test2"});
            },
            child: const Text("siup")),
      ),
    );
  }
}
