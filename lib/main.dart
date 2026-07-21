import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart' as sqlflitedb;
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'myApp/my_app.dart';

import 'package:path/path.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sqfliteFfiInit();
  sqlflitedb.databaseFactory = databaseFactoryFfi;

  String pathDB = await sqlflitedb.getDatabasesPath();
  print(pathDB);

  String myDBName = "test.db";
  String myDBPath = join(pathDB, myDBName); //"$pathDB/$myDBName";
  print("------------------------$myDBPath");
  bool dbIsExisted = await sqlflitedb.databaseExists(myDBPath);
  print(dbIsExisted);
  if (dbIsExisted) {
    await sqlflitedb.deleteDatabase(myDBPath);
  }

  int versionDB = 1;
  Database myDatabase = await sqlflitedb.openDatabase(
    myDBPath,
    version: versionDB,
    onCreate: (sqlflitedb.Database db, int version) async {
      await db.execute(
        "CREATE TABLE IF NOT EXISTS user(id INTEGER PRIMARY KEY,name Text);",
      );
      await db.execute(
        "CREATE TABLE IF NOT EXISTS groups(id INTEGER PRIMARY KEY,name Text, count INTEGER);",
      );
      await db.execute(
        "CREATE TABLE IF NOT EXISTS grp(id INTEGER PRIMARY KEY,name Text, count INTEGER);",
      );
      print(db);
      print(version);
    },
  );
  await myDatabase.transaction((txn) async {
    await txn.rawInsert("INSERT INTO user(id,name) VALUES(1,'amro' );");
  });
  int i = await myDatabase.insert("user", {"id": 2, "name": 'ammar'});
  print(i);

  await myDatabase.insert("user", {"id": 2, "name": 'ammar'});
  await myDatabase.update("user", {"name": 'amro'}, where: "id =2");
  await myDatabase.rawDelete("DELETE FROM user WHERE id=1" );

  List<Map<String, Object?>> data = await myDatabase.rawQuery(
    "SELECT * FROM user;",
  );
  print(data);

  List<Map<String, Object?>> data2 = await myDatabase.query("user");
  print(data2);

  // await myDatabase.execute("DROP IF EXISTS TABLE ");

  await myDatabase.close();
  runApp(const MyApp());
}
