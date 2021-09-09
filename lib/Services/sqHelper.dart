import 'dart:io';
import 'package:ecommerce/Models/ProductsResponse.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  DbHelper._();

  static DbHelper x = DbHelper._();
  Database database;
  static final String tableName = 'Favourite';
  static final String tableName2 = 'Cards';
  static final String databasename = 'taskDb.db';

  static final String idColumnName = 'id';
  static final String titleColumnName = 'title';
  static final String priceteColumnName = 'price';
  static final String descriptionColumnName = 'description';
  static final String imageColumnName = 'image';
  static final String categoryColumnName = 'category';
  static final String quntityColumnName = 'Quntity';

  intiateDatabase() async {
    database = await getDatBaseConnection();
  }

  Future<Database> getDatBaseConnection() async {
    //library :path provider
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + '/$databasename';
    Database database =
        await openDatabase(path, version: 1, onOpen: (database) {
      print('the data base is opened');
    }, onCreate: (db, v) {
      print('the data base is created');
      db.execute(
          '''CREATE TABLE $tableName ($idColumnName INTEGER PRIMARY KEY,
           $titleColumnName TEXT, $priceteColumnName  NUM, $descriptionColumnName TEXT,
          $imageColumnName TEXT,$categoryColumnName TEXT,$quntityColumnName NUM)''');

      db.execute( '''CREATE TABLE $tableName2 ($idColumnName INTEGER PRIMARY KEY,
           $titleColumnName TEXT, $priceteColumnName  NUM, $descriptionColumnName TEXT,
           $imageColumnName TEXT,$categoryColumnName TEXT,$quntityColumnName NUM)''');
    }, onUpgrade: (db, old, newV) {
      db.execute(
          '''CREATE TABLE Test (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, IsCOMPLETE  INTEGER, num REAL)''');
    });
    return database;
  }

  insertProductFavourite(ProductResponse productResponse) async {
    int rownum = await database.insert(tableName, productResponse.toJsonD());
    print(rownum);
  }

  insertProductCard(ProductResponse productResponse) async {
    int rownum = await database.insert(tableName2, productResponse.toJsonD());
    print(rownum);
  }


  Future<List<ProductResponse>> getAllProductsFavourite() async {
    List<Map<String, Object>> results = await database.query(tableName);
    List<ProductResponse> productResponses =
        results.map((e) => ProductResponse.fromJsonD(e)).toList();
    return productResponses;
  }


  Future<List<ProductResponse>> getAllProductsCard() async {
    List<Map<String, Object>> results = await database.query(tableName2);
    List<ProductResponse> productResponses =
    results.map((e) => ProductResponse.fromJsonD(e)).toList();
    return productResponses;
  }

  Future<ProductResponse> getSpecificProductFavourite(int id) async {
    List<Map<String, dynamic>> results =
        await database.query(tableName, where: 'id=?', whereArgs: [id]);
    ProductResponse productResponse = ProductResponse.fromJsonD(results.first);
    return productResponse;
  }

  Future<ProductResponse> getSpecificProductCard(int id) async {
    List<Map<String, dynamic>> results =
    await database.query(tableName2, where: 'id=?', whereArgs: [id]);
    ProductResponse productResponse = ProductResponse.fromJsonD(results.first);
    return productResponse;
  }

  deleteProductFavourite(ProductResponse productResponse) async {
    database.delete(tableName, where: 'id=?', whereArgs: [productResponse.id]);
  }

  deleteProductCard(ProductResponse productResponse) async {
    database.delete(tableName2, where: 'id=?', whereArgs: [productResponse.id]);
  }


  Future<List<dynamic>> getTableNames() async {
    List<Map<String, Object>> tables = await database
        .query('sqlite_master', where: 'type=?', whereArgs: ['table']);
    List<dynamic> tabelnames = tables.map((e) => e['name']).toList();
    print(tabelnames);
    return tabelnames;
  }
}
