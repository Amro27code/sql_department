import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite_department/sqlite/crud.dart';
import 'package:path/path.dart' show join;

class MySqfliteDatabase extends CRUD {
  void initDatabase() async {
    String path = await sqflite.getDatabasesPath();
    //
    String managementDatabaseName = "management.db";
    String myPath = join(path, managementDatabaseName);

    int version = 1;
    sqflite.openDatabase(
      myPath,
      version: version,
      onCreate: (Database db, int version) {

      },
    );
  }

  @override
  int delete() {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  int insert() {
    // TODO: implement insert
    throw UnimplementedError();
  }

  @override
  int select() {
    // TODO: implement select
    throw UnimplementedError();
  }

  @override
  int update() {
    // TODO: implement update
    throw UnimplementedError();
  }
}
