import 'package:dio/dio.dart';
import 'package:music_app/common/login_user.dart';
import 'package:music_app/constant/app_logs.dart';
import 'package:music_app/cubit/language_module/language_cubit.dart';
import 'package:music_app/services/user_service.dart';


class AppInterceptor extends Interceptor {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    options.headers.addAll({
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    });

    /// Set the Bearer token if user is loggedIn.
    var languageType = await changeLanguageCubit.getLanguageType();
    options.headers.addAll({'language': languageType.name});
    // options.headers
    //     .addAll({'countryCode': UserService.instance.user?.countryId ?? ''});
    options.headers.addAll({
      'authorization': 'Bearer ${LoginUser.instance.authorizationToken}'
    });


    AppLogs.debugPrint("##REQ: URL: ${options.baseUrl}${options.path}  "
        "DATA: ${options.data.toString()} QUERY DATA: ${options.queryParameters.toString()}"
        "Headers: ${options.headers.toString()}");

    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    AppLogs.debugPrint("##RES: Response: ${response.data}");
    super.onResponse(response, handler);
  }
}
