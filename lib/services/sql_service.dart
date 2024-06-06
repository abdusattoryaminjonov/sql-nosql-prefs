import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../models/sql_card.dart';


class SqlService{
  static const _databaseName = "my_sqldb.db";
  static const _databaseVersion = 1;

  static Database? _database;

  static Future<void> init() async {
    _database = await _initDatabase();
  }

  static _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  static Future _onCreate(Database db, int version) async {
    await db.execute('''
        CREATE TABLE cards (
          id INTEGER PRIMARY KEY,
          cardNumber TEXT NOT NULL,
          expiredDate TEXT NOT NULL,
          cardType TEXT NOT NULL,
          cardImage TEXT NOT NULL
         )''');
  }

  static Future<SqlCard> createPost(SqlCard sqlCard) async {
    Database db = _database!;
    await db.insert("cards", sqlCard.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return sqlCard;
  }

  static Future<List<SqlCard>> fetchSqlCards() async {
    Database db = _database!;
    List<Map<String, dynamic>> results = await db.query("cards");

    List<SqlCard> posts = [];
    results.forEach((result) {
      SqlCard sqlCard = SqlCard.fromMap(result);
      posts.add(sqlCard);
    });
    return posts;
  }

}