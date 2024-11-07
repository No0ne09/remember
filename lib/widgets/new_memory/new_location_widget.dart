import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:remember/helpers/constants.dart';
import 'package:remember/helpers/functions.dart';
import 'package:remember/screens/map_screen.dart';
import 'package:remember/widgets/new_memory/new_memory_container.dart';
import 'package:http/http.dart' as http;

class NewLocationWidget extends StatefulWidget {
  const NewLocationWidget({super.key});

  @override
  State<NewLocationWidget> createState() => _NewLocationWidgetState();
}

class _NewLocationWidgetState extends State<NewLocationWidget> {
  String? _imageUrl;
  Future<void> _getLocation() async {
    final GeoPoint? location =
        await Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const MapScreen(isSelecting: true),
    ));
    if (location == null) return;
    final address = await _getAddress(location);
    if (address == null) return;
    setState(() {
      _imageUrl = getStaticMap(location);
    });
  }

  Future<String?> _getAddress(GeoPoint location) async {
    final status = await checkConnection();
    if (!status) {
      if (!mounted) return null;
      await showInfoPopup(context, "Brak połączenia z internetem.");
      return null;
    }
    final lat = location.latitude;
    final lng = location.longitude;

    try {
      final url = Uri.parse(
          'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=$apiKey');
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final resData = json.decode(response.body);
        final String address = resData['results'][0]['formatted_address'];
        return address;
      }
    } on SocketException {
      if (!mounted) return null;
      await showInfoPopup(context, "Brak połączenia z internetem.");
      return null;
    } catch (e) {
      if (!mounted) return null;
      await showInfoPopup(context, "Wystąpił błąd. Spróbuj ponownie później");
      return null;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return NewMemoryContainer(
      height: MediaQuery.of(context).size.height / 4,
      text: "Nie podano lokalizacji",
      icon: Icons.location_off,
      onTap: () async {
        _getLocation();
      },
      child: _imageUrl == null
          ? null
          : CachedNetworkImage(
              imageUrl: _imageUrl!,
              fit: BoxFit.cover,
            ),
    );
  }
}
