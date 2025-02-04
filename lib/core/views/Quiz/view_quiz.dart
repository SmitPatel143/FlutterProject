import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/core/controllers/viewQuiz_controller.dart';
import 'package:flutter_project/core/models/quiz_response.dart';
import 'package:flutter_project/core/views/Quiz/start_quiz.dart';
import 'package:flutter_project/core/views/Quiz/start_quiz_builder.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ViewQuiz extends StatelessWidget {
  const ViewQuiz({super.key});

  @override
  Widget build(BuildContext context) {
    final viewQuizController = Get.put(ViewQuizController());

    return FutureBuilder(
        future: viewQuizController.getAvailableQuizzes(),
        builder: (context, AsyncSnapshot<List<QuizResponse>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: LoadingAnimationWidget.staggeredDotsWave(
                color: Colors.black,
                size: 50,
              ),
            );
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No quizzes available.'));
          }

          List<QuizResponse> quizzes = snapshot.data!;
          return ListView.builder(
            itemCount: quizzes.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                    elevation: 3,
                    child: Column(
                      children: [
                        ListTile(
                          title: Text(
                            quizzes[index].name,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          subtitle: Text(
                              "Total Questions: ${quizzes[index].noOfQuestions}"),
                          trailing: Text(
                            "Time: ${quizzes[index].timeLimit} mins",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.red),
                          ),
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(15,5, 0, 1),
                              child: ElevatedButton(
                                onPressed: () {
                                  Get.to(() => StartQuizBuilder(questions: quizzes[index].questions));
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.green,
                                    foregroundColor: Colors.white),
                                child: const Text('Start Quiz'),
                              ),
                            ),
                          ],
                        ),

                      ],
                    )),
              );
            },
          );
        });
  }
}
