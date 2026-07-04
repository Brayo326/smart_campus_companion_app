import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static Database? _db;

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await initDb();
    return _db!;
  }

  initDb() async {
    String path = join(await getDatabasesPath(), "students.db");
    return await openDatabase(path, version: 1, onCreate: (db, version) async {
      await db.execute(
          "CREATE TABLE students(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, course TEXT)"
      );
    });
  }

  Future<int> insertStudent(Map<String, dynamic> student) async {
    final db = await database;
    return await db.insert("students", student);
  }

  Future<List<Map<String, dynamic>>> getStudents() async {
    final db = await database;
    return await db.query("students");
  }

  Future<int> deleteStudent(int id) async {
    final db = await database;
    return await db.delete("students", where: "id = ?", whereArgs: [id]);
  }
}