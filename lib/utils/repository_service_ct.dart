//import 'package:ct_personal/utils/ct_persona.dart';
//import 'package:ct_personal/utils/database_creator.dart';
//import 'package:sqflite/sqflite.dart';
//import 'dart:async';

//Database db;

class RepositoryServiceCT {

  /*static Future<List<CTPersona>> getAllTodos() async {
    final sql = '''SELECT * FROM ${DatabaseCreator.todoTable}''';
    final data = await db.rawQuery(sql);
    List<CTPersona> todos = List();

    for (final node in data) {
      final todo = CTPersona.fromJson(node);
      todos.add(todo);
      //data.isNotEmpty ? data.toList().map((c) => Client.fromMap(c)) : null;
    }
    return todos;
  }

  static Future<List> getAllTodos2() async {
     final sql = '''SELECT * FROM ${DatabaseCreator.todoTable}''';
    var result = await db.rawQuery(sql);
    return result.toList();
  }

  static Future<String> getCod(String pathTotal) async {
    
    String code = '';

    try {
      db = await openDatabase(pathTotal);

      final sql = '''SELECT cod FROM ${DatabaseCreator.todoTable}''';
      final data = await db.rawQuery(sql);      
      code = data[0]["cod"].toString();
      db.close();
    } catch (e) {
      print('Error en getCod: $e');
    }    
    return code;
  }

  static Future<void> addTodo(CTPersona persona) async {
    final sql = '''INSERT INTO ${DatabaseCreator.todoTable}(
      ${DatabaseCreator.nombre},
      ${DatabaseCreator.documento},
      ${DatabaseCreator.cargo},
      ${DatabaseCreator.cod},
      ${DatabaseCreator.apellido}
    )
    VALUES
    (
      "${persona.nombre}",
      "${persona.documento}",
      "${persona.cargo}",
      "${persona.cod}",
      "${persona.apellido}"
    )''';
    try{
      await db.rawInsert(sql);
      db.close();
    }catch (e) {
        print ('Error en addTodo: $e');
    }    
    
    //DatabaseCreator.datadaseLog("Add ct_persona", sql, null, result);
  }
    
  static Future<void> updateTodo(CTPersona persona) async {
    final sql = '''UPDATE ${DatabaseCreator.todoTable}
      SET   ${DatabaseCreator.cargo} = "${persona.cargo}"
      WHERE ${DatabaseCreator.documento} = "${persona.documento}"
    ''';

    await db.rawUpdate(sql);
    //DatabaseCreator.datadaseLog("Add ct_persona", sql, null, result);
  }

  static Future<int> countTodo() async{
    final data = await db.rawQuery('''SELECT COUNT(*) FROM ${DatabaseCreator.todoTable}''');

    int count = data[0].values.elementAt(0);
    return count;
  }*/
}
