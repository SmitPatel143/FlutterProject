import 'package:flutter/cupertino.dart';
import 'package:flutter_project/core/models/category.dart';
import 'package:flutter_project/core/services/category_service.dart';
import 'package:get/get.dart';

class QuizController extends GetxController {

    final TextEditingController quizNameController = TextEditingController();
    final TextEditingController noOfQuestions = TextEditingController();
    final TextEditingController quizDurationController =
    TextEditingController();
}