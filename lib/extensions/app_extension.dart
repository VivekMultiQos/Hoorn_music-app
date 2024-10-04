import 'dart:io';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:music_app/constant/import.dart';
import 'package:url_launcher/url_launcher.dart';

class AppHelper {
  static DateTime? _backButtonPressedTime;

  /// To check internet connectivity
  static Future<bool> checkConnectivity() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }

  // Handle the back click
  static Future<bool> performWillPopOperationSuccess() {
    return Future.value(true);
  }

// Handle the back click
  static Future<bool> performWillPopOperation() {
    return Future.value(false);
  }

  static Future<bool> performWillPopTwoClick() async {
    DateTime currentTime = DateTime.now();

    bool backButton = _backButtonPressedTime == null ||
        currentTime.difference(_backButtonPressedTime!) >
            const Duration(seconds: 3);

    if (backButton) {
      _backButtonPressedTime = currentTime;
      AppAlerts.showToastAlert(message: 'Double click to exit app');
      return Future.value(false);
    }
    exit(0);
    // return true;
  }

  static Future<void> launchUrlInBrowser(String url) async {
    var isLaunchableUrl = await canLaunchUrl(Uri.parse(url));
    if (isLaunchableUrl) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    } else {
      debugPrint("URL can't be launched.");
    }
  }
}