import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:remember/helpers/functions.dart';
import 'package:remember/helpers/strings.dart';
import 'package:remember/screens/base_map_screen.dart';
import 'package:remember/screens/memory_details.dart';
import 'package:remember/widgets/layout/infotext.dart';

class MemoriesMap extends StatefulWidget {
  const MemoriesMap({super.key});

  @override
  State<MemoriesMap> createState() => _MemoriesMapState();
}

class _MemoriesMapState extends State<MemoriesMap> {
  late final Future<Set<Marker>> _markers;

  Future<Set<Marker>> _getMarkers() async {
    final Set<Marker> markers = {};
    final user = FirebaseAuth.instance.currentUser!;
    try {
      final docs = await FirebaseFirestore.instance
          .collection('memories_by_user')
          .doc(user.uid)
          .collection("memories")
          .orderBy("uploadTimeStamp", descending: true)
          .get();
      for (final doc in docs.docs) {
        final data = doc.data();
        markers.add(
          Marker(
            markerId: MarkerId(doc.id),
            infoWindow: InfoWindow(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => MemoryDetails(data: data, id: doc.id),
                  ),
                );
              },
              title: data["memoryDate"],
              snippet: data["title"],
            ),
            position: LatLng(
              data["geopoint"].latitude,
              data["geopoint"].longitude,
            ),
          ),
        );
      }
    } on FirebaseException catch (e) {
      if (!mounted) return {};
      handleFireBaseError(e.code, context);
      return {};
    }

    return markers;
  }

  @override
  void initState() {
    super.initState();
    _markers = _getMarkers();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _markers,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.hasError) {
          return const Infotext(text: unknownError);
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Infotext(text: noMemories);
        }

        return BaseMapScreen(
          isSelecting: false,
          markers: snapshot.data!,
          initialPosition: snapshot.data!.first.position,
        );
      },
    );
  }
}
