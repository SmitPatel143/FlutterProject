import "package:flutter/material.dart";
import "package:flutter_project/core/controllers/category_controller.dart";
import "package:flutter_project/core/controllers/quiz_controller.dart";
import "package:get/get.dart";

import "../../constants/app_pages.dart";

class Quiz extends StatelessWidget {
  const Quiz({super.key});

  @override
  Widget build(BuildContext context) {

    final CategoryController categoryController =
        Get.find<CategoryController>();
    var arguments = categoryController.selectedCategory.value;
    final QuizController quizController = Get.find<QuizController>();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();


    // final TextEditingController categoryControllerText = TextEditingController();

    // categoryControllerText.text = categoryController.selectedCategory.value;

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Card(
              color: Colors.white,
              elevation: 2,
              child: Container(
                constraints: const BoxConstraints(maxWidth: 350),
                padding: const EdgeInsets.symmetric(
                  vertical: 30,
                  horizontal: 20,
                ),
                child: Form(
                  autovalidateMode: AutovalidateMode.disabled,
                  key: formKey,
                  child: Column(
                    children: [
                      const Text(
                        "Step-2: Quiz",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5,
                        ),
                      ),
                      const SizedBox(height: 30),
                      TextFormField(
                        initialValue: arguments,
                        readOnly: true,
                        style: const TextStyle(color: Colors.black),
                        decoration: _buildInputDecoration(
                          labelText: "Category",
                          icon: Icons.category,
                        ),
                      ),
                      const SizedBox(height: 30),
                      TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: quizController.quizNameController,
                        style: const TextStyle(color: Colors.black),
                        decoration: _buildInputDecoration(
                          labelText: "Quiz-name",
                          icon: Icons.quiz,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter quiz name";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 30),
                      TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: quizController.quizDurationController,
                        keyboardType: TextInputType.number,
                        style: const TextStyle(color: Colors.black),
                        decoration: _buildInputDecoration(
                          labelText: "Time-Limit",
                          icon: Icons.timeline,
                          hintText: "Quiz duration in minutes",
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter quiz duration";
                          }
                          var minutes = int.tryParse(value);
                          if (minutes! < 0 || minutes > 180) {
                            return "Quiz duration must be between 0 and 180 minutes";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 30),
                      TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: quizController.noOfQuestions,
                        keyboardType: TextInputType.number,
                        style: const TextStyle(color: Colors.black),
                        decoration: _buildInputDecoration(
                          labelText: "No Of Questions",
                          icon: Icons.question_answer,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter no of questions";
                          }
                          var noOfQuestions = int.tryParse(value);
                          if (noOfQuestions! < 0 || noOfQuestions > 100) {
                            return "No of questions must be between 0 and 100";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            child: ElevatedButton(
                              onPressed: () {
                                var navigation = Get.back();
                              },

                              child: const Text("Back"),
                            ),
                          ),
                          SizedBox(width: 20,),
                          ElevatedButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                print("Inside the form validation");
                                // quizController.quizName.value =
                                //     quizController.quizNameController.text;
//                                 var quizTimeLimit =
//                                     int.parse(quizController.quizDurationController.text);
//                                var noOfQuestions =
//                                     int.parse(quizController.noOfQuestions.text);
// //arguments: {"noOfQuestions": noOfQuestions, "quizTimeLimit" : quizTimeLimit}
                                var navigation = Get.toNamed(
                                  AppPages.createQuiz,
                                );
                              }
                            },
                            child: const Text("Next"),
                          ),
                        ],
                      )
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
