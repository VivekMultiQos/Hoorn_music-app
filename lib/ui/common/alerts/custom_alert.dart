import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../constant/import.dart';

class CustomAlert {
  static void showAlert(String message,
      {String? title,
      String btnFirst = 'Ok',
      String? btnSecond,
      Function? handler,
      String? icon = '',
      bool showIcon = false}) {
    Get.generalDialog(
      barrierDismissible: false,
      barrierLabel: 'barrierLabel',
      barrierColor: Colors.black45,
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (BuildContext buildContext, Animation animation,
          Animation secondaryAnimation) {
        return Builder(builder: (context) {
          return BlocBuilder<ThemeCubit, ChangeThemeState>(
              bloc: changeThemeCubit,
              builder: (context, themeState) {
                return SafeArea(
                  child: Center(
                    child: SizedBox(
                      width: Get.width - 50,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              clipBehavior: Clip.hardEdge,
                              decoration: BoxDecoration(
                                color: themeState.customColors[AppColors.white],
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Column(
                                children: [
                                  _titleWidget(
                                    themeState,
                                    title: title,
                                  ),
                                  showIcon
                                      ? Padding(
                                          padding: EdgeInsets.only(top: 46.h),
                                          child: Container(
                                            height: 112.h,
                                            width: 112.w,
                                            decoration: BoxDecoration(
                                              color: themeState.customColors[
                                                  AppColors.lightThemeColor],
                                              borderRadius:
                                                  BorderRadius.circular(100.r),
                                            ),
                                            child: Center(
                                                child: SvgPicture.asset(
                                                    icon ?? '')),
                                          ),
                                        )
                                      : const SizedBox.shrink(),
                                  _messageWidget(themeState, message: message),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 44),
                                    child: Center(
                                      child: GestureDetector(
                                        onTap: () {
                                          if (handler != null) {
                                            handler(0);
                                          }

                                          var context = Get.context;
                                          if (context != null) {
                                            // Navigator.pop(context);
                                          }
                                        },
                                        child: Container(
                                          alignment: Alignment.bottomRight,
                                          child: _buttonWidget(themeState,
                                              ok: btnFirst,
                                              cancel: btnSecond,
                                              handler: handler,
                                              context: context),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              });
        });
      },
      transitionBuilder: (_, anim, __, child) {
        return ScaleTransition(
          scale: anim,
          child: child,
        );
      },
    );
  }

  static Widget _titleWidget(ChangeThemeState themeState, {String? title}) {
    if (title == null || title.isEmpty) {
      return Container(height: 20);
    }
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10, top: 20),
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: AppFontStyle.h2SemiBold.copyWith(
          color: themeState.customColors[AppColors.black],
          decoration: TextDecoration.none,
        ),
      ),
    );
  }

  static Widget _messageWidget(ChangeThemeState themeState, {String? message}) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: Get.height - 200),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 40.0, left: 14, right: 14),
          child: Text(
            message ?? "",
            textAlign: TextAlign.center,
            style: AppFontStyle.h3Medium.copyWith(
              color: themeState.customColors[AppColors.black],
              decoration: TextDecoration.none,
            ),
          ),
        ),
      ),
    );
  }

  static Widget _buttonWidget(ChangeThemeState themeState,
      {String ok = "Ok",
      String? cancel,
      Function? handler,
      required BuildContext context}) {
    bool shouldShowSecondButton = cancel != null;

    return Padding(
      padding: const EdgeInsets.only(
        bottom: 48,
        right: 22,
        left: 22,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 45,
            width: MediaQuery.of(context).size.width * 0.32,
            child: ElevatedButton(
              onPressed: () {
                var context = Get.context;
                if (context != null) Navigator.pop(context);
                if (handler != null) {
                  handler(0);
                }
              },
              style: ButtonStyle(
                elevation: MaterialStateProperty.all(0),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                backgroundColor: MaterialStateProperty.all<Color>(
                    themeState.customColors[AppColors.greyE2E] ??
                        const Color(0xFF00AEEF)),
              ),
              child: Center(
                child: Text(ok,
                    textAlign: TextAlign.center,
                    style: AppFontStyle.h3SemiBold.copyWith(
                        color: themeState.customColors[AppColors.black])),
              ),
            ),
          ),
          !shouldShowSecondButton
              ? Container()
              : SizedBox(
                  width: MediaQuery.of(context).size.width * 0.05,
                ),
          !shouldShowSecondButton
              ? Container()
              : SizedBox(
                  height: 45,
                  width: MediaQuery.of(context).size.width * 0.32,
                  child: ElevatedButton(
                    onPressed: () {
                      var context = Get.context;
                      if (context != null) Navigator.pop(context);

                      if (handler != null) {
                        handler(1);
                      }
                    },
                    style: ButtonStyle(
                      elevation: MaterialStateProperty.all(0),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.all<Color>(
                          themeState.customColors[AppColors.themeColor] ??
                              const Color(0xFF2E3192)),
                    ),
                    child: Center(
                      child: Text(cancel,
                          textAlign: TextAlign.center,
                          style: AppFontStyle.h3SemiBold.copyWith(
                              color: themeState.customColors[AppColors.white])),
                    ),
                  ),
                )
        ],
      ),
    );
  }
}
