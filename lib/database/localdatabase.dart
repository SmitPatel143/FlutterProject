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
      return await openDatabase(pathToDatabase, version: Globals.localDatabaseVersion);
    } catch (error) {
      throw Exception("Failed Connect with the local database: $error");
    }
  }

  static Future<void> createTable({required TableDefinition tableDefinition}) async {
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

  Future<List<Map<String, Object?>>> getTableData<T>({required String tableName, String? condition}) async {
    try {
      final Database database = await _getDatabase;
      final String getQuery = '''
        SELECT * FROM $tableName
        ${condition != null ? 'WHERE $condition' : ''}
      ''';
      return database.query(getQuery);
    } catch (error) {
      throw Exception("Failed to get table data of $tableName: $error");
    }
  }
}
