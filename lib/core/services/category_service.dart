import 'package:flutter_project/core/models/category.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;

class CategoryService {
  static CategoryService? _instance;
  static Database? _database;

  CategoryService._();

  static Future<CategoryService> getInstance() async {
    if (_instance == null) {
      _instance = CategoryService._();
      _database = await _openDatabase();
    }
    return _instance!;
  }

  Future<Database> get _getDatabase async {
    return _database ??= await _openDatabase();
  }

  static Future<Database> _openDatabase() async {
    try {
      final dbPath = await getDatabasesPath();
      final pathToDatabase = path.join(dbPath, 'my_database2.db');

      return await openDatabase(
        pathToDatabase,
        version: 2,
        onCreate: _onCreate,
      );
    } catch (error) {
      throw Exception('Failed to open database: $error');
    }
  }

  static Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE Category (
        id INTEGER PRIMARY KEY,
        name TEXT UNIQUE
      )
    ''');
  }

  Future<int> insertCategory(Category category) async {
    try {
      final db = await _getDatabase;
      return await _database!.transaction((txn) async {
        return await txn.insert("Category", category.toMap());
      });
    } on DatabaseException catch (error) {
      if (error.isUniqueConstraintError()) {
        throw Exception("Category already exists with this name");
      }
      throw Exception("Failed to insert the category");
    } catch (error) {
      throw Exception("Failed to insert the category");
    }
  }

  Future<List<Category>> getAllCategories() async {
    try {
      final db = await _getDatabase;
      final List<Map<String, dynamic>> maps = await db.query('Category');

      return List.generate(
        maps.length,
        (index) => Category.fromMap(maps[index]),
      );
    } catch (error) {
      throw Exception('Failed to get categories: ${error.toString()}');
    }
  }

  Future<void> close() async {
    final db = await _getDatabase;
    await db.close();
    _database = null;
    _instance = null;
  }
}
