import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite_department/sqlite/crud.dart';
import 'package:path/path.dart' show join;

class MySqfliteDatabase extends CRUD {
  final String _userTable = "user";
  final String _userIdColumn = "user_id";
  final String _userNameColumn = "user_name";

  String get userNameColumn => _userNameColumn;

  String get userIdColumn => _userIdColumn;

  final String _productTable = "product";
  final String _productIdColumn = "product_id";
  final String _productNameColumn = "product_name";
  final String _productPriceColumn = "price";
  final String _productCountColumn = "count";

  final String _salesTable = "sales";
  final String _salesIdColumn = "sales_id";
  final String _salesProductIDColumn = "sales_product_id";
  final String _salesUserIDColumn = "sales_user_id";

  Database? _database;

  Future<Database> initDatabase() async {
    String path = await sqflite.getDatabasesPath();

    String managementDatabaseName = "management.db";
    String myPath = join(path, managementDatabaseName);

    int version = 2;
    _database ??= await sqflite.openDatabase(
      myPath,
      version: version,
      onOpen: (db) async => await db.execute("PRAGMA foreign_keys = ON"),
      onUpgrade: (db, oldVersion, newVersion) {
        print(db);
        print(oldVersion);
        print(newVersion);
      },
      onCreate: _onCreate,
    );
    return _database!;
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute(
      "CREATE TABLE IF NOT EXISTS $_userTable"
      " ($_userIdColumn INTEGER PRIMARY KEY AUTOINCREMENT,"
      "$_userNameColumn TEXT);",
    );
    await db.execute(
      "CREATE TABLE IF NOT EXISTS $_productTable ($_productIdColumn INTEGER PRIMARY KEY AUTOINCREMENT ,$_productNameColumn TEXT,$_productPriceColumn REAL,$_productCountColumn INTEGER);",
    );
    await db.execute(
      "CREATE TABLE IF NOT EXISTS $_salesTable"
      " ($_salesIdColumn INTEGER PRIMARY KEY AUTOINCREMENT,"
      "$_salesUserIDColumn INTEGER,"
      "$_salesProductIDColumn INTEGER,"
      "CONSTRAINT user_relations FOREIGN KEY ($_salesUserIDColumn) REFERENCES $_userTable ($_userIdColumn) ON DELETE CASCADE ON UPDATE CASCADE,"
      "CONSTRAINT product_relations FOREIGN KEY ($_salesProductIDColumn) REFERENCES $_productTable ($_productIdColumn) ON DELETE CASCADE ON UPDATE CASCADE"
      ");",
    );
  }

  @override
  Future<bool> delete({required String tableName, required where}) async {
    await initDatabase();

    int deleted = await _database!.delete(tableName, where: where);
    await _database!.close();

    return deleted == 0 ? false : true;
  }

  Future<bool> deleteFromUser({required int id}) {
    return delete(tableName: _userTable, where: "$_userIdColumn==$id");
  }

  Future<bool> deleteFromProduct({required int id}) {
    return delete(tableName: _productTable, where: "$_productIdColumn==$id");
  }

  Future<bool> insertToUser({required String userName}) {
    return insert(tableName: _userTable, values: {_userNameColumn: userName});
  }

  Future<bool> insertToProduct({
    required String name,
    required int count,
    required double price,
  }) async {
    return insert(
      tableName: _productTable,
      values: {
        _productNameColumn: name,
        _productCountColumn: count,
        _productPriceColumn: price,
      },
    );
  }

  Future<bool> insertToSales({
    required int userId,
    required int productId,
  }) async {
    return insert(
      tableName: _salesTable,
      values: {_salesProductIDColumn: productId, _salesUserIDColumn: userId},
    );
  }

  @override
  Future<bool> insert({
    required Map<String, Object?> values,
    required String tableName,
  }) async {
    await initDatabase();

    int inserted = await _database!.insert(tableName, values);
    await _database!.close();
    return inserted == 0 ? false : true;
  }

  Future<List<Map<String, Object?>>> selectUser() async {
    return select(tableName: _userTable);
  }

  Future<List<Map<String, Object?>>> selectProduct() async {
    return select(tableName: _productTable);
  }

  Future<List<Map<String, Object?>>> selectSales() async {
    return selectInSales();
  }

  Future<List<Map<String, Object?>>> selectTSales() async {
    return selectSales();
  }

  @override
  Future<List<Map<String, Object?>>> select({required String tableName}) async {
    await initDatabase();

    List<Map<String, Object?>> data = await _database!.query(tableName);
    await _database!.close();
    return data;
  }

  Future<List<Map<String, Object?>>> selectInSales() async {
    await initDatabase();

    List<Map<String, Object?>> data = await _database!.rawQuery(
      "SELECT $_userNameColumn,$_productNameColumn "
      "FROM $_userTable,$_productTable,$_salesTable "
      "WHERE $_salesProductIDColumn==$_productIdColumn AND $_salesUserIDColumn==$_userIdColumn",
    );
    await _database!.close();
    return data;
  }

  Future<bool> updateToUser({required String name, required int id}) async {
    return update(
      tableName: _userTable,
      values: {_userIdColumn: id, _userNameColumn: name},
      where: "$_userIdColumn=$id",
    );
  }

  Future<bool> updateToProduct({
    required String name,
    required double price,
    required int count,
    required int id,
  }) async {
    return update(
      tableName: _productTable,
      values: {
        // _productIdColumn: id,
        _productNameColumn: name,
        _productCountColumn: count,
        _productPriceColumn: price,
      },
      where: "$_productIdColumn=$id",
    );
  }

  @override
  Future<bool> update({
    required Map<String, Object?> values,
    required String tableName,
    required String where,
  }) async {
    await initDatabase();

    int updated = await _database!.update(
      tableName,
      //     {
      //   _userNameColumn: userName,
      // },
      values,
      where: where,
    );
    await _database!.close();
    return updated == 0 ? false : true;
  }
}
