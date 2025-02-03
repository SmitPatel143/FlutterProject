import 'package:flutter_project/constants/globals.dart';
import 'package:flutter_project/core/models/category.dart';
import 'package:flutter_project/database/localdatabase.dart';
import 'package:flutter_project/database/table_definition.dart';

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
      insertCategory(Category.name("Mathematics"));
      insertCategory(Category.name("Physics"));
      insertCategory(Category.name("Chemistry"));
      insertCategory(Category.name("Economics"));
      insertCategory(Category.name("English"));

      var data = await LocalDatabase.getTableData(tableName: Globals.categoryTable)
              .then((list) =>
                  list.map((category) => Category.fromMap(category)).toList());
      return data;
    } catch (error) {
      throw Exception('Failed to get categories: ${error.toString()}');
    }
  }
}
