import 'package:music_app/constant/app_logs.dart';
import 'package:music_app/entities/lrf_module/mdl_user.dart';
import 'package:music_app/floor/app_database.dart';
import 'package:rxdart/rxdart.dart';
import 'package:music_app/constant/import.dart';

class UserService {
  UserService._internal();

  static final UserService _instance = UserService._internal();

  static UserService get instance => _instance;
  bool hasLoggedIn = false;

  var startTime = DateTime.now();
  BehaviorSubject<bool> didUpdateUserProfile = BehaviorSubject<bool>();

  MDLUser? user;
  var floorDataBase;

  Future<void> initializationDatabase() async {
    try {
      floorDataBase = await $FloorAppDatabase
          .databaseBuilder('music_database.db')
          .build();
    }catch(e){
      print(e);
    }
  }

  Future retrieveLoggedInUserDetail() async {
    try {
      AppLogs.debugPrint('retrieveLoggedInUserDetail == =');
      var users = await UserService.instance.floorDataBase.userDao.findAllUsers();
      if (users.isNotEmpty) {
        // user = users.first;
        hasLoggedIn = true;
      } else {
        hasLoggedIn = false;
        AppLogs.debugPrint('USER IS NOT LOGGED IN == =');
      }
    } catch (e) {
      hasLoggedIn = false;
      AppLogs.debugPrint('USER IS NOT LOGGED IN == =');
    }
  }

  Future<void> storeUserDataToLocal(MDLUser userInfo, String token) async {
    if (token != "") {
      userInfo.authToken = token;
    } else {
      userInfo.authToken = user?.authToken ?? '';
    }

    await floorDataBase.userDao.delete();
    await floorDataBase.userDao.insertUser(userInfo);
    await UserService.instance.retrieveLoggedInUserDetail();
  }

  Future<void> updateOccupationStatus({bool hasOccupation = false}) async {
    try {
      await UserService.instance.floorDataBase.userDao
          .updateOccupationStatus(hasOccupation);
      await UserService.instance.retrieveLoggedInUserDetail();
    } catch (e) {
      AppLogs.debugPrint('updateNotificationStatus =error= =$e');
    }
  }

  Future<void> updateNotificationStatus(bool isNotification) async {
    try {
      await UserService.instance.floorDataBase.userDao
          .updateNotificationStatus(isNotification);
      await UserService.instance.retrieveLoggedInUserDetail();
    } catch (e) {
      AppLogs.debugPrint('retrieveUpdateNotificationDAta =error= =$e');
    }
  }

  Future<void> logout() async {
    await floorDataBase.userDao.delete();
    hasLoggedIn = false;
    user = null;
  }

  String get authorizationToken {
    return user?.authToken ?? '';
  }

  String get userId {
    return user?.userId ?? '';
  }
}
