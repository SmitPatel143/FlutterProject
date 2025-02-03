import 'package:flutter/cupertino.dart';
import 'package:flutter_project/constants/globals.dart';
import 'package:flutter_project/core/controllers/category_controller.dart';
import 'package:flutter_project/core/controllers/quiz_controller.dart';
import 'package:flutter_project/core/models/questions.dart';
import 'package:flutter_project/database/localdatabase.dart';
import 'package:get/get.dart';

import '../models/quiz.dart';

class QuestionController extends GetxController {
  var categoryController = Get.find<CategoryController>();
  var quizController = Get.find<QuizController>();
  var noOfQuestion = Get.put(QuizController()).noOfQuestions.value;
  PageController pageController = PageController();
  var currentQuestionIndex = 0.obs;

  Map<int, QuestionModel> questionMap = {};

  saveQuestion(int pageIndex, QuestionModel quizData) {
    questionMap[pageIndex] = quizData;
    update();
  }

  void updateQuestion(int value) {
    currentQuestionIndex.value = value;
  }

  Future<bool> submitQuiz() async {
    try {

      List<Map<String, Object?>> categoryDetails =
          await LocalDatabase.getTableData(
              tableName: Globals.categoryTable,
              condition: "name = '${categoryController.selectedCategory}'");
      var categoryId = categoryDetails[0]['id'];

      int quizId = await LocalDatabase.insertData(
          tableName: Globals.quizTable,
          data: Quiz(
                  name: quizController.quizNameController.text.trim(),
                  category_id: int.tryParse(categoryId.toString()) ?? 1,
                  timeLimit: quizController.quizDurationController.text.trim(),
                  noOfQuestions: int.tryParse(noOfQuestion.text.trim()) ?? 1)
              .toMap());

      for (var data in questionMap.values) {
        data.quizzes_id = quizId;
        await LocalDatabase.insertData(
            tableName: Globals.questionTable, data: data.toMap());
      }
      return true;
    } catch (e) {
      return false;
    }
  }
}
