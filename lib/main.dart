import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:music_app/app.dart';
import 'package:music_app/common/login_user.dart';
import 'package:music_app/constant/app_logs.dart';
import 'package:music_app/services/user_service.dart';


void main() {
  return runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();

    /// To Set the fix device orientation.
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    ///Initialize firebase
    // await Firebase.initializeApp();

    /// To get the last decided theme.
    // changeThemeCubit.onDecideThemeChange();

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.black,
    )); // 1

    /// Register the DB providers and init the DB
    await LoginUser.instance.initializationDatabase();

    /// To restore the login detail.
    await LoginUser.instance.retrieveLoggedInUserDetail();

    /// Start point of the application.
    runApp(const App());
  }, (error, stack) async {
    AppLogs.debugPrint('main = = = = ${error.toString()}');
    await Future.wait([
      // FlutterCrashlytics().reportCrash(error, stackTrace, forceCrash: false);
    ]);
  });
  // runApp(const MyApp());
}
