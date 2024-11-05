import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
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

Future<void> handleAuthError(
    FirebaseAuthException e, BuildContext context) async {
  String message;
  switch (e.code) {
    case 'invalid-credential':
      message = "Upewnij się, że dane są poprawne.";
    case 'network-request-failed':
      message = "Upewnij się, posiadasz połączenie z internetem.";
    case 'email-already-in-use':
      message = "Istnieje już konto powiązane z tym adresem email.";
    case 'invalid-email':
      message = "Upewnij się, podany adres email jest poprawny.";
    default:
      message = "Wystąpił nieznany błąd.";
  }
  await showDialog(
    context: context,
    builder: (context) => InfoPopup(title: "Błąd", desc: message),
  );
}
