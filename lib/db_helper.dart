import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper{

  DBHelper._();

  static DBHelper getInstance() => DBHelper._();

  Database? db;

  static const String TABLE_NAME = "todo";
  static const String COLUMN_TODO_ID = "t_id";
  static const String COLUMN_TODO_TITLE = "t_title";
  static const String COLUMN_TODO_DESC = "t_desc";
  static const String COLUMN_TODO_CREATED_AT = "t_created_at";
  static const String COLUMN_TODO_PRIORITY = "t_priority"; ///1-> low, 2->medium, 3->high
  static const String COLUMN_TODO_IS_COMPLETED = "t_is_completed"; ///false(0) by default and true(1) when completed


  Future<Database> initDB() async{

    db ??= await openDB();

    return db!;
  }

  Future<Database> openDB() async{
    Directory dir = await getApplicationDocumentsDirectory();
    String dbPath = join(dir.path, "todoDB.db");
    return openDatabase(dbPath, version: 1, onCreate: (db, version){

      db.execute("Create table $TABLE_NAME ( $COLUMN_TODO_ID integer primary key autoincrement, $COLUMN_TODO_TITLE text, $COLUMN_TODO_DESC text, $COLUMN_TODO_CREATED_AT text, $COLUMN_TODO_PRIORITY integer, $COLUMN_TODO_IS_COMPLETED integer )");

    });
  }

  Future<bool> addTodo({required String title, required String desc, int priority = 3}) async{
    final db = await initDB();

    int rowsEffected = await db.insert(TABLE_NAME, {
      COLUMN_TODO_TITLE : title,
      COLUMN_TODO_DESC : desc,
      COLUMN_TODO_PRIORITY : priority,
      COLUMN_TODO_CREATED_AT : DateTime.now().millisecondsSinceEpoch.toString(),
      COLUMN_TODO_IS_COMPLETED : 0,
    });

    return rowsEffected>0;
  }

  Future<List<Map<String,dynamic>>> fetchAllTodo() async{
    var db = await initDB();

    List<Map<String,dynamic>> allTodo = await db.query(TABLE_NAME);

    return allTodo;

  }

  Future<bool> updateTaskCompletion({required int id, required bool isCompleted}) async{

    var db = await initDB();

    int rowsEffected = await db.update(TABLE_NAME, {
      COLUMN_TODO_IS_COMPLETED : isCompleted ? 1 : 0
    }, where: "$COLUMN_TODO_ID = ?", whereArgs: ["$id"]);

    return rowsEffected>0;
  }


}