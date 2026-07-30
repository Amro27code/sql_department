import 'package:sqflite_department/sqlite/my_sqflite_database.dart';

class SalesController {
  List dataUserSales = []; //["amro","ammar","ali","obaida"];
  List dataProductSales = [];
  int itemUserSelected = 0;
  int itemProductSelected = 0;

  SalesController() {
    selectUser();
    selectProduct();
  }

  Future<void> selectUser() async {
    MySqfliteDatabase mySqfliteDatabase = MySqfliteDatabase();
    dataUserSales = await mySqfliteDatabase.selectUser();
    // print(dataUserSales);
    itemUserSelected = dataUserSales[0]["user_id"];
  }
  Future<void> selectProduct() async {
    MySqfliteDatabase db=MySqfliteDatabase();
    dataProductSales=await db.selectProduct();
    itemProductSelected=dataProductSales[0]["product_id"];
  }
}
