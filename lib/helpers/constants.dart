import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:uuid/uuid.dart';

final textFieldBorder = OutlineInputBorder(
  borderRadius: defaultBorderRadius,
  borderSide: const BorderSide(color: Colors.transparent),
);
final defaultBorderRadius = BorderRadius.circular(25);
const zoom = 17.0;
final apiKey = dotenv.env["API_KEY"];
const uuid = Uuid();
