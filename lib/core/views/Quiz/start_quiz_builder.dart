import 'package:flutter/cupertino.dart';
import 'package:flutter_project/core/controllers/quiz_submission_controller.dart';
import 'package:flutter_project/core/models/questions.dart';
import 'package:flutter_project/core/views/Quiz/start_quiz.dart';
import 'package:get/get.dart';

class StartQuizBuilder extends StatelessWidget {

  final List<QuestionModel> questions;

  const StartQuizBuilder({super.key, required this.questions});

  @override
  Widget build(BuildContext context) {
    final quizSubmissionController = QuizSubmission();
    quizSubmissionController.questions = questions;

    return GetBuilder(
        init: quizSubmissionController,
        builder: (controller) {
          return PageView.builder(
            controller: controller.pageController,
            itemCount: controller.questions!.length,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return StartQuiz(
                index: index,
                question: controller.questions![index].question,
                options: controller.questions![index].getOptions(),
                correctAnswer:  controller.questions![index].correctAnswerIndex,
              );
            },
          );
        });


  }
}
