import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:music_app/constant/app_logs.dart';
import 'package:music_app/entities/albums/mdl_album_details.dart';
import 'package:music_app/entities/albums/mdl_search_album_response.dart';
import 'package:music_app/repository/contract_builder/environment_service.dart';
import 'package:music_app/repository/data_source_manager/base_response.dart';
import 'package:retrofit/retrofit.dart';

import 'apis.dart';

part 'api_client.g.dart';

@RestApi(baseUrl: 'http://110.227.212.251:3014/api/v1/') //Staging

abstract class ApiClient {
  factory ApiClient(Dio dio) {
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
    var baseUrl = EnvironmentService.baseUrl;

    AppLogs.debugPrint("##BASEURL: $baseUrl");

    return _ApiClient(dio, baseUrl: baseUrl);
  }

  @POST(Apis.login)
  Future<BaseResponse> login(@Body() Map<String, dynamic> body);

  @GET(Apis.searchAlbums)
  Future<MdlSearchAlbumResponse> searchAlbums(@Queries() Map<String, dynamic> body);

  @GET(Apis.getAlbums)
  Future<MdlAlbumDetails> getAlbum(@Queries() Map<String, dynamic> body);


  @GET("${Apis.getSongs}{id}/suggestions")
  Future<MdlSongRecommendedResponse> getSongs(@Path("id") String id);
}

