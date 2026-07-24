import 'package:flutter/material.dart';

import '../sqlite/my_sqflite_database.dart';

class UserController {
  late TextEditingController userNameController;

  List<Map<String, Object?>> data = [];

  UserController() {
    userNameController = TextEditingController();
    // data=[];
    selectUser();
  }

  void insertUser() async {
    MySqfliteDatabase mySqflite = MySqfliteDatabase();
    await mySqflite.insertToUser(userName: userNameController.text.toString());
    selectUser();
  }

  void selectUser() async {
    MySqfliteDatabase mySqflite = MySqfliteDatabase();
    data = await mySqflite.select(tableName: "user");
    // setState(() {});
    // return data;
  }
}
