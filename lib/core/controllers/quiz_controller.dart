import 'package:flutter/cupertino.dart';
import 'package:flutter_project/core/models/category.dart';
import 'package:flutter_project/core/services/category_service.dart';
import 'package:get/get.dart';

class QuizController extends GetxController {
    final quizNameController = TextEditingController();
    final quizDurationController = TextEditingController();
    final noOfQuestionsController = TextEditingController();



    RxString quizName = "".obs;
    RxInt quizId = 0.obs;
    RxInt quizTimeLimit = 0.obs;
    RxInt noOfQuestions = 0.obs;
}