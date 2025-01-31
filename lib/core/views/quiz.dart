import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:flutter_project/core/controllers/category_controller.dart";
import "package:flutter_project/core/controllers/quiz_controller.dart";
import "package:flutter_project/core/views/questions.dart";
import "package:get/get.dart";
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Quiz extends StatelessWidget {
  final CategoryController categoryController = Get.put(CategoryController());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final QuizController quizController = Get.put(QuizController());

  final _quizNameController = TextEditingController();
  final _noOfQuestions = TextEditingController();
  final _quizDurationController = TextEditingController();

  Quiz({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: categoryController.isLoading,
      builder: (context, value, child) {
        return Scaffold(
          body: value
              ? Center(
                  child: LoadingAnimationWidget.staggeredDotsWave(
                    color: Colors.black,
                    size: 50,
                  ),
                )
              : Center(
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
                            autovalidateMode:
                                AutovalidateMode.disabled,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
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
                                      initialValue: categoryController
                                          .selectedCategory.value,
                                      readOnly: true,
                                      style:
                                          const TextStyle(color: Colors.black),
                                      decoration: _buildInputDecoration(
                                        labelText: "Category",
                                        icon: Icons.category,
                                      ),
                                      onTap: () => Fluttertoast.showToast(
                                          msg: "Category field is read only",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.TOP_RIGHT,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.red,
                                          textColor: Colors.white,
                                          fontSize: 14.0),
                                    )),
                                const SizedBox(height: 30),

                                TextFormField(
                                      controller: _quizNameController,
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      style:
                                          const TextStyle(color: Colors.black),
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
                                  controller: _quizDurationController,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  keyboardType: TextInputType.number,
                                  style: const TextStyle(color: Colors.black),
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
                                  decoration: _buildInputDecoration(
                                    labelText: "Time-Limit",
                                    icon: Icons.timeline,
                                    hintText: "Quiz duration in minutes",
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Please enter time limit";
                                    }
                                    int? minutes = int.tryParse(value);
                                    if (minutes == null || minutes <= 0) {
                                      return 'Please enter valid minutes';
                                    }
                                    if (minutes > 180) {
                                      return 'Time limit cannot exceed 180 minutes';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 30),
                                TextFormField(
                                  controller: _noOfQuestions,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  keyboardType: TextInputType.number,
                                  style: const TextStyle(color: Colors.black),
                                  decoration: _buildInputDecoration(
                                    labelText: "No Of Questions",
                                    icon: Icons.question_answer,
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Please enter number of questions";
                                    }
                                    int? questions = int.tryParse(value);
                                    if (questions == null || questions <= 0) {
                                      return 'Please enter valid number of questions';
                                    }
                                    if (questions > 100) {
                                      return 'Number of questions cannot exceed 100';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 30),
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
                                            borderRadius:
                                                BorderRadius.circular(30),
                                          ),
                                        ),
                                        child: const Text("Back"),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 30,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            quizController.quizName.value =
                                                _quizNameController.text;
                                            quizController.quizTimeLimit.value =
                                                int.parse(
                                                    _quizDurationController
                                                        .text);
                                            quizController.noOfQuestions.value =
                                                int.parse(_noOfQuestions.text);
                                              Get.to(() => Questions());
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
                                            borderRadius:
                                                BorderRadius.circular(30),
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
      },
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
