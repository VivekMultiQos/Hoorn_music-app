import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:music_app/common/login_user.dart';
import 'package:music_app/constant/app_logs.dart';
import 'package:music_app/route/app_pages.dart';
import 'package:music_app/services/user_service.dart';

const String kSomethingWentWrong = 'Something went wrong';
const String kNoInternet = 'Please check your internet connection!';

class ServerError implements Exception {
  final int _errorCode = 0;
  String _errorMessage = kSomethingWentWrong;
  String _errorMes = kSomethingWentWrong;

  ServerError.withError({DioException? error}) {
    _handleError(error);
  }

  int get errorCode {
    return _errorCode;
  }

  Future<String> get errorMessage async {
    var isConnected = await checkConnection();
    if (!isConnected) {
      _errorMessage = kNoInternet;
    }
    return _errorMessage;
  }

  static Future<bool> checkConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    switch (connectivityResult) {
      case ConnectivityResult.mobile:
        return true;
      case ConnectivityResult.wifi:
        return true;
      case ConnectivityResult.none:
        return false;
    }
  }

  Future<void> _handleError(DioException? error) async {
    AppLogs.debugPrint('#### error : $error');
    if (error == null) {
      _errorMessage = kSomethingWentWrong;
      return;
    }

    AppLogs.debugPrint('### API : ${error.requestOptions.uri}');
    AppLogs.debugPrint('### Method : ${error.requestOptions.method}');
    AppLogs.debugPrint('### Parameters : ${error.requestOptions.data}');
    AppLogs.debugPrint('### queryParameters : ${error.requestOptions.queryParameters}');
    AppLogs.debugPrint('### statusCode : ${error.response?.statusCode} ');
    AppLogs.debugPrint('### headers : ${error.requestOptions.headers} ');
    AppLogs.debugPrint('### statusMessage : ${error.response?.statusMessage} ');
    AppLogs.debugPrint('### response : ${error.response} ');
    AppLogs.debugPrint('### response.data : ${error.response?.data} ');
    AppLogs.debugPrint('### _handleError : ${error.toString()} ');

    switch (error.type) {
      case DioExceptionType.cancel:
        _errorMessage = 'Request was cancelled';

        break;
      case DioExceptionType.connectionTimeout:
        _errorMessage = 'Connection timeout';
        break;
      case DioExceptionType.unknown:
        if (error.response != null) {
          _errorMessage = error.response?.statusMessage ?? kSomethingWentWrong;
        }
        //_errorMessage = "Connection failed due to internet connection";
        break;
      case DioExceptionType.receiveTimeout:
        _errorMessage = 'Receive timeout in connection';
        break;
      case DioExceptionType.badResponse:
        if (error.response != null) {
          var msg = _handleServerError(error.response);
          AppLogs.debugPrint('msg ---- > $msg');
          if (msg.isEmpty) {
            msg = error.toString();
          }
          _errorMessage = msg;
        }
        break;
      case DioExceptionType.sendTimeout:
        _errorMessage = 'Receive timeout in send request';
        break;
      case DioExceptionType.badCertificate:
        _errorMessage = 'Receive timeout in send request';
        break;
      case DioExceptionType.connectionError:
        _errorMessage = 'Receive timeout in send request';
        break;
    }

    if (_errorMessage.isEmpty) {
      _errorMessage = kSomethingWentWrong;
    }

    // return _errorMessage;
  }

  static String _handleServerError(response) {
    if (response == null) {
      return kSomethingWentWrong;
    }
    if (response.statusCode == 403) {
      // Get.offAllNamed(Routes.LOGIN);
    }
    if (response.statusCode == 401) {
      //logout user
      LoginUser.instance.logout();
      Fluttertoast.showToast(
          msg: response.statusMessage,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.white,
          textColor: Colors.black,
          fontSize: 16.0);
      //navigate to login page
      Get.offAllNamed(AppPages.loginPage);
    }

    if (response.statusCode == 400) {
      var map = response.data;

      return map['message'] ?? kSomethingWentWrong;
    }

    if (response.statusMessage != null && !response.statusMessage.isEmpty) {
      return response.statusMessage;
    }

    if (response != null && response.runtimeType == String) {
      return response.toString();
    }
    if (response.users != null && response.users.runtimeType == String) {
      return response.users;
    }
    if (response.users != null) {
      return response.users.toString();
    }
    return '';
  }
}
