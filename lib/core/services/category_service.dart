import 'package:flutter_project/constants/globals.dart';
import 'package:flutter_project/core/models/category.dart';
import 'package:flutter_project/database/table_definition.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;
import 'package:flutter_project/database/localdatabase.dart';

class CategoryService {
  static final CategoryService _instance = CategoryService._internal();

  factory CategoryService() {
    return _instance;
  }

  CategoryService._internal() {
    createTable();
  }

  Future<void> createTable() async {
    var isTableExists =
        await LocalDatabase.isTableExists(Globals.categoryTable);
    if (!isTableExists) {
      try {
        var tableDetails =
            TableDefinition(tableName: Globals.categoryTable, columns: {
          'id': 'INTEGER PRIMARY KEY AUTOINCREMENT',
          'name': 'TEXT UNIQUE NOT NULL',
        }, foreignKeys: [], indices: []);
        await LocalDatabase.createTable(tableDefinition: tableDetails);
      } catch (error) {
        throw Exception("Failed to create table of ${Globals.categoryTable}");
      }
    }
  }

  Future<int> insertCategory(Category category) async {
    try {
      return await LocalDatabase.insertData(
          tableName: Globals.categoryTable, data: category.toMap());
    } catch (error) {
      throw Exception("Failed to insert the category");
    }
  }

  Future<List<Category>> getAllCategories() async {
    try {
      var data =
          await LocalDatabase.getTableData(tableName: Globals.categoryTable)
              .then((list) =>
                  list.map((category) => Category.fromMap(category)).toList());
      return data;
    } catch (error) {
      throw Exception('Failed to get categories: ${error.toString()}');
    }
  }
}
