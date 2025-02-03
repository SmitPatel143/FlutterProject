import 'package:flutter/material.dart';
import 'package:flutter_project/core/controllers/question_controller.dart';
import 'package:flutter_project/core/controllers/quiz_controller.dart';
import 'package:flutter_project/core/views/add_questions.dart';
import 'package:get/get.dart';

class CreateQuiz extends StatelessWidget {
  const CreateQuiz({super.key});

  @override
  Widget build(BuildContext context) {

    final quizController = Get.find<QuizController>();
    final questionController = Get.find<QuestionController>();
    final noOfQue = int.parse(quizController.noOfQuestions.text);

    return GetBuilder(
      init: QuestionController(),
      builder: (controller) {
      return PageView.builder(

        controller: questionController.pageController,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: noOfQue,
        onPageChanged: (value) {
          questionController.updateQuestion(value);
        },
        itemBuilder: (context, index) {
          return Questions(
            // pageController: pageController,
            index: index,
          );
        },);
    },);
  }
}
