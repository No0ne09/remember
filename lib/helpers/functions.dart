import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:remember/helpers/constants.dart';
import 'package:remember/widgets/info_popup.dart';

void showToast(String text) {
  Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      fontSize: 16.0);
}

Future<bool> checkConnection() async {
  final result = await Connectivity().checkConnectivity();

  if (result.contains(ConnectivityResult.wifi) ||
      result.contains(ConnectivityResult.mobile) ||
      result.contains(ConnectivityResult.ethernet)) {
    return true;
  }
  return false;
}

String getFormattedDate(DateTime date) {
  return DateFormat("yyyy-MM-dd").format(date);
}

Future<void> handleFireBaseError(String code, BuildContext context) async {
  String message;
  switch (code) {
    case 'invalid-credential':
      message = "Upewnij się, że dane są poprawne.";
    case 'network-request-failed':
      message = "Upewnij się, posiadasz połączenie z internetem.";
    case 'email-already-in-use':
      message = "Istnieje już konto powiązane z tym adresem email.";
    case 'invalid-email':
      message = "Upewnij się, podany adres email jest poprawny.";
    case 'unavailable':
      message =
          "Nasze usługi są chwilowo niedostępne spróbuj ponownie później.";
    default:
      message = "Wystąpił nieznany błąd. Spróbuj ponownie później.";
  }
  await showInfoPopup(
    context,
    message,
  );
}

Future<void> showInfoPopup(BuildContext context, String desc,
    {String title = "Błąd"}) async {
  await showDialog(
    context: context,
    builder: (context) => InfoPopup(title: title, desc: desc),
  );
}

String getStaticMap(GeoPoint location) {
  final lat = location.latitude;
  final lng = location.longitude;
  return 'https://maps.googleapis.com/maps/api/staticmap?center=$lat,$lng=&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C$lat,$lng&key=$apiKey';
}
