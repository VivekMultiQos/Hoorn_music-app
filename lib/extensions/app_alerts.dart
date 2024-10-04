import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:music_app/ui/common/alerts/custom_alert.dart';

class AppAlerts {
  static void showToastAlert({String message = '', ToastGravity gravity = ToastGravity.BOTTOM}) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: gravity,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.white,
        textColor: Colors.black,
        fontSize: 16.0);
  }

  static void showErrorDialog(BuildContext context, String errorMessage) {
    CustomAlert.showAlert(
      errorMessage,
      btnFirst: "Ok",
      handler: (index) async {},
    );
  }
}