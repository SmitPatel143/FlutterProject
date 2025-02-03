import 'package:flutter_project/database/table_definition.dart';
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';
import '../constants/globals.dart';

class LocalDatabase {
  static Database? database;
  static LocalDatabase? localDatabase;

  LocalDatabase._();

  static Future<LocalDatabase> getInstance() async {
    localDatabase ??= LocalDatabase._();
    database ??= await _openDatabaseConnection();
    return localDatabase!;
  }

  static Future<Database> get _getDatabase async {
    database ??= await _openDatabaseConnection();
    return database!;
  }

  static Future<Database> _openDatabaseConnection() async {
    try {
      final dbPath = await getDatabasesPath();
      final pathToDatabase = path.join(dbPath, Globals.localDatabaseName);
      return await openDatabase(pathToDatabase,
          version: Globals.localDatabaseVersion);
    } catch (error) {
      throw Exception("Failed Connect with the local database: $error");
    }
  }

  static Future<void> createTable(
      {required TableDefinition tableDefinition}) async {
    try {
      final Database database = await _getDatabase;
      final List<String> columnDefinitions =
          tableDefinition.columns.entries.map((entry) {
        return '${entry.key} ${entry.value}';
      }).toList();

      if (tableDefinition.foreignKeys.isNotEmpty) {
        columnDefinitions.addAll(tableDefinition.foreignKeys);
      }

      final String createQuery = '''
        CREATE TABLE IF NOT EXISTS ${tableDefinition.tableName} (
          ${columnDefinitions.join(', ')}
        )
      ''';
      await database.execute(createQuery);
      for (String index in tableDefinition.indices) {
        await database.execute(index);
      }
    } catch (error) {
      throw Exception(
          "Failed to create table ${tableDefinition.tableName}: $error");
    }
  }

  static Future<int> insertData(
      {required String tableName, required Map<String, Object?> data}) async {
    try {
      final Database database = await _getDatabase;
      return database.insert(tableName, data);
    } catch (error) {
      throw Exception("Failed to insert data into $tableName: $error");
    }
  }

  static Future<List<Map<String, Object?>>> getTableData<T>(
      {required String tableName, String? condition}) async {
    try {
      final Database database = await _getDatabase;
      return await database.query(tableName, where: condition);
    } catch (error) {
      throw Exception("Failed to get table data of $tableName: $error");
    }
  }

  static Future<bool> isTableExists(String tableName) async {
    try {
      final Database database = await _getDatabase;
      final result = await database.rawQuery(
          "SELECT COUNT(*) as count FROM sqlite_master WHERE type='table' AND name='$tableName'");
      print("Existing Table result $result");
      return result[0]["count"] != 0;
    } catch (error) {
      throw Exception("Failed to check table existence: $error");
    }
  }

  static Future<void> createQuizTable() async {
    final database = await _getDatabase;
    await database.execute('''
      CREATE TABLE IF NOT EXISTS ${Globals.quizTable} (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        timeLimit DATETIME NOT NULL,
        noOfQuestions INTEGER NOT NULL,
        category_id INTEGER NOT NULL,
        FOREIGN KEY(category_id) REFERENCES ${Globals.categoryTable}(id)
      )
    ''');
    print(isTableExists(Globals.quizTable));
  }

  static Future<void> createQuestionsTable() async {
    final database = await _getDatabase;
    await database.execute('''
      CREATE TABLE IF NOT EXISTS ${Globals.questionTable} (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        question TEXT NOT NULL,
        option1 TEXT NOT NULL,
        option2 TEXT NOT NULL,
        option3 TEXT NOT NULL,
        option4 TEXT NOT NULL,
        correctAnswerIndex INTEGER NOT NULL,
        quizzes_id INTEGER NOT NULL,
        FOREIGN KEY(quizzes_id) REFERENCES ${Globals.quizTable}(id)
      )
    ''');

  }
}
