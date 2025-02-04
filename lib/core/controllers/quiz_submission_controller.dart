import 'package:flutter/cupertino.dart';
import 'package:flutter_project/core/models/questions.dart';
import 'package:get/get.dart';

class QuizSubmission extends GetxController {

  List<QuestionModel> questions = [];
  PageController pageController = PageController();
  Map<int, int> selectedAnswers = {};


  void submitAnswer(int index, int selectedOption) {
    selectedAnswers[index] = (selectedOption);
    print(selectedAnswers);
    print(questions[index].correctAnswerIndex);
    // update();
  }

  int submitQuiz() {
    int correctCount = 0;
    for (int i = 0; i < questions.length; i++) {
      if (selectedAnswers[i] == questions[i].correctAnswerIndex) {
        correctCount++;
      }
    }
    return correctCount;
  }

}