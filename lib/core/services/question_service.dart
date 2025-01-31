import 'package:flutter_project/constants/globals.dart';
import 'package:flutter_project/core/models/questions.dart';
import 'package:flutter_project/database/localdatabase.dart';
import 'package:flutter_project/database/table_definition.dart';
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';

class QuestionService {


  Future<void> createTable() async {
    var isTableExists = await LocalDatabase.isTableExists(Globals.questionTable);
    if (!isTableExists) {
      try {
        var tableDetails =
            TableDefinition(tableName: Globals.questionTable, columns: {
          'id': 'INTEGER PRIMARY KEY AUTOINCREMENT',
          'question': 'TEXT NOT NULL',
          'option1': 'TEXT NOT NULL',
          'option2': 'TEXT NOT NULL',
          'option3': 'TEXT NOT NULL',
          'option4': 'TEXT NOT NULL',
          'correctAnswerIndex': 'INTEGER NOT NULL',
        }, foreignKeys: [
          "FOREIGN KEY(quizz_id) REFERENCES ${Globals.quizTable}(id)"
        ], indices: []);
        await LocalDatabase.createTable(tableDefinition: tableDetails);
      } catch (error) {
        throw Exception("Failed to create table");
      }
    }
  }

  Future<Database> openMyDatabase() async {
    try {
      final dbPath = await getDatabasesPath();
      final pathToDatabase = path.join(dbPath, 'questions.db');

      return await openDatabase(
        pathToDatabase,
        version: 1,
        onCreate: (db, version) async {
          await db.execute('''
          CREATE TABLE Questions(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          question TEXT NOT NULL,
          option1 TEXT NOT NULL,
          option2 TEXT NOT NULL,
          option3 TEXT NOT NULL,
          option3 TEXT NOT NULL,
          correctAnswerIndex INTEGER NOT NULL,
          )
          ''');
        },
      );
    } catch (error) {
      throw Exception('Failed to open database: $error');
    }
  }



// Future<int> insertQuestion(Questions questions) async {
//   try {
//     final db = await database;
//     int i = await db.insert(
//       'Questions',
//       questions.toMap(),
//     );
//     return i;
//   } catch (error) {
//     throw Exception("Failed to insert the question");
//   }
// }

// Future<List<Questions>> getAllQuestions() async {
//   final db = await database;
//
//   final List<Map<String, Object?>> questionsMap = await db.query('Questions');
//
//   return [];
// }
}
