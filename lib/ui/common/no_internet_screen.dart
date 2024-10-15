import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
          body: SizedBox(
            width: Get.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  child: SvgPicture.asset(
                    AssetImages.icNoInternet,
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 28.w, vertical: 15.h),
                  child: Text(
                    "No internet",
                    style: AppFontStyle.h2SemiBold.copyWith(
                        color: themeState.customColors[AppColors.black]),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
