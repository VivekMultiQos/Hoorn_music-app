import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_app/common/util.dart';
import 'package:music_app/constant/import.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ChangeThemeState>(
      bloc: changeThemeCubit,
      builder: (context, themeState) {
        return Scaffold(
          body: Container(
            width: Get.width,
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
            decoration: BoxDecoration(
              gradient: screenBackGroundColor(),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  AssetImages.welcomeScreen,
                  fit: BoxFit.cover,
                  height: 500.h,
                ),
                Text(
                  "on ads while \nlistening music",
                  style: AppFontStyle.h1Bold
                      .copyWith(color: Colors.purple, fontSize: 34.sp),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 20.h,
                ),
                Text(
                  "listening to music is very comfortable \nwithout any annoying ads",
                  style: AppFontStyle.h3Regular.copyWith(color: Colors.blue),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 100.h,
                ),
                InkWell(
                  onTap: () {
                    Get.offAllNamed(AppPages.preferScreen);
                  },
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(15.w),
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(50.r),
                        border: Border.all()),
                    child: Center(
                      child: Text(
                        "Get Started",
                        style: AppFontStyle.h2SemiBold,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
