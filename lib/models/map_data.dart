import 'package:cloud_firestore/cloud_firestore.dart';

class MapData {
  const MapData({
    required this.coordinates,
    required this.address,
  });
  final GeoPoint coordinates;
  final String address;
}
