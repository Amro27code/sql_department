import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart' as sqlflitedb;

import 'myApp/my_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  String pathDB = await sqlflitedb.getDatabasesPath();
  print(pathDB);

  String myDBName = "test.db";
  String myDBPath = "$pathDB/$myDBName";

  int versionDB = 1;
  sqlflitedb.openDatabase(
    myDBPath,
    version: versionDB,
    onCreate: (sqlflitedb.Database db, int version) {
      print(db);
      print(version);
    },
  );
  runApp(const MyApp());
}
