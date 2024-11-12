import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:uuid/uuid.dart';

final defaultBorderRadius = BorderRadius.circular(25);
const zoom = 17.0;
final apiKey = dotenv.env["API_KEY"];
const uuid = Uuid();
GlobalKey<ConvexAppBarState> appBarKey = GlobalKey<ConvexAppBarState>();

const contactMail = "bplociennik03@gmail.com";
const subject = "Re(me)mber - Kontakt";
const reportBugUrl = "https://forms.gle/19q6WbGBDQN4y2sN9";
const autoReportUrl =
    'https://docs.google.com/forms/u/0/d/e/1FAIpQLSfc8LHOvEqb0dS7zJU6C3kidwxaDK9a3xxenTMzck-4PwkAKg/formResponse';
