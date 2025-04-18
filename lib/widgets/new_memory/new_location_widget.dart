import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:remember/helpers/constants.dart';
import 'package:remember/helpers/functions.dart';
import 'package:remember/helpers/strings.dart';
import 'package:remember/models/map_data.dart';
import 'package:remember/screens/base_map_screen.dart';
import 'package:remember/widgets/layout/custom_cached_image.dart';
import 'package:remember/widgets/new_memory/new_memory_container.dart';
import 'package:http/http.dart' as http;

class NewLocationWidget extends StatefulWidget {
  const NewLocationWidget({required this.onPickedLocation, super.key});

  final void Function(MapData locationInfo) onPickedLocation;
  @override
  State<NewLocationWidget> createState() => _NewLocationWidgetState();
}

class _NewLocationWidgetState extends State<NewLocationWidget> {
  String? _imageUrl;

  Future<void> _getLocation() async {
    final GeoPoint? coordinates =
        await Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const BaseMapScreen(isSelecting: true),
    ));
    if (coordinates == null) return;
    final address = await _getAddress(coordinates);
    if (address == null) return;
    if (!mounted) return;
    setState(() {
      _imageUrl = getStaticMap(coordinates);
    });
    widget
        .onPickedLocation(MapData(coordinates: coordinates, address: address));
  }

  Future<String?> _getAddress(GeoPoint coordinates) async {
    final status = await checkConnection();
    if (!status) {
      if (!mounted) return null;
      await showInfoPopup(context, noConnection);
      return null;
    }
    final lat = coordinates.latitude;
    final lng = coordinates.longitude;

    try {
      final url = Uri.parse(
          'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&language=pl&key=$apiKey');
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final resData = json.decode(response.body);
        final String address = resData['results'][0]['formatted_address'];
        return address;
      }
    } on SocketException {
      if (!mounted) return null;
      await showInfoPopup(context, noConnection);
      return null;
    } catch (_) {
      if (!mounted) return null;
      await showInfoPopup(context, unknownError);
      return null;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return NewMemoryContainer(
      height: MediaQuery.sizeOf(context).height / 4,
      text: noLocationChosen,
      icon: Icons.location_off,
      onTap: _getLocation,
      child: _imageUrl == null
          ? null
          : CustomCachedImage(
              imageUrl: _imageUrl!,
            ),
    );
  }
}
