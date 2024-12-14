import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:uuid/uuid.dart';

const zoom = 16.3;
final apiKey = dotenv.env["API_KEY"];
const uuid = Uuid();
GlobalKey<ConvexAppBarState> appBarKey = GlobalKey<ConvexAppBarState>();

const contactMail = "bplociennik03@gmail.com";
const subject = "Re(me)mber - Kontakt";
const reportBugUrl = "https://forms.gle/19q6WbGBDQN4y2sN9";
const autoReportUrl =
    'https://docs.google.com/forms/u/0/d/e/1FAIpQLSfc8LHOvEqb0dS7zJU6C3kidwxaDK9a3xxenTMzck-4PwkAKg/formResponse';
const Map<String, String> firebaseDataKeys = {
  "geopoint": "geopoint",
  "address": "address",
  "title": "title",
  "description": "description",
  "memoryDate": "memoryDate",
  "uploadTimeStamp": "uploadTimeStamp",
  "username": "username",
  "email": "email",
  "userId": "userId",
  "imageUrl": "imageUrl",
  "isFavourite": "isFavourite",
};
const Map<String, String> firebaseDbKeys = {
  'memories_by_user': 'memories_by_user',
  "memories": "memories",
  'user_memories': 'user_memories',
};
