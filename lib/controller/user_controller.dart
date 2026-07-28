import 'package:flutter/material.dart';

import '../sqlite/my_sqflite_database.dart';

class ProductController {
  late TextEditingController userNameController;
  late TextEditingController userNameEditController;

  List<Map<String, Object?>> data = [];
  String userNameColumn = MySqfliteDatabase().userNameColumn;
  String userIdColumn = MySqfliteDatabase().userIdColumn;

  ProductController() {
    // mySqflite = MySqfliteDatabase();
    userNameController = TextEditingController();
    userNameEditController = TextEditingController();
    // mySqflite.initDatabase();
    // data=[];
    selectUser();
  }

  void insertUser() async {
    MySqfliteDatabase mySqflite = MySqfliteDatabase();
    await mySqflite.insertToUser(userName: userNameController.text.toString());
    selectUser();
  }

  void updateUser({required String name, required int id}) async {
    MySqfliteDatabase mySqflite = MySqfliteDatabase();
    await mySqflite.updateToUser(name: name, id: id);
    selectUser();
  }

  void selectUser() async {
    MySqfliteDatabase mySqflite = MySqfliteDatabase();
    data = await mySqflite.selectUser();

  }

  void deleteFromUser({required int id}) async {
    MySqfliteDatabase mySqflite = MySqfliteDatabase();
    await mySqflite.deleteFromUser(id: id);
    selectUser();
  }
}
