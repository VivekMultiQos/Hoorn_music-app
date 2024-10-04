import 'package:floor/floor.dart';
import 'package:music_app/entities/albums/mdl_album_details.dart';

@entity
class MdlLocalStore {
  @primaryKey
  int? userId;
  String? favoriteSong;

  MdlLocalStore({this.userId, this.favoriteSong});

  MdlLocalStore.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    favoriteSong = json['favoriteSong'];
  }
}
