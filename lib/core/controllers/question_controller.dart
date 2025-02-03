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

  // static Future<void> insertSampleQuizzes() async {
  //
  //   List<Map<String, dynamic>> quizzes = [
  //     {"name": "Algebra Basics", "timeLimit": "30", "noOfQuestions": 10, "category_id": 1},
  //     {"name": "Newton’s Laws", "timeLimit": "45", "noOfQuestions": 15, "category_id": 2},
  //     {"name": "Organic Chemistry", "timeLimit": "40", "noOfQuestions": 12, "category_id": 3},
  //     {"name": "Microeconomics", "timeLimit": "35", "noOfQuestions": 8, "category_id": 4},
  //     {"name": "Grammar Test", "timeLimit": "25", "noOfQuestions": 5, "category_id": 5},
  //   ];
  //
  //   for (var quiz in quizzes) {
  //     await LocalDatabase.insertData(tableName:Globals.quizTable, data: quiz);
  //   }
  //   print("Quizzes inserted successfully!");
  // }

  // static Future<void> insertSampleQuestions() async {
  //
  //   List<Map<String, dynamic>> questions = [
  //     // Mathematics (Quiz ID: 1)
  //     {"question": "What is 2 + 2?", "option1": "3", "option2": "4", "option3": "5", "option4": "6", "correctAnswerIndex": 1, "quizzes_id": 1},
  //     {"question": "Solve for x: 5x = 25", "option1": "3", "option2": "4", "option3": "5", "option4": "6", "correctAnswerIndex": 2, "quizzes_id": 1},
  //     {"question": "What is the square root of 16?", "option1": "2", "option2": "3", "option3": "4", "option4": "5", "correctAnswerIndex": 2, "quizzes_id": 1},
  //
  //     // Physics (Quiz ID: 2)
  //     {"question": "Who discovered gravity?", "option1": "Newton", "option2": "Einstein", "option3": "Galileo", "option4": "Tesla", "correctAnswerIndex": 0, "quizzes_id": 2},
  //     {"question": "What is the SI unit of force?", "option1": "Newton", "option2": "Joule", "option3": "Pascal", "option4": "Watt", "correctAnswerIndex": 0, "quizzes_id": 2},
  //     {"question": "What is the speed of light?", "option1": "3x10^8 m/s", "option2": "2x10^8 m/s", "option3": "1x10^8 m/s", "option4": "5x10^8 m/s", "correctAnswerIndex": 0, "quizzes_id": 2},
  //
  //     // Chemistry (Quiz ID: 3)
  //     {"question": "What is the chemical formula of water?", "option1": "H2O", "option2": "CO2", "option3": "O2", "option4": "H2", "correctAnswerIndex": 0, "quizzes_id": 3},
  //     {"question": "Which gas is most abundant in the Earth’s atmosphere?", "option1": "Oxygen", "option2": "Nitrogen", "option3": "Carbon Dioxide", "option4": "Helium", "correctAnswerIndex": 1, "quizzes_id": 3},
  //     {"question": "What is the pH of a neutral substance?", "option1": "5", "option2": "6", "option3": "7", "option4": "8", "correctAnswerIndex": 2, "quizzes_id": 3},
  //
  //     // Economics (Quiz ID: 4)
  //     {"question": "What is the basic economic problem?", "option1": "Scarcity", "option2": "Inflation", "option3": "Deflation", "option4": "Interest Rate", "correctAnswerIndex": 0, "quizzes_id": 4},
  //     {"question": "What does GDP stand for?", "option1": "Gross Domestic Production", "option2": "Global Development Policy", "option3": "Gross Domestic Product", "option4": "General Debt Payment", "correctAnswerIndex": 2, "quizzes_id": 4},
  //     {"question": "Who is considered the father of economics?", "option1": "Karl Marx", "option2": "Adam Smith", "option3": "John Keynes", "option4": "Milton Friedman", "correctAnswerIndex": 1, "quizzes_id": 4},
  //
  //     // English (Quiz ID: 5)
  //     {"question": "What is the synonym of 'Happy'?", "option1": "Sad", "option2": "Joyful", "option3": "Angry", "option4": "Excited", "correctAnswerIndex": 1, "quizzes_id": 5},
  //     {"question": "What is the plural of 'Child'?", "option1": "Childs", "option2": "Children", "option3": "Childes", "option4": "Childies", "correctAnswerIndex": 1, "quizzes_id": 5},
  //     {"question": "What is the past tense of 'Go'?", "option1": "Goes", "option2": "Went", "option3": "Gone", "option4": "Going", "correctAnswerIndex": 1, "quizzes_id": 5},
  //   ];
  //
  //   for (var question in questions) {
  //     await LocalDatabase.insertData(tableName:Globals.questionTable, data: question);
  //   }
  //
  //   print("Questions inserted successfully!");
  // }


}
