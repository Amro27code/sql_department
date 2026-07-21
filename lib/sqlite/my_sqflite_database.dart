import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite_department/sqlite/crud.dart';
import 'package:path/path.dart' show join;

class MySqfliteDatabase extends CRUD {
  final String _userTable = "user";
  final String _userIdColumn = "user_id";
  final String _userNameColumn = "user_name";

  final String _productTable = "product";
  final String _productIdColumn = "product_id";
  final String _productNameColumn = "product_name";
  final String _productPriceColumn = "price";
  final String _productCountColumn = "count";

  final String _salesTable = "sales";
  final String _salesIdColumn = "sales_id";
  final String _salesProductNameColumn = "sales_product_name";
  final String _salesUserNameColumn = "sales_user_name";

  void initDatabase() async {
    String path = await sqflite.getDatabasesPath();

    String managementDatabaseName = "management.db";
    String myPath = join(path, managementDatabaseName);

    int version = 1;
    sqflite.openDatabase(myPath, version: version, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute(
      "CREATE TABLE $_userTable"
      " ($_userIdColumn INTEGER PRIMARY KEY,"
      "$_userNameColumn TEXT);",
    );
    await db.execute(
      "CREATE TABLE $_productTable ($_productIdColumn INTEGER PRIMARY KEY,$_productNameColumn TEXT,$_productPriceColumn REAL,$_productCountColumn INTEGER);",
    );
    await db.execute(
      "CREATE TABLE $_salesTable"
      " ($_salesIdColumn INTEGER PRIMARY KEY,"
      "$_salesUserNameColumn TEXT,"
      "$_salesProductNameColumn TEXT);",
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
