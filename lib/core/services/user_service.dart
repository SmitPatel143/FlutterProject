import 'package:flutter_project/core/models/user.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;

class UserService {
  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await openMyDatabase();
    return _database!;
  }

  Future<Database> openMyDatabase() async {
    try {
      final dbPath = await getDatabasesPath();
      final pathToDatabase = path.join(dbPath, 'my_database.db');

      return await openDatabase(
        pathToDatabase,
        version: 1,
        onCreate: (db, version) async {
          await db.execute('''
              CREATE TABLE user(
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              firstName TEXT NOT NULL,
              lastName TEXT NOT NULL,
              email TEXT UNIQUE NOT NULL,
              password TEXT NOT NULL
          )
          ''');
        },
      );
    } catch (error) {
      throw Exception('Failed to open database: $error');
    }
  }

  Future<int> insertUser(User user) async {
    try {
      final db = await database;
      int i = await db.insert(
        'user',
        user.toMap(),
      );
      return i;
    } on DatabaseException catch (error) {
      if (error.isUniqueConstraintError()) {
        throw Exception("User already exists with this Email");
      }
      throw Exception("Failed to insert the user");
    } catch (error) {
      throw Exception("Failed to insert the user");
    }
  }

  void printAllUsers() async {
    List<User> users = await UserService().getAllUser();

    for (User user in users) {
      print("User: ${user.firstName} ${user.lastName}, Email: ${user.email}");
    }
  }

  Future<List<User>> getAllUser() async {
    try {
      final db = await database;
      print("Fetching all user");
      final List<Map<String, dynamic>> maps = await db.query('user');
      return List.generate(maps.length, (index) => User.fromMap(maps[index]));
    } catch (e) {
      throw Exception('Failed to get users');
    }
  }
}
