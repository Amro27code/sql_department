import 'package:flutter/widgets.dart';
import 'package:sqflite_department/sqlite/my_sqflite_database.dart';

class ProductController {
  late TextEditingController productNameController;
  late TextEditingController productPriceController;
  late TextEditingController productCountController;
  List<Map<String, Object?>> data = [];

  ProductController() {
    productNameController = TextEditingController();
    productPriceController = TextEditingController();
    productCountController = TextEditingController();
  }

  Future<void> select() async {
    MySqfliteDatabase mySqfliteDatabase = MySqfliteDatabase();
    data = await mySqfliteDatabase.selectProduct();
  }

  Future<void> insert() async {
    MySqfliteDatabase mySqfliteDatabase = MySqfliteDatabase();
    await mySqfliteDatabase.insertToProduct(
      name: productNameController.text.toString(),
      count:int.tryParse( productCountController.text.toString())??0,
      price: double.tryParse(productPriceController.text.toString())??0,
    );
    select();
  }
}
