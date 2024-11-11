import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:remember/helpers/constants.dart';
import 'package:remember/helpers/strings.dart';
import 'package:remember/widgets/popups/info_popup.dart';

void showToast(
  String text,
  BuildContext context,
) {
  final ftoast = FToast().init(context);
  ftoast.showToast(
    toastDuration: const Duration(seconds: 5),
    gravity: ToastGravity.BOTTOM,
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Theme.of(context).colorScheme.primaryContainer,
      ),
      child: Text(
        text,
        style: const TextStyle(color: Colors.black, fontSize: 20),
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

String getFormattedDate(DateTime date) {
  return DateFormat("yyyy-MM-dd").format(date);
}

Future<void> handleFireBaseError(String code, BuildContext context) async {
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
  );
}

String getStaticMap(GeoPoint location) {
  final lat = location.latitude;
  final lng = location.longitude;
  return 'https://maps.googleapis.com/maps/api/staticmap?center=$lat,$lng=&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C$lat,$lng&key=$apiKey';
}

Future<String> getAppVersion() async {
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  return packageInfo.version;
}

BoxDecoration getBackgroundDecoration(BuildContext context) {
  return BoxDecoration(
    image: DecorationImage(
        colorFilter: ColorFilter.mode(
          Theme.of(context).colorScheme.primary,
          BlendMode.srcIn,
        ),
        opacity: 0.1,
        fit: BoxFit.contain,
        image: const Svg(
          'assets/background.svg',
          color: Colors.transparent,
        )),
  );
}
