import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:remember/helpers/constants.dart';
import 'package:remember/helpers/strings.dart';
import 'package:remember/widgets/popups/info_popup.dart';

void showToast(
  String text,
  BuildContext context,
) {
  final scheme = Theme.of(context).colorScheme;
  final ftoast = FToast().init(context);
  ftoast.showToast(
    toastDuration: const Duration(seconds: 5),
    gravity: ToastGravity.BOTTOM,
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: scheme.inverseSurface,
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 20,
          color: scheme.onInverseSurface,
        ),
      ),
    ),
  );
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

Future<void> handleFirebaseError(String code, BuildContext context) async {
  String message;
  switch (code) {
    case 'invalid-credential':
      message = invalidCredentials;
    case 'network-request-failed':
      message = noConnection;
    case 'email-already-in-use':
      message = emailTaken;
    case 'invalid-email':
      message = invalidEmail;
    case 'unavailable':
      message = serviceUnavailable;
    case 'canceled':
      return;
    default:
      message = unknownError;
  }
  await showInfoPopup(
    context,
    message,
  );
}

Future<void> showInfoPopup(BuildContext context, String desc,
    {String title = error}) async {
  await showDialog(
    context: context,
    builder: (context) => InfoPopup(title: title, desc: desc),
    barrierDismissible: false,
  );
}

String getStaticMap(GeoPoint location) {
  final lat = location.latitude;
  final lng = location.longitude;

  return 'https://maps.googleapis.com/maps/api/staticmap?center=$lat,$lng&zoom=17&size=600x600&maptype=roadmap&markers=color:red%7Clabel:""%7C$lat,$lng&key=$apiKey';
}

Future<String> get appVersion async {
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  return packageInfo.version;
}
