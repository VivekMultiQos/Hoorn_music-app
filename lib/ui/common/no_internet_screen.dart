import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_app/constant/import.dart';


class NoInternetScreen extends StatefulWidget {
  const NoInternetScreen({Key? key}) : super(key: key);

  @override
  State<NoInternetScreen> createState() => _NoInternetScreenState();
}

class _NoInternetScreenState extends State<NoInternetScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ChangeThemeState>(
      bloc: changeThemeCubit,
      builder: (context, themeState) {
        return Scaffold(
            backgroundColor: themeState.customColors[AppColors.white],
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                /*SizedBox(
                    height: 350.h,
                    child: SvgPicture.asset(AssetImages.icNoInternet)),*/
                // Padding(
                //   padding:
                //       EdgeInsets.symmetric(horizontal: 28.w, vertical: 15.h),
                //   child: Text(
                //     localize(context, LanguageKey.noInternetConnection),
                //     style: AppFontStyle.h1Guau25.copyWith(
                //         color: themeState.customColors[AppColors.black]),
                //   ),
                // ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 35.w,
                  ),
                  child: Text(
                    "No internet",
                    textAlign: TextAlign.center,
                    maxLines: 3,
                    style: AppFontStyle.h3SemiBold.copyWith(
                        color: themeState.customColors[AppColors.black]),
                  ),
                ),
              ],
            ),
          );
      },
    );
  }
}
