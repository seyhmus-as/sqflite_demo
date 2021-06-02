import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class dbHelper{

  Database? _db;
  
  Future<Database?> get db async {
    if(_db==null){
      _db = await initializeDb();
    }
    return _db;
  }

  Future<Database?> initializeDb() async {
    String dbPath =join(await getDatabasesPath(),"etrade.db");
    var eTradeDb = openDatabase(dbPath,version: 1,onCreate: createDb);
    return eTradeDb;
  }

  void createDb(Database db, int version) async {
    await db.execute("create table product(id integer primary key, name text, description text, unitPrice integer)");
  }
}