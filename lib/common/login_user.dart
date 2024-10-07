import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_app/cubit/dashboard/playing_song/playing_song_cubit.dart';
import 'package:music_app/entities/albums/mdl_album_details.dart';
import 'package:music_app/entities/albums/mdl_local_store.dart';
import 'package:music_app/entities/lrf_module/mdl_user.dart';
import 'package:music_app/floor/dao/user_dao.dart';
import 'package:music_app/ui/prefere_screen.dart';

import '../floor/app_database.dart';
import 'package:rxdart/rxdart.dart';

class LoginUser {
  LoginUser._internal();

  static final LoginUser _instance = LoginUser._internal();

  static LoginUser get instance => _instance;
  var startTime = DateTime.now();
  bool isLoggedIn = false;
  bool isLangSelectedValue = false;
  String currentOpenedUserChat = "";
  BehaviorSubject<bool> didUpdateUserProfile = BehaviorSubject<bool>();
  BehaviorSubject<bool> didUpdateLanguageData = BehaviorSubject<bool>();
  BehaviorSubject<bool> songPlay = BehaviorSubject<bool>();
  BehaviorSubject<bool> updateFavorites = BehaviorSubject<bool>();
  BehaviorSubject<LoopMode> playInLoop =
      BehaviorSubject<LoopMode>.seeded(LoopMode.off);
  BehaviorSubject<MDlPlayingSongs> playingSong =
      BehaviorSubject<MDlPlayingSongs>();
  BehaviorSubject<Songs> currentPlayingSong = BehaviorSubject<Songs>();
  List<Songs> favoriteSong = [];
  List<Singers> preferSinger = [];

  String? currentPlayAlbumId;
  AudioPlayer player = AudioPlayer();
  RemoteMessage? pushNotificationMessage;
  MDLUser? user;
  var floorDataBase;

  Future<void> initializationDatabase() async {
    floorDataBase = await $FloorAppDatabase
        .databaseBuilder('music_app_database.db')
        .build();
  }

  Future retrieveLoggedInUserDetail() async {
    try {
      print('retrieveLoggedInUserDetail == =');
      var users = await LoginUser.instance.floorDataBase.userDao.findAllUsers();
      if (users.isNotEmpty) {
        MdlLocalStore user = users.first;
        favoriteSong = (jsonDecode(user.favoriteSong!) as List)
            .map((songData) => Songs.fromJson(songData))
            .toList();

        preferSinger = (jsonDecode(user.preferSinger!) as List)
            .map((songData) => Singers.fromJson(songData))
            .toList();

        updateFavorites.value = true;
        isLoggedIn = true;
      } else {
        isLoggedIn = false;
        print('USER IS NOT LOGGED IN == =');
      }
    } catch (e) {
      isLoggedIn = false;
      print('USER IS NOT LOGGED IN == =');
    }
  }

  static bool get hasUserLoggedIn {
    var userInfo = LoginUser.instance.user;

    // if (userInfo != null && userInfo.isProfileCompleted) {
    //   return true;
    // }
    //
    // return false;

    return true;
  }

  Future<void> storeUserDataToLocal(MdlLocalStore userInfo) async {
    await floorDataBase.userDao.delete();
    await floorDataBase.userDao.insertUser(userInfo);
    await LoginUser.instance.retrieveLoggedInUserDetail();
  }

  Future<void> updateNotificationStatus(bool isNotification) async {
    try {
      await LoginUser.instance.floorDataBase.userDao
          .updateNotificationStatus(isNotification);
      await LoginUser.instance.retrieveLoggedInUserDetail();
    } catch (e) {
      print('retrieveUpdateNotificationDAta =error= =${e}');
    }
  }

/*

  Future<void> updateNotificationFlag(int? notificationFlag) async {
    try {
      await floorDataBase.userDao.updateNotificationFlag(notificationFlag);
      await LoginUser.instance.retrieveLoggedInUserDetail();
    } catch (e) {
      e.toString();
    }
  }



  Future<void> updateNotificationData(bool notificationValue) async {
    try {
      await LoginUser.instance.floorDataBase.userDao
          .updateNotificationData(notificationValue);
      await LoginUser.instance.retrieveLoggedInUserDetail();
    } catch (e) {
      debugPrint('retrieveUpdateNotificationDAta =error= =${e}');
    }
  }
*/

  // Future<void> isLangSelected () async {
  //   isLangSelectedValue =  await isLanguageSelected() ?? false;
  // }

  Future<void> logout() async {
    await floorDataBase.userDao.delete();
    isLoggedIn = false;
    user = null;
  }

  void login() {
    isLoggedIn = true;
  }

  String get authorizationToken {
    return user?.authToken ?? '';
  }

  String get userId {
    return user?.userId ?? '';
  }
}
