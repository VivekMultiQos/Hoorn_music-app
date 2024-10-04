import 'dart:async';
import 'package:floor/floor.dart';
import 'package:music_app/entities/albums/mdl_local_store.dart';
import 'package:music_app/entities/lrf_module/mdl_user.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'dao/user_dao.dart';

part 'app_database.g.dart';

@Database(version: 1, entities: [MdlLocalStore])
abstract class AppDatabase extends FloorDatabase {
  UserDao get userDao;
}
