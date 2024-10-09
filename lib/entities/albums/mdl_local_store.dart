import 'package:floor/floor.dart';

@entity
class MdlLocalStore {
  @primaryKey
  int? userId;
  String? preferSinger;
  String? favoriteSong;

  MdlLocalStore({this.userId, this.favoriteSong, this.preferSinger});

  MdlLocalStore.fromJson(Map<String, dynamic> json) {
    userId = json['userId'] ?? 1;
    favoriteSong = json['favoriteSong'] ?? '';
    preferSinger = json['preferSinger'] ?? '';
  }
}
