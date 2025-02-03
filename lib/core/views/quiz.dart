import "package:flutter/material.dart";
import "package:flutter_project/core/controllers/category_controller.dart";
import "package:flutter_project/core/controllers/quiz_controller.dart";
import "package:get/get.dart";

class Quiz extends StatelessWidget {
  const Quiz({super.key});

  @override
  Widget build(BuildContext context) {
    final CategoryController categoryController =
        Get.find<CategoryController>();
    final QuizController quizController = Get.find<QuizController>();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final TextEditingController quizNameController = TextEditingController();
    final TextEditingController noOfQuestions = TextEditingController();
    final TextEditingController quizDurationController =
        TextEditingController();
    final TextEditingController categoryControllerText =
        TextEditingController();

    categoryControllerText.text = categoryController.selectedCategory.value;

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
                      Obx(() => TextFormField(
                            initialValue:
                                categoryController.selectedCategory.value,
                            readOnly: true,
                            style: const TextStyle(color: Colors.black),
                            decoration: _buildInputDecoration(
                              labelText: "Category",
                              icon: Icons.category,
                            ),
                          )),
                      const SizedBox(height: 30),
                      TextFormField(
                        controller: quizNameController,
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
                        controller: quizDurationController,
                        keyboardType: TextInputType.number,
                        style: const TextStyle(color: Colors.black),
                        decoration: _buildInputDecoration(
                          labelText: "Time-Limit",
                          icon: Icons.timeline,
                          hintText: "Quiz duration in minutes",
                        ),
                      ),
                      const SizedBox(height: 30),
                      TextFormField(
                        controller: noOfQuestions,
                        keyboardType: TextInputType.number,
                        style: const TextStyle(color: Colors.black),
                        decoration: _buildInputDecoration(
                          labelText: "No Of Questions",
                          icon: Icons.question_answer,
                        ),
                      ),
                      const SizedBox(height: 30),
                      ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            quizController.quizName.value =
                                quizNameController.text;
                            quizController.quizTimeLimit.value =
                                int.parse(quizDurationController.text);
                            quizController.noOfQuestions.value =
                                int.parse(noOfQuestions.text);

                            Get.toNamed("/questions", arguments: {
                              "quizName": quizController.quizName.value,
                              "timeLimit": quizController.quizTimeLimit.value,
                              "noOfQuestions":
                                  quizController.noOfQuestions.value,
                            });
                          }
                        },
                        child: const Text("Next"),
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
