import 'package:dio/dio.dart';
import 'package:music_app/entities/albums/mdl_album_details.dart';
import 'package:music_app/entities/lrf_module/mdl_user.dart';
import 'package:music_app/entities/mdl_meta.dart';
import 'package:music_app/entities/albums/mdl_search_album_response.dart';
import 'package:music_app/repository/contract_builder/app_repository_contract.dart';
import 'package:music_app/repository/data_source_manager/response_wrapper.dart';
import 'package:music_app/repository/data_source_manager/server_error.dart';
import 'package:music_app/repository/interceptor/app_interceptor.dart';
import 'package:music_app/repository/model/lrf/user_param.dart';
import 'package:music_app/repository/retrofit/api_client.dart';

class UserRepository extends AppRepositoryContract {
  late Dio dio;
  late ApiClient _apiClient;

  UserRepository() {
    dio = Dio();
    dio.interceptors.add(AppInterceptor());
    _apiClient = ApiClient(dio);
  }

  @override
  Future<ResponseWrapper<MDLUser?, MDLMeta?>> login(
      {required MDLUserParam param}) async {
    var responseWrapper = ResponseWrapper<MDLUser?, MDLMeta?>();
    try {
      var response = await _apiClient.login(param.toJson);
      MDLUser? userInfo;
      if (response.data != null) {
        userInfo = MDLUser.fromJson(response.data);
      }
      var metaInfo = response.meta;
      return responseWrapper..setData(userInfo, metaInfo);
    } on DioException catch (e) {
      responseWrapper.setException(ServerError.withError(error: e));
    } on Exception {
      responseWrapper.setException(ServerError.withError(error: null));
    }
    return responseWrapper;
  }

  @override
  Future<ResponseWrapper<MdlSearchAlbumResponse?, String?>> searchAlbum({
    required MDLAlbumsParam param,
  }) async {
    var responseWrapper = ResponseWrapper<MdlSearchAlbumResponse?, String?>();
    try {
      var response = await _apiClient.searchAlbums(param.toJson);
      var dataInfo = response.data;
      MdlSearchAlbumResponse? albumsDetails;

      // Check if `data` contains the relevant track information
      if (dataInfo != null) {
        albumsDetails = MdlSearchAlbumResponse.fromJson(response.toJson());
      }

      return responseWrapper..setData(albumsDetails, null);
    } on DioException catch (e) {
      responseWrapper.setException(ServerError.withError(error: e));
    } on Exception {
      responseWrapper.setException(ServerError.withError(error: null));
    }
    return responseWrapper;
  }


  @override
  Future<ResponseWrapper<MdlAlbumDetails?, String?>> getAlbum({
    required MDLGetAlbumsParam param,
  }) async {
    var responseWrapper = ResponseWrapper<MdlAlbumDetails?, String?>();
    try {
      var response = await _apiClient.getAlbum(param.toJson);
      var dataInfo = response.data;
      MdlAlbumDetails? albumsDetails;

      // Check if `data` contains the relevant track information
      if (dataInfo != null) {
        albumsDetails = MdlAlbumDetails.fromJson(response.toJson());
      }

      return responseWrapper..setData(albumsDetails, null);
    } on DioException catch (e) {
      responseWrapper.setException(ServerError.withError(error: e));
    } on Exception {
      responseWrapper.setException(ServerError.withError(error: null));
    }
    return responseWrapper;
  }


  @override
  Future<ResponseWrapper<MdlSongRecommendedResponse?, String?>> getSongs({
    required MDLGetSongParam param,
  }) async {
    var responseWrapper = ResponseWrapper<MdlSongRecommendedResponse?, String?>();
    try {

      String songID = param.id ?? '';

      var response = await _apiClient.getSongs(songID);
      var dataInfo = response.data;
      MdlSongRecommendedResponse? songList;

      // Check if `data` contains the relevant track information
      if (dataInfo != null) {
        songList = MdlSongRecommendedResponse.fromJson(response.toJson());
      }

      return responseWrapper..setData(songList, null);
    } on DioException catch (e) {
      responseWrapper.setException(ServerError.withError(error: e));
    } on Exception {
      responseWrapper.setException(ServerError.withError(error: null));
    }
    return responseWrapper;
  }
}
