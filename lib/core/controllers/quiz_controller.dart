import 'package:flutter/cupertino.dart';
import 'package:flutter_project/core/models/category.dart';
import 'package:flutter_project/core/services/category_service.dart';
import 'package:get/get.dart';

class QuizController extends GetxController {

    RxString quizName = "".obs;
    RxInt quizId = 0.obs;
    RxInt quizTimeLimit = 0.obs;
    RxInt noOfQuestions = 0.obs;
}