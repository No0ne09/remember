import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:uuid/uuid.dart';

final textFieldBorder = OutlineInputBorder(
  borderRadius: defaultBorderRadius,
  borderSide: const BorderSide(color: Colors.transparent),
);
final defaultBorderRadius = BorderRadius.circular(25);
const zoom = 17.0;
final apiKey = dotenv.env["API_KEY"];
const uuid = Uuid();
GlobalKey<ConvexAppBarState> appBarKey = GlobalKey<ConvexAppBarState>();
const backgroundDecoration = BoxDecoration(
  image: DecorationImage(
      opacity: 0.1,
      fit: BoxFit.contain,
      image: Svg(
        'assets/background.svg',
        color: Colors.transparent,
      )),
);
const contactMail = "bplociennik03@gmail.com";
const subject = "Re(me)mber - Kontakt";
