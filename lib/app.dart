import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_app/common/login_user.dart';
import 'package:music_app/constant/import.dart';
import 'package:music_app/cubit/dashboard/playing_song/playing_song_cubit.dart';
import 'package:music_app/cubit/language_module/language_cubit.dart';
import 'package:music_app/cubit/language_module/language_state.dart';
import 'package:music_app/localization/app_localizations_setup.dart';
import 'package:music_app/ui/common/no_internet_screen.dart';
import 'package:music_app/ui/dashboard/playing_song_widget.dart';

import 'common/util.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  bool _hasVisibleNoInternet = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LanguageCubit, LanguageState>(
      bloc: changeLanguageCubit,
      listenWhen: (previousState, currentState) =>
          previousState != currentState,
      listener: (previousState, currentState) {
        /// To update the selected local for language.
        Get.updateLocale(currentState.locale);
      },
      buildWhen: (previousState, currentState) => previousState != currentState,
      builder: (context, languageState) {
        return ScreenUtilInit(
            designSize: Device.defaultSize,
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (context, child) {
              return GetMaterialApp(
                debugShowCheckedModeBanner: false,
                enableLog: false,
                navigatorKey: Get.key,
                initialRoute: _initMainScreen(),
                getPages: AppPages.routes,
                supportedLocales: AppLocalizationsSetup.supportedLocales,
                localizationsDelegates:
                    AppLocalizationsSetup.localizationsDelegates,
                localeResolutionCallback:
                    AppLocalizationsSetup.localeResolutionCallback,
                // Each time a new state emitted, the app will be rebuilt with the new locale.
                locale: languageState.locale,
                navigatorObservers: const [],
                theme: ThemeData(
                  primaryColor: Colors.white,
                  pageTransitionsTheme: const PageTransitionsTheme(builders: {
                    TargetPlatform.android: CupertinoPageTransitionsBuilder(),
                  }),
                ),
                builder: (context, child) {
                  return Stack(
                    children: [
                      MediaQuery(
                        data: MediaQuery.of(context)
                            .copyWith(textScaleFactor: 1.0),
                        child: child ??
                            Container(
                              height: 200.h,
                              color: Colors.green,
                            ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: PlayingSongWidget(
                          playingSongCubit: PlayingSongCubit(),
                        ),
                      ),
                    ],
                  );
                },
              );
            });
      },
    );
  }

  String _initMainScreen() {
    return AppPages.prefetchPage;
  }

  void _showNoInternetAlert(ConnectivityResult result) {
    if (result == ConnectivityResult.none && !_hasVisibleNoInternet) {
      _hasVisibleNoInternet = true;
      Get.generalDialog(
        barrierDismissible: false,
        barrierLabel: 'barrierLabel',
        barrierColor: Colors.black45,
        transitionDuration: const Duration(milliseconds: 0),
        pageBuilder: (BuildContext buildContext, Animation animation,
            Animation secondaryAnimation) {
          return const WillPopScope(
            onWillPop: performWillPopTwoClick,
            child: NoInternetScreen(),
          );
        },
      );
    } else if (_hasVisibleNoInternet) {
      Get.back();
      _hasVisibleNoInternet = false;
    }
  }

  void _configureInternetConnectivity() {
    /// To check the internet while launching the app.
    Connectivity().checkConnectivity().then((value) {
      print("internet = == = $value");
      if (value == ConnectivityResult.none) {
        _showNoInternetAlert(value);
      }
    });

    Connectivity().onConnectivityChanged.listen((event) {
      _showNoInternetAlert(event);
    });
  }

  void _configureLanguageUpdateListener() {
    LoginUser.instance.didUpdateLanguageData.listen((value) {
      print('app.Language data updated == = ');
    });
  }
}
