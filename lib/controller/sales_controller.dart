import 'package:sqflite_department/sqlite/my_sqflite_database.dart';

class SalesController {
  List<Map<String, Object?>> dataUserSales = [];
  List<Map<String, Object?>> dataProductSales = [];
  List<Map<String, Object?>> salesData = [];

  int?
  itemUserSelected; //TODO عشان في فنكشن ال select حاطه في futureBuilder وبقدرش يحدث ال   itemUserSelected فالحل خليه nullable
  int? itemProductSelected;

  SalesController() {
    // selectUser();
    initial();
    // selectProduct();
  }

  void initial() async {
    await selectUser();
    itemUserSelected = dataUserSales[0]["user_id"] as int?;
    await selectProduct();
    itemProductSelected = dataProductSales[0]["product_id"] as int?;
  }

  Future<void> selectUser() async {
    MySqfliteDatabase mySqfliteDatabase = MySqfliteDatabase();
    dataUserSales = await mySqfliteDatabase.selectUser();
    // itemUserSelected = dataUserSales[0]["user_id"];//TODO شلناهم وخليناهم ففي ال initial عشان ما يصير مشاكل في الاختيار
  }

  Future<void> selectProduct() async {
    MySqfliteDatabase db = MySqfliteDatabase();
    dataProductSales = await db.selectProduct();
    // itemProductSelected = dataProductSales[0]["product_id"];
  }

  Future<void> selectSales() async {
    MySqfliteDatabase db = MySqfliteDatabase();
    salesData = await db.selectSales();
  }

  Future<void> insert({
    required String userName,
    required String productName,
  }) async {
    MySqfliteDatabase db = MySqfliteDatabase();
    await db.insertToSales(userName: userName, productName: productName);
    selectSales();
    // selectUser();
    // selectProduct();
  }
}
