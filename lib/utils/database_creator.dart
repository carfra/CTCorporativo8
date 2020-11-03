import 'dart:io';
import 'package:path/path.dart';
//import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';

//Database db;

//https://www.youtube.com/watch?v=9D1VX6uGylU

class DatabaseCreator {
  static const todoTable = 'ct_persona';
  static const id = 'id';
  static const nombre = 'nombre';
  static const documento = 'documento';
  static const cargo = 'cargo';
  static const cod = 'cod';
  static const apellido = 'apellido';

  void datadaseLog(String functionName, String sql, [List<Map<String, dynamic>> selectQueryResult, int insertAndUpdateQueryResult]) {
    print(functionName);
    print(sql);
    
    if (selectQueryResult != null){
      print(selectQueryResult);
    } else if (insertAndUpdateQueryResult != null) {
      print(insertAndUpdateQueryResult);
    }
  }

  /*Future<void> createTodoTable (Database db) async {
    final todoSql = '''CREATE TABLE $todoTable (
        $id INTEGER PRIMARY KEY AUTOINCREMENT,
        $nombre TEXT,
        $documento TEXT,
        $cargo TEXT,
        $cod TEXT,
        $apellido TEXT
      )''';

      await db.execute (todoSql);
    }*/

  Future<String> getDatabasePath(String dbName) async {
    //final databasePath = await getDatabasesPath();
    //final path = join(databasePath, dbName);
    
    final databasePath = await getApplicationDocumentsDirectory();
    final path = join(databasePath.path, dbName);

    //Asegurarse que la ruta existe
    //if (FileSystemEntity.typeSync(path) == FileSystemEntityType.notFound){
    //   Directory(dirname(path)).create(recursive: true);
    //}

    //if (await Directory(dirname(path)).exists()){
        //await deleteDatabase(path); //ver si aplica ???
    //} else {
    //  await Directory(dirname(path)).create(recursive: true);
    //}

    return path;
  }

  /*Future<void> initDatabase(String pathTotal) async {
    //final path = await getDatabasePath('ct_db.db');
    //final path = await getApplicationDocumentsDirectory();
    //final pathTotal = join(path.path, 'ct_db.db');

    //db = await openDatabase(pathTotal, version: 1, onCreate: onCreate);
    //print (db);
    db = await openDatabase(pathTotal, version: 1, onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE ct_persona ("
        "id integer PRIMARY KEY AUTOINCREMENT,"
        "nombre TEXT,"
        "documento TEXT,"
        "cargo TEXT,"
        "cod TEXT,"
        "apellido TEXT"
      ")");
    });
    print ('Creado...');
  }*/

  static File _localFile(String pathTotal) {
      return File('$pathTotal');
  }

  static void writeCode(String pathTotal, String code) {
    final file = _localFile(pathTotal);
    // Write the file.
    return file.writeAsStringSync('$code');
  }

  static void deleteCode(String pathTotal) {
    final file = _localFile(pathTotal);
    return file.deleteSync(recursive: true);
  }

  static String readCod(String pathTotal) {
    try {
      final file = _localFile(pathTotal);

      // Read the file.
      String contents = file.readAsStringSync();

      return contents;
    } catch (e) {
      print ('Error: $e');
      return null;
    }
  }

  /*Future<void> initDatabase2(String pathTotal) async {

    //db = await openDatabase(pathTotal, version: 1, onCreate: onCreate);
    db = await openDatabase(pathTotal);
  }*/

  /*Future<void> onCreate(Database db, int version) async {
    await createTodoTable(db);
  }*/
}
