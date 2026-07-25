import 'package:flutter/material.dart';

import '../sqlite/my_sqflite_database.dart';

class UserController {
  late TextEditingController userNameController;
  late TextEditingController userNameEditController;

  List<Map<String, Object?>> data = [];
  late MySqfliteDatabase mySqflite;

  UserController() {
    mySqflite = MySqfliteDatabase();
    userNameController = TextEditingController();
    userNameEditController = TextEditingController();
    // data=[];
    selectUser();
  }

  void insertUser() async {
    // MySqfliteDatabase mySqflite = MySqfliteDatabase();
    await mySqflite.insertToUser(userName: userNameController.text.toString());
    selectUser();
  }

  void updateUser({required String userName, required int id}) async {
    // MySqfliteDatabase mySqflite = MySqfliteDatabase();
    await mySqflite.update(userName: userName, id: id);
    selectUser();
  }

  void selectUser() async {
    // MySqfliteDatabase mySqflite = MySqfliteDatabase();
    data = await mySqflite.selectUser();
    // setState(() {});
    // return data;
  }
}
