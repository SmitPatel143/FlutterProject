import 'package:flutter_project/constants/globals.dart';
import 'package:flutter_project/core/models/questions.dart';

import 'package:flutter_project/core/models/quiz_response.dart';

import 'package:flutter_project/database/localdatabase.dart';
import 'package:get/get.dart';
import 'package:sqflite_common/sqlite_api.dart';

class ViewQuizController extends GetxController {
  static final Future<Database> _database = LocalDatabase.getDatabase;

  Future<List<QuizResponse>> getAvailableQuizzes() async {
    String query =
        "SELECT quiz.id, quiz.name, quiz.noOfQuestions, quiz.timeLimit, quiz.category_id, category.name AS category_name FROM ${Globals.quizTable} quiz LEFT JOIN ${Globals.categoryTable} category ON quiz.category_id = category.id";
    var quizzData = await (await _database).rawQuery(query);
    List<QuizResponse> quizzes = [];

    for (var quiz in quizzData) {
      String sqlQuestions =
          "SELECT * FROM ${Globals.questionTable} WHERE quizzes_id = ?";
      var questionsData =
          await (await _database).rawQuery(sqlQuestions, [quiz["id"]]);
      List<QuestionModel> questions = questionsData
          .map((questionData) => QuestionModel.fromMap(questionData))
          .toList();
      quizzes.add(QuizResponse.fromMap(quiz, questions));
    }
    return quizzes;
  }
}
