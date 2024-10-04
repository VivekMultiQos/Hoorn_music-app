import 'package:music_app/entities/albums/mdl_album_details.dart';
import 'package:music_app/entities/lrf_module/mdl_user.dart';
import 'package:music_app/entities/mdl_meta.dart';
import 'package:music_app/entities/albums/mdl_search_album_response.dart';
import 'package:music_app/repository/model/lrf/user_param.dart';

import '../data_source_manager/response_wrapper.dart';

abstract class AppRepositoryContract {
  Future<ResponseWrapper<MDLUser?, MDLMeta?>> login(
      {required MDLUserParam param}) async {
    return ResponseWrapper<MDLUser?, MDLMeta?>()..setData(null, null);
  }

  Future<ResponseWrapper<MdlSearchAlbumResponse?, String?>> searchAlbum(
      {required MDLAlbumsParam param}) async {
    return ResponseWrapper<MdlSearchAlbumResponse?, String?>()..setData(null, null);
  }

  Future<ResponseWrapper<MdlAlbumDetails?, String?>> getAlbum(
      {required MDLGetAlbumsParam param}) async {
    return ResponseWrapper<MdlAlbumDetails?, String?>()..setData(null, null);
  }

  Future<ResponseWrapper<MdlSongRecommendedResponse?, String?>> getSongs(
      {required MDLGetSongParam param}) async {
    return ResponseWrapper<MdlSongRecommendedResponse?, String?>()..setData(null, null);
  }
}
