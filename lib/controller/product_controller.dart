import 'package:flutter/widgets.dart';
import 'package:sqflite_department/sqlite/my_sqflite_database.dart';

class ProductController {
  late TextEditingController productNameController;
  late TextEditingController productPriceController;
  late TextEditingController productCountController;

  late TextEditingController productEditNameController;
  late TextEditingController productEditPriceController;
  late TextEditingController productEditCountController;
  List<Map<String, Object?>> data = [];

  ProductController() {
    productNameController = TextEditingController();
    productPriceController = TextEditingController();
    productCountController = TextEditingController();

    productEditNameController = TextEditingController();
    productEditPriceController = TextEditingController();
    productEditCountController = TextEditingController();
  }

  Future<void> select() async {
    MySqfliteDatabase mySqfliteDatabase = MySqfliteDatabase();
    data = await mySqfliteDatabase.selectProduct();
  }

  Future<void> insert() async {
    MySqfliteDatabase mySqfliteDatabase = MySqfliteDatabase();
    await mySqfliteDatabase.insertToProduct(
      name: productNameController.text.toString(),
      count: int.tryParse(productCountController.text.toString()) ?? 0,
      price: double.tryParse(productPriceController.text.toString()) ?? 0,
    );
    select();
  }

  Future<void> update({
    required int id , required int count, required double price, required String name,
  }) async {
    MySqfliteDatabase mySqfliteDatabase = MySqfliteDatabase();
    await mySqfliteDatabase.updateToProduct(
      id: id,
      name: name,//productEditNameController.text.toString(),
      count:count,//int.tryParse(productEditCountController.text.toString()) ?? 0,
      price:price//double.tryParse(productEditPriceController.text.toString()) ?? 0,
    );
    select();
  }

  Future<void> delete({required int id}) async {
    MySqfliteDatabase mySqfliteDatabase = MySqfliteDatabase();
    await mySqfliteDatabase.deleteFromProduct(id: id);
    select();
  }
}
