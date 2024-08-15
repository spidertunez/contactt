import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:untitled22/contact.dart';

class DatabaseHelper {
  static Database? db;
  String tableName = 'contact';

  Future<Database?> getdatabase() async {
    if (db == null) {
      db = await initdatabase();
      return db;
    } else {
      return db;
    }
  }

  Future<Database> initdatabase() async {
    final path = join(await getDatabasesPath(), 'nagham.db');
    return await openDatabase(path, version: 1, onCreate: _onCreatedb);
  }

  Future _onCreatedb(Database db, int version) async {
    await db.execute('''
    CREATE TABLE $tableName (
     id INTEGER PRIMARY KEY AUTOINCREMENT,
     name TEXT NOT NULL,
     phone TEXT NOT NULL,
     imagePath TEXT NOT NULL
   )
    ''');
    print ("========================");
  }

  Future deleteContact(int id) async {
    Database? db = await getdatabase();
    await db!.delete(tableName, where: 'id = ?', whereArgs: [id]);
  }
  Future<int> deleteData(String sql, [List<Object>? arguments]) async {
    Database? db = await getdatabase();
    int response = await db!.rawDelete(sql, arguments);
    return response;
  }

  Future insertContact(contact con) async {
    Database? db = await getdatabase();
    await db!.insert(tableName, con.toMap());
  }

  Future<List<Map<String, dynamic>>> getContact() async {
    Database? db = await getdatabase();
    return await db!.query(tableName);
  }

  Future<int> updateContact(contact con) async {
    Database? db = await getdatabase();
    return await db!.update(
      tableName,
      con.toMap(),
      where: 'id = ?',
      whereArgs: [con.id],
    );
  }
}
