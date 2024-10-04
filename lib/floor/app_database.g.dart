// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

abstract class $AppDatabaseBuilderContract {
  /// Adds migrations to the builder.
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations);

  /// Adds a database [Callback] to the builder.
  $AppDatabaseBuilderContract addCallback(Callback callback);

  /// Creates the database and initializes it.
  Future<AppDatabase> build();
}

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder implements $AppDatabaseBuilderContract {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  @override
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  @override
  $AppDatabaseBuilderContract addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  @override
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  UserDao? _userDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `MdlLocalStore` (`userId` INTEGER, `favoriteSong` TEXT, PRIMARY KEY (`userId`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  UserDao get userDao {
    return _userDaoInstance ??= _$UserDao(database, changeListener);
  }
}

class _$UserDao extends UserDao {
  _$UserDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _mdlLocalStoreInsertionAdapter = InsertionAdapter(
            database,
            'MdlLocalStore',
            (MdlLocalStore item) => <String, Object?>{
                  'userId': item.userId,
                  'favoriteSong': item.favoriteSong
                },
            changeListener),
        _mdlLocalStoreUpdateAdapter = UpdateAdapter(
            database,
            'MdlLocalStore',
            ['userId'],
            (MdlLocalStore item) => <String, Object?>{
                  'userId': item.userId,
                  'favoriteSong': item.favoriteSong
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<MdlLocalStore> _mdlLocalStoreInsertionAdapter;

  final UpdateAdapter<MdlLocalStore> _mdlLocalStoreUpdateAdapter;

  @override
  Future<List<MdlLocalStore>> findAllUsers() async {
    return _queryAdapter.queryList('SELECT * FROM MdlLocalStore',
        mapper: (Map<String, Object?> row) => MdlLocalStore(
            userId: row['userId'] as int?,
            favoriteSong: row['favoriteSong'] as String?));
  }

  @override
  Stream<MdlLocalStore?> findPersonById(int id) {
    return _queryAdapter.queryStream('SELECT * FROM Person WHERE id = ?1',
        mapper: (Map<String, Object?> row) => MdlLocalStore(
            userId: row['userId'] as int?,
            favoriteSong: row['favoriteSong'] as String?),
        arguments: [id],
        queryableName: 'Person',
        isView: false);
  }

  @override
  Future<void> delete() async {
    await _queryAdapter.queryNoReturn('DELETE FROM MdlLocalStore');
  }

  @override
  Future<void> updateOccupationStatus(bool hasOccupation) async {
    await _queryAdapter.queryNoReturn(
        'UPDATE MdlLocalStore SET hasOccupation = ?1',
        arguments: [hasOccupation ? 1 : 0]);
  }

  @override
  Future<void> updateNotificationStatus(bool isNotification) async {
    await _queryAdapter.queryNoReturn(
        'UPDATE MdlLocalStore SET isNotification = ?1',
        arguments: [isNotification ? 1 : 0]);
  }

  @override
  Future<void> insertUser(MdlLocalStore user) async {
    await _mdlLocalStoreInsertionAdapter.insert(user, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateUser(MdlLocalStore user) async {
    await _mdlLocalStoreUpdateAdapter.update(user, OnConflictStrategy.abort);
  }
}