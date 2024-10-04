import 'dart:convert';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:music_app/common/login_user.dart';
import 'package:music_app/constant/font_style.dart';
import 'package:music_app/constant/language_key.dart';
import 'package:music_app/cubit/theme_module/change_theme_states.dart';
import 'package:music_app/entities/albums/mdl_album_details.dart';
import 'package:music_app/entities/albums/mdl_local_store.dart';
import 'package:music_app/localization/app_localizations.dart';
import 'package:music_app/theme/theme_colors.dart';
import 'package:music_app/ui/common/alerts/custom_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

AppBar baseAppBar(
    {String title = '',
    List<Widget>? widgets,
    Widget? leading,
    double? leadingWidth,
    double elevation = 0.0,
    TextStyle? titleStyle,
    Color color = Colors.transparent,
    SystemUiOverlayStyle systemOverlayStyle = SystemUiOverlayStyle.dark,
    bool centerTitle = false,
    MainAxisAlignment? axisAlignment,
    String? userImage}) {
  return AppBar(
    automaticallyImplyLeading: false,
    systemOverlayStyle: systemOverlayStyle,
    backgroundColor: color,
    elevation: elevation,
    leadingWidth: leadingWidth,
    titleSpacing: 0,
    leading: leading != null
        ? Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: leading,
          )
        : null,
    flexibleSpace: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft, // Start direction
          end: Alignment.bottomRight, // End direction
          colors: [
            Colors.blue[100] ?? const Color(0xFF000000), // Start Color
            Colors.pink[100] ?? const Color(0xFF000000), // End Color
          ], // Customize your colors here
        ),
      ),
    ),
    title: Row(
      mainAxisAlignment: axisAlignment ?? MainAxisAlignment.start,
      children: [
        userImage != null
            ? Container(
                margin: EdgeInsets.only(right: 8.w),
                height: 25.h,
                width: 25.w,
                clipBehavior: Clip.hardEdge,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: userImage != ''
                    ? CachedNetworkImage(
                        imageUrl: userImage,
                        fit: BoxFit.cover,
                        errorWidget: (context, url, error) => Image.network(
                          'https://staging.multiqos.com:3003/public/uploads/user/defaultUser.png',
                          fit: BoxFit.cover,
                        ),
                      )
                    : const SizedBox.shrink(),
              )
            : const SizedBox.shrink(),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(left: leading == null ? 15.0 : 0),
            child: Text(
              title ?? '',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: titleStyle,
            ),
          ),
        ),
      ],
    ),
    centerTitle: false,
    iconTheme: const IconThemeData(
      color: Colors.black, //change your color here
    ),
    actions: widgets,
  );
}

Divider divider(
    {required ChangeThemeState themeState, Color? color, double? height}) {
  return Divider(
    color: color ?? themeState.customColors[AppColors.black]?.withOpacity(0.4),
    height: 5,
    thickness: height ?? 2,
  );
}

SizedBox sizedBox({double? topBottomSpace}) {
  return SizedBox(
    height: topBottomSpace ?? 16.h,
  );
}

// String getTimeAgo({required int timestamp}) {
//   var date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
//   var localTimeZoneDate = date.toLocal();
//   return localTimeZoneDate.timeAgo;
// }
//
// String getTimeAgoChat({required int timestamp}) {
//   var date = DateTime.fromMillisecondsSinceEpoch(timestamp);
//   var localTimeZoneDate = date.toLocal();
//   return localTimeZoneDate.timeAgo;
// }

Future<bool?> isLanguageSelected() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getInt('has_lang_added') == 1 ? true : false;
}

String getFormattedTime12Hrs({required int timestamp}) {
  var date = DateTime.fromMillisecondsSinceEpoch(timestamp);
  String formattedDate = DateFormat('hh:mm a').format(date);
  return formattedDate;
}

String getFormattedTime({required int timestamp}) {
  var date = DateTime.fromMillisecondsSinceEpoch(timestamp);
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);

  var days = today.difference(date).inDays;

  if (days > 0) {
    String formattedDate = DateFormat('dd MMM yyyy').format(date);
    return formattedDate;
  } else {
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    String formattedDate = DateFormat('hh:mm a').format(date);
    return formattedDate;
  }
}

// String getFormattedTimeAgo({required int timestamp}) {
//   if(timestamp != 0){
//     var date = DateTime.fromMillisecondsSinceEpoch(timestamp);
//     final now = DateTime.now();
//     final today = DateTime(now.year, now.month, now.day);
//
//     var days = today.difference(date).inDays;
//     var seconds = now.difference(date).inSeconds;
//     var minutes = now.difference(date).inMinutes;
//     var hours = now.difference(date).inHours;
//
//     if (seconds < 60) {
//       return MessageConstant.justNow;
//     } else if (minutes < 60) {
//       return '$minutes ${minutes == 1 ? MessageConstant.minute : MessageConstant.minutes} ${MessageConstant.ago}';
//     } else if (hours < 24) {
//       return '$hours ${hours == 1 ? MessageConstant.hour : MessageConstant.hours} ${MessageConstant.ago}';
//     } else if (days > 0) {
//       String formattedDate = DateFormat('dd MMM yyyy').format(date);
//       return formattedDate;
//     } else {
//       String formattedDate = DateFormat('dd MMM yyyy').format(date);
//       return formattedDate;
//     }
//   }else{
//     return "";
//   }
//
// }

void hideKeyboard(BuildContext context) {
  FocusScope.of(context).requestFocus(FocusNode());
}

KeyboardActionsConfig getKeyboardActionsConfig(
    BuildContext context, List<FocusNode> list) {
  return KeyboardActionsConfig(
    keyboardBarColor: Colors.grey[200],
    nextFocus: true,
    actions: List.generate(
      list.length,
      (i) => KeyboardActionsItem(
        focusNode: list[i],
        toolbarButtons: [
          (node) {
            return GestureDetector(
              onTap: () => node.unfocus(),
              child: Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: _buildDoneButton(),
              ),
            );
          },
        ],
      ),
    ),
  );
}

Widget _buildDoneButton() {
  return Container(
    padding: const EdgeInsets.only(left: 15, right: 15, top: 8, bottom: 8),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8.0),
      color: Colors.transparent,
    ),
    child: const Text(
      'Done',
      style: TextStyle(color: Colors.blue),
    ),
  );
}

Future<bool> checkConnectivity() async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.mobile) {
    return true;
  } else if (connectivityResult == ConnectivityResult.wifi) {
    return true;
  }
  return false;
}

Future<File?> openGallery(bool compressImage) async {
  // var pickedFile = await ImagePicker().getImage(source: ImageSource.gallery);
  try {
    var pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      var image = File(pickedFile.path);
      return image;
    }
  } catch (e) {
    print("openGallery = == ${e.toString()}");
    return null;
  }
}

Future<File?> openPhoto(bool compressImage) async {
  try {
    var pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      var image = File(pickedFile.path);
      return image;
    }
  } catch (e) {
    print("openCamera = == ${e.toString()}");
    return null;
  }
}

Future<File?> openVideo(bool compressImage) async {
  try {
    var cameraVideo = await ImagePicker().pickVideo(source: ImageSource.camera);
    if (cameraVideo != null) {
      var video = File(cameraVideo.path);
      return video;
    }
  } catch (e) {
    print("openCamera = == ${e.toString()}");
    return null;
  }
}

// Handle the back click
Future<bool> performWillPopOperation() {
  return Future.value(false);
}

DateTime? backButtonPressedTime;

Future<bool> performWillPopTwoClick() async {
  DateTime currentTime = DateTime.now();

  bool backButton = backButtonPressedTime == null ||
      currentTime.difference(backButtonPressedTime!) >
          const Duration(seconds: 3);

  if (backButton) {
    backButtonPressedTime = currentTime;
    Fluttertoast.showToast(
        msg: 'Double click to exit app',
        backgroundColor: Colors.black,
        textColor: Colors.white);
    return Future.value(false);
  }
  exit(0);
  // return true;
}

void showLoader(
  BuildContext context,
) {
  Loader.show(context,
      progressIndicator: const SizedBox(
        height: 100,
        width: 100,
        child: LoadingIndicator(
            indicatorType: Indicator.ballSpinFadeLoader,

            /// Required, The loading type of the widget
            colors: [Color(0xffFF5C00)],

            /// Optional, The color collections
            strokeWidth: 2,

            /// Optional, The stroke of the line, only applicable to widget which contains line
            /// Optional, Background of the widget
            pathBackgroundColor: Colors.black

            /// Optional, the stroke backgroundColor
            ),
      ),
      overlayColor: Colors.black.withOpacity(0.6),
      overlayFromTop: 0);
}

void hideLoader() {
  Loader.hide();
}

void showErrorDialog(BuildContext context, String errorMessage,
    {Function? onTap}) {
  CustomAlert.showAlert(
    "fsfsfdsfdsf",
    btnFirst: "OK",
    handler: (index) async {
      if (onTap != null) {
        onTap();
      }
    },
  );
}

void showToastAlert({String message = ''}) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 16.0);
}

BoxDecoration formContainerDecoration({Color? backgroundColor}) {
  return BoxDecoration(
    color: backgroundColor,
    borderRadius: const BorderRadius.only(topLeft: Radius.circular(75)),
  );
}

Future<String> getDeviceToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var stringValue = prefs.getString('FCMToken');
  if (stringValue != null && stringValue.isNotEmpty) {
    return stringValue;
  }
  return '';
}

Future<void> launchInBrowser(String url) async {
  final uri = Uri.parse(url);
  if (!await launchUrl(
    uri,
    mode: LaunchMode.externalApplication,
  )) {
    // showToastAlert(message: 'Invalid Bet URL');
    // throw Exception('Could not launch $url');
  }
}

/*navigateToScreenOnNotification(RemoteMessage message) async {
  /// Check user Login or Not
  if (LoginUser.instance.isLoggedIn == false) {
    await Get.offAllNamed(Routes.loginPage);
  }

  Map<String, dynamic> notData = message.data;
  print('FirebasePushNotificationsHandler._navigateToScreen === $notData');

  MDLNotification? mdlPushNotification = MDLNotification.fromJson(notData);

  switch (mdlPushNotification.notificationType ?? '') {
    case 'accept-request':
      Get.toNamed(
        Routes.myRequestProgressDetailsPage,
        arguments: MyRequestProgressDetailsPageAttribute(
            requestId: mdlPushNotification.requestId ?? '', name: '', help: ''),
      );
      break;
    case 'decline-request':
      Get.toNamed(
        Routes.myRequestProgressDetailsPage,
        arguments: MyRequestProgressDetailsPageAttribute(
            requestId: mdlPushNotification.requestId ?? '', name: '', help: ''),
      );
      break;
    case 'new-request':
      Get.toNamed(Routes.requestDetailsPage,
          arguments:
              MDLListFriendRequests(requestId: mdlPushNotification.requestId));
      break;
    case 'accept-offer':
      Get.toNamed(Routes.requestDetailsPage,
          arguments:
              MDLListFriendRequests(requestId: mdlPushNotification.requestId));
      break;
    case 'chat-message':
      Get.toNamed(
        Routes.userChatPage,
        arguments: ChatUserDetail(
            fromTabBar: true,
            profilePicture: mdlPushNotification.image,
            userId: mdlPushNotification.userId,
            firstName: mdlPushNotification.title,
            lastName: ""),
      );
      break;
    case 'request-start':
      Get.toNamed(Routes.userChatPage,
          arguments: ChatUserDetail(
            userId: mdlPushNotification.requestUserId,
            requestId: mdlPushNotification.requestId,
          ));
      break;
    case 'request-end':
      Get.toNamed(Routes.userChatPage,
          arguments: ChatUserDetail(
            userId: mdlPushNotification.requestUserId,
            requestId: mdlPushNotification.requestId,
          ));
      break;
    default:
      await Get.offAllNamed(Routes.tabBarPage);
      break;
  }
}*/

String formatLastMessageTime(int lastMessageTimestamp) {
  // Get the current time in milliseconds since epoch
  int nowMilliseconds = DateTime.now().millisecondsSinceEpoch;

  // Calculate the difference between the current time and the last message timestamp
  int differenceMilliseconds = nowMilliseconds - lastMessageTimestamp;

  // Convert milliseconds to seconds
  int differenceSeconds = (differenceMilliseconds / 1000).floor();

  // Format the time difference
  if (differenceSeconds >= 86400) {
    // If the difference is more than a day (86400 seconds), show the date
    DateTime lastMessageDateTime =
        DateTime.fromMillisecondsSinceEpoch(lastMessageTimestamp);
    return DateFormat('MMM d, yyyy').format(lastMessageDateTime);
  } else if (differenceSeconds >= 3600) {
    // If the difference is more than an hour (3600 seconds), show hours
    return '${(differenceSeconds / 3600).floor()}h ago';
  } else if (differenceSeconds >= 60) {
    // If the difference is more than a minute (60 seconds), show minutes
    return '${(differenceSeconds / 60).floor()}m ago';
  } else {
    // If the difference is less than a minute, show seconds
    return 'Just now';
  }
}

LinearGradient screenBackGroundColor() {
  return LinearGradient(
    begin: Alignment.centerLeft, // Start direction
    end: Alignment.centerRight, // End direction
    colors: [
      Colors.blue[100] ?? const Color(0xFF000000),
      // Start Color
      Colors.pink[100] ?? const Color(0xFF000000),
      // End Color
    ], // Customize your colors here
  );
}

String formatDuration(Duration duration) {
  String twoDigits(int n) => n.toString().padLeft(2, '0');
  final hours = duration.inHours;
  final minutes = duration.inMinutes.remainder(60);
  final seconds = duration.inSeconds.remainder(60);

  return hours > 0
      ? '${twoDigits(hours)}:${twoDigits(minutes)}:${twoDigits(seconds)}'
      : '${twoDigits(minutes)}:${twoDigits(seconds)}';
}

void showSliderDialog({
  required BuildContext context,
  required String title,
  required int divisions,
  required double min,
  required double max,
  String valueSuffix = '',
  required double value,
  required Stream<double> stream,
  required ValueChanged<double> onChanged,
}) {
  showDialog<void>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title, textAlign: TextAlign.center),
      content: StreamBuilder<double>(
        stream: stream,
        builder: (context, snapshot) => SizedBox(
          height: 100.0,
          child: Column(
            children: [
              Text('${snapshot.data?.toStringAsFixed(1)}$valueSuffix',
                  style: const TextStyle(
                      fontFamily: 'Fixed',
                      fontWeight: FontWeight.bold,
                      fontSize: 24.0)),
              Slider(
                divisions: divisions,
                min: min,
                max: max,
                value: snapshot.data ?? value,
                onChanged: onChanged,
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

Future<void> addFavoriteSong(Songs song) async {
  if (LoginUser.instance.favoriteSong.any((songs) => songs.id == song.id)) {
    LoginUser.instance.favoriteSong.removeWhere((s) => s.id == song.id);
  } else {
    LoginUser.instance.favoriteSong.insert(0, song);
  }
  await LoginUser.instance.storeUserDataToLocal(
    MdlLocalStore(
      favoriteSong: jsonEncode(LoginUser.instance.favoriteSong
          .map((song) => song.toJson())
          .toList()),
    ),
  );
}
