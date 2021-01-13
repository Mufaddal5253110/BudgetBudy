import 'dart:async';

import '../models/transaction.dart';

import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class DBHelper {
  // function to create the database
  static Future<sql.Database> getDatabase() async {
    final dbpath = await sql.getDatabasesPath();
    return sql.openDatabase(path.join(dbpath, 'spendings.db'),
        onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE transactions(id TEXT PRIMARY KEY,title TEXT,amount INTEGER,date TEXT,category TEXT)');
    }, version: 1);
  }

  //Inserting the transaction data
  static Future<void> insert(Transaction transaction) async {
    final db = await DBHelper.getDatabase();
    await db.insert('transactions', transaction.toMap(transaction),
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  //Retereving the transaction data
  static Future<List<Map<String, dynamic>>> fetch() async {
    final sqlDb = await DBHelper.getDatabase();
    return sqlDb.query('transactions');
  }

  //deleting the transactions
  static Future<void> delete(String id) async {
    final sqlDb = await DBHelper.getDatabase();
    await sqlDb.delete('transactions', where: "id=?", whereArgs: [id]);
  }
}
