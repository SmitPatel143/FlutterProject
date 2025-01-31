import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:flutter_project/core/controllers/category_controller.dart";
import "package:flutter_project/core/controllers/question_controller.dart";
import "package:flutter_project/core/controllers/quiz_controller.dart";
import "package:get/get.dart";
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Questions extends StatelessWidget {
  Questions({super.key});

  final _formKey = GlobalKey<FormState>();
  final _questionController = TextEditingController();
  final _option1Controller = TextEditingController();
  final _option2Controller = TextEditingController();
  final _option3Controller = TextEditingController();
  final _option4Controller = TextEditingController();
  final _correctOptionIndexController = TextEditingController();
  final questionController = Get.put(QuestionController());

  @override
  Widget build(BuildContext context) {
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
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.disabled,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Obx(() =>
                       Text(
                        "Question - ${questionController.correctOptionIndex.value}",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5,
                        ),
                      )),
                      const SizedBox(height: 30),
                      TextFormField(
                        controller: _questionController,
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
                        controller: _option1Controller,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        style: const TextStyle(color: Colors.black),
                        decoration: _buildInputDecoration(
                          labelText: "Option-1",
                          icon: Icons.question_answer,
                        ),
                        validator: (value) {
                          if (value == null || value
                              .trim()
                              .isEmpty) {
                            return "Please enter option-1";
                          }
                          if (value
                              .trim()
                              .length > 200) {
                            return "Option-1 cannot exceed 200 characters";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: _option2Controller,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        style: const TextStyle(color: Colors.black),
                        decoration: _buildInputDecoration(
                          labelText: "Option-2",
                          icon: Icons.question_answer,
                        ),
                        validator: (value) {
                          if (value == null || value
                              .trim()
                              .isEmpty) {
                            return "Please enter option-2";
                          }
                          if (value
                              .trim()
                              .length > 200) {
                            return "Option-2 cannot exceed 200 characters";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: _option3Controller,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        style: const TextStyle(color: Colors.black),
                        decoration: _buildInputDecoration(
                          labelText: "Option-3",
                          icon: Icons.question_answer,
                        ),
                        validator: (value) {
                          if (value == null || value
                              .trim()
                              .isEmpty) {
                            return "Please enter option-3";
                          }
                          if (value
                              .trim()
                              .length > 200) {
                            return "Option-3 cannot exceed 200 characters";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: _option4Controller,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        style: const TextStyle(color: Colors.black),
                        decoration: _buildInputDecoration(
                          labelText: "Option-4",
                          icon: Icons.question_answer,
                        ),
                        validator: (value) {
                          if (value == null || value
                              .trim()
                              .isEmpty) {
                            return "Please enter option-4";
                          }
                          if (value
                              .trim()
                              .length > 200) {
                            return "Option-4 cannot exceed 200 characters";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: _correctOptionIndexController,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        style: const TextStyle(color: Colors.black),
                        decoration: _buildInputDecoration(
                          labelText: "Correct-Option-Index",
                          icon: Icons.question_answer,
                        ),
                        validator: (value) {
                          if (value == null || value
                              .trim()
                              .isEmpty) {
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
                                Get.back();
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
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  // quizController.quizName.value =
                                  //     _quizNameController.text;
                                  // quizController.quizTimeLimit.value =
                                  //     int.parse(_quizDurationController.text);
                                  // quizController.noOfQuestions.value =
                                  //     int.parse(_noOfQuestions.text);
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
                              child: const Text("Next"),
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

InputDecoration _buildInputDecoration({required String labelText,
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
