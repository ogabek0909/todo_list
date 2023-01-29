import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper with ChangeNotifier {
  Future<Database> dbOpen() async {
    final path = await getDatabasesPath();
    return openDatabase(
      '$path/core2.db',
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
            'CREATE TABLE test(id TEXT PRIMARY KEY, title TEXT, done INTEGER, note TEXT, date TEXT)');
      },
    );
  }

  Future addTodo(
      {required String title,
      required String note,
      required DateTime date}) async {
    final db = await dbOpen();
    db.insert(
      'test',
      {
        'id': DateTime.now().toIso8601String(),
        'title': title,
        'done': 0,
        'note': note,
        'date': date.toIso8601String()
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future getTodo() async {
    final db = await dbOpen();
    final justTodo = db.query('test');
    _todoList = await justTodo;
    notifyListeners();
    
  }

  Future deleteTodo(String id) async {
    final db = await dbOpen();
    db.delete(
      'test',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future updateTodo(bool newvalue, String id,int index) async {
    final db = await dbOpen();
    await db.update(
      'test',
      {'done': newvalue ? 1 : 0},
      where: 'id = ?',
      whereArgs: [id],
    );
    
    notifyListeners();
    
  }

  List<Map> _todoList = [];

  List<Map> get todoList{
    return [..._todoList];
  } 

}
