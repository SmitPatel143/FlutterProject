import 'package:flutter_project/core/models/questions.dart';
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';

class QuestionService {
  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await openMyDatabase();
    return _database!;
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

  Future<int> insertQuestion(Questions questions) async {
    try {
      final db = await database;
      int i = await db.insert(
        'Questions',
        questions.toMap(),
      );
      return i;
    } catch (error) {
      throw Exception("Failed to insert the question");
    }
  }

  Future<List<Questions>> getAllQuestions() async {
    final db = await database;

    final List<Map<String, Object?>> questionsMap = await db.query('Questions');

    return [
      for (final {
            'id': id,
            'question': question,
            'option1': option1,
            'option2': option2,
            'option3': option3,
            'option4': option4,
          } in questionsMap)
        Questions.sendData(
            id: id,
            question: question,
            option1: option1,
            option2: option2,
            option3: option3,
            option4: option4, correctAnswerIndex: null),
    ];
  }
}
