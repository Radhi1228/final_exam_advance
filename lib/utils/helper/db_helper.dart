import 'dart:io';
import 'package:final_exam_ad/screen/home/model/home_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import '../../screen/cart/model/cart_model.dart';

class DBHelper {
  static DBHelper helper = DBHelper._();

  DBHelper._();

  Database? database;

  Future<Database>? checkDb() async {
    if (database != null) {
      return database!;
    } else {
      return await initDb();
    }
  }

  Future<Database> initDb() async {
    Directory dir = await getApplicationSupportDirectory();
    String path = join(dir.path, "database.db");

    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        String productQuary =
            "CREATE TABLE products (id INTEGER PRIMARY KEY AUTOINCREMENT,product TEXT,price TEXT,qua TEXT,image TEXT)";
        String cartQuary =
            "CREATE TABLE cart (id INTEGER PRIMARY KEY AUTOINCREMENT,product TEXT,price TEXT,qua TEXT,image TEXT)";
        db.execute(productQuary);
        db.execute(cartQuary);
      },
    );
  }

  Future<void> insertCart(HomeModel model) async {
    database = await checkDb();
    database!.insert(
      "cart",
      {
        "product": model.product,
        "price": model.price,
        "qua": model.qua,
      },
    );
  }

  Future<List<CartModel>>? readCart() async {
    database = await checkDb();
    String data1 = "SELECT * FROM cart";
    List<Map> list = await database!.rawQuery(data1);
    List<CartModel> l1 = list.map((e) => CartModel.mapToModel(e)).toList();
    return l1;
  }

  Future<void> deleteCart(int id) async {
    database = await checkDb();
    database!.delete("cart", where: "id=?", whereArgs: [id]);
  }

  void updateCart(CartModel model) async {
    database = await checkDb();
    database!.update(
        "cart",
        {
          "product": model.product,
          "qua": model.qua,
          "price": model.price,
        },
        where: "id=?",
        whereArgs: [model.id]);
  }
}
