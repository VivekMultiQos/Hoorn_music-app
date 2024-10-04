import 'package:floor/floor.dart';
import 'package:music_app/entities/albums/mdl_local_store.dart';
import 'package:music_app/entities/lrf_module/mdl_user.dart';

@dao
abstract class UserDao {

  @Query('SELECT * FROM MdlLocalStore')
  Future<List<MdlLocalStore>> findAllUsers();

  @Query('SELECT * FROM Person WHERE id = :id')
  Stream<MdlLocalStore?> findPersonById(int id);

  @insert
  Future<void> insertUser(MdlLocalStore user);

  @Update()
  Future<void> updateUser(MdlLocalStore user);

  @Query('DELETE FROM MdlLocalStore')
  Future<void> delete();

  @Query('UPDATE MdlLocalStore SET hasOccupation = :hasOccupation')
  Future<void> updateOccupationStatus(bool hasOccupation);

  @Query('UPDATE MdlLocalStore SET isNotification = :isNotification')
  Future<void> updateNotificationStatus(bool isNotification);
}