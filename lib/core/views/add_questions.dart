import "package:flutter/material.dart";
import "package:flutter_project/constants/app_pages.dart";
import "package:flutter_project/core/controllers/question_controller.dart";
import "package:get/get.dart";
import "package:flutter_project/core/models/questions.dart";

class Questions extends StatefulWidget {
  final int index;

  const Questions({super.key, required this.index});

  @override
  State<Questions> createState() => _QuestionsState();
}

class _QuestionsState extends State<Questions> {
  final formKey = GlobalKey<FormState>();
  var question = TextEditingController();
  var option1 = TextEditingController();
  var option2 = TextEditingController();
  var option3 = TextEditingController();
  var option4 = TextEditingController();
  var correctOptionIndex = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final questionController = Get.find<QuestionController>();

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Card(
              color: Colors.white,
              surfaceTintColor: Colors.white10,
              elevation: 0,
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: 350,
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 30,
                  horizontal: 20,
                ),
                child: Form(
                  key: formKey,
                  autovalidateMode: AutovalidateMode.disabled,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Obx(
                        () => Text(
                          "Question - ${questionController.currentQuestionIndex.value + 1} ",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.5,
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      TextFormField(
                        controller: question,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        style: const TextStyle(color: Colors.black),
                        decoration: _buildInputDecoration(
                          labelText: "Question",
                          icon: Icons.quiz,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter a question";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 30),
                      TextFormField(
                        controller: option1,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        style: const TextStyle(color: Colors.black),
                        decoration: _buildInputDecoration(
                          labelText: "Option-1",
                          icon: Icons.question_answer,
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "Please enter option-1";
                          }
                          if (value.trim().length > 200) {
                            return "Option-1 cannot exceed 200 characters";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: option2,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        style: const TextStyle(color: Colors.black),
                        decoration: _buildInputDecoration(
                          labelText: "Option-2",
                          icon: Icons.question_answer,
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "Please enter option-2";
                          }
                          if (value.trim().length > 200) {
                            return "Option-2 cannot exceed 200 characters";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: option3,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        style: const TextStyle(color: Colors.black),
                        decoration: _buildInputDecoration(
                          labelText: "Option-3",
                          icon: Icons.question_answer,
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "Please enter option-3";
                          }
                          if (value.trim().length > 200) {
                            return "Option-3 cannot exceed 200 characters";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: option4,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        style: const TextStyle(color: Colors.black),
                        decoration: _buildInputDecoration(
                          labelText: "Option-4",
                          icon: Icons.question_answer,
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "Please enter option-4";
                          }
                          if (value.trim().length > 200) {
                            return "Option-4 cannot exceed 200 characters";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: correctOptionIndex,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        style: const TextStyle(color: Colors.black),
                        decoration: _buildInputDecoration(
                          labelText: "Correct-Option-Index",
                          icon: Icons.question_answer,
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "Index is required";
                          }
                          int? index = int.tryParse(value.trim());
                          if (index == null || index < 1 || index > 4) {
                            return "Index must be between 1 and 4";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 30,
                            child: ElevatedButton(
                              onPressed: () {
                                questionController.pageController
                                    .jumpToPage(widget.index - 1);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                foregroundColor: Colors.blue,
                                shadowColor: Colors.transparent,
                                textStyle: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 1,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              child: const Text("Back"),
                            ),
                          ),
                          SizedBox(
                            height: 30,

                            child: ElevatedButton(
                              onPressed: () async {
                                if (formKey.currentState!.validate()) {
                                  final quizData = QuestionModel(
                                      option3: option3.text.trim(),
                                      option2: option2.text.trim(),
                                      option1: option1.text.trim(),
                                      option4: option4.text.trim(),
                                      correctAnswerIndex: int.tryParse(
                                          correctOptionIndex.text) ??
                                          1,
                                      question: question.text.trim());
                                  questionController.saveQuestion(
                                      widget.index, quizData);

                                  if(widget.index == int.tryParse(questionController.noOfQuestion.text)! - 1) {
                                     var response = await questionController.submitQuiz();
                                    SnackBar(
                                       content: Text("Quiz added successfully"),
                                       backgroundColor: Colors.green,
                                     );
                                    Get.offAllNamed(AppPages.home);
                                  }else{
                                    questionController.pageController
                                        .jumpToPage(widget.index + 1);
                                  }
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                foregroundColor: Colors.blue,
                                shadowColor: Colors.transparent,
                                textStyle: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 1,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              child: Text(
                                widget.index == int.tryParse(questionController.noOfQuestion.text)! - 1
                                    ? "Submit"
                                    : "Next",
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

InputDecoration _buildInputDecoration(
    {required String labelText,
    required IconData icon,
    String? errorText,
    String? hintText}) {
  return InputDecoration(
    labelText: labelText,
    prefixIcon: Icon(icon),
    hintText: hintText,
    errorText: errorText,
    labelStyle: TextStyle(color: Colors.black),
    errorStyle: TextStyle(color: Colors.red),
    enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black),
        borderRadius: BorderRadius.circular(10)),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.black, width: 2),
      borderRadius: BorderRadius.circular(10),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.red),
      borderRadius: BorderRadius.circular(10),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.red, width: 2),
      borderRadius: BorderRadius.circular(10),
    ),
  );
}
