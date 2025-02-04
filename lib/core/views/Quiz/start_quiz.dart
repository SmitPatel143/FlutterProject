import 'package:flutter/material.dart';
import 'package:flutter_project/constants/app_pages.dart';
import 'package:flutter_project/core/controllers/quiz_submission_controller.dart';
import 'package:get/get.dart';

class StartQuiz extends StatefulWidget {
  final int index;
  final String question;
  final List<String> options;
  final int correctAnswer;

  const StartQuiz({
    super.key,
    required this.index,
    required this.question,
    required this.options,
    required this.correctAnswer,
  });

  @override
  State createState() => _StartQuizState();
}

class _StartQuizState extends State<StartQuiz> {
  int? selectedAnswer;
  var quizSubmissionController = Get.put(QuizSubmission());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          child: Card(
            elevation: 5,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Container(
              padding: const EdgeInsets.all(20),
              width: 350,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Question ${widget.index + 1}",
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    widget.question,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 20),
                  for (int i = 0; i < widget.options.length; i++)
                    RadioListTile<int>(
                      title: Text(widget.options[i]),
                      value: i,
                      groupValue: selectedAnswer,
                      onChanged: (int? value) {
                        setState(() {
                          selectedAnswer = value;
                        });
                      },
                    ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (widget.index >
                          0) // Hide back button on first question
                        ElevatedButton(
                          onPressed: () {
                            quizSubmissionController.pageController
                                .jumpToPage(widget.index - 1);
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue),
                          child: const Text("Back"),
                        ),
                      if(quizSubmissionController.questions!.length - 1 == widget.index)
                        ElevatedButton(
                          onPressed: () {
                            if (selectedAnswer == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Please select an option"),
                                ),
                              );
                              return;
                            }
                            quizSubmissionController.submitAnswer(widget.index,
                                selectedAnswer!);
                            var result = quizSubmissionController.submitQuiz();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("You scored $result out of ${quizSubmissionController.questions!.length}"),
                                duration: const Duration(seconds: 3),
                              ),
                            );
                            Future.delayed(const Duration(seconds: 3), () {
                              Get.offAllNamed(AppPages.home);
                            });

                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green),
                          child: const Text("Submit"),
                        ),
                      ElevatedButton(
                        onPressed: () {
                          if (selectedAnswer == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text("Please select an option")));
                            return;
                          } else {
                            quizSubmissionController.submitAnswer(widget.index,
                                selectedAnswer!);
                            quizSubmissionController.pageController
                                .jumpToPage(widget.index + 1);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green),
                        child: const Text("Next"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
