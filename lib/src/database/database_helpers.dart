import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class DatabaseHelper {
  static final _databaseName = "pruebaGBP.db";
  static final _databaseVersion = 1;

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database _database;
  Future<Database> get database async {
    if(_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();

    String path = join(documentsDirectory.path, _databaseName);
    // Open the database. Can also add an onUpdate callback parameter.
    return await openDatabase(path,
        version: _databaseVersion,
        onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
              CREATE TABLE UserTask (
                Id INTEGER PRIMARY KEY AUTOINCREMENT,
                UserID INTEGER NOT NULL,
                Description TEXT NOT NULL,
                Status INTEGER NOT NULL
              )
              ''');
  }

  insertDB(String table,  Map values) async {
    print(values);
    Database db = await  database;
    int id = await db.insert(table, values);
    return id;
  }

  rawInsertOrReplace(String table, String colums, List<dynamic> values) async{
    Database db = await  database;
    String singValues = "";

    values.forEach((i){
      singValues +=  "?,";
    });

    singValues = singValues.substring(0, singValues.length -1);
    final res = await db.rawInsert('''
    INSERT OR REPLACE INTO ${table}(${colums}) VALUES($singValues)
    '''
        , values);

    return res;
  }

  selectQuery(String table, List<String> cols, String where,  List<dynamic> whereArgs) async {
    Database db = await database;

    List<Map> maps = await db.query(table, columns: cols, where: where , whereArgs: whereArgs);
    if(maps.length > 0) {
      return maps;
    }

    return null;
  }

  Future<void> update(String table, Map<String, dynamic> values, String where,  List<dynamic> whereArgs) async {
    Database db = await database;
    final res = await db.update(table, values,where: where, whereArgs: whereArgs);
    print(res);
  }

}