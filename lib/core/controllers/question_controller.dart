import 'package:flutter_project/core/controllers/quiz_controller.dart';
import 'package:get/get.dart';

class QuestionController extends GetxController {
  var question = "".obs;
  var option1 = "".obs;
  var option2 = "".obs;
  var option3 = "".obs;
  var option4 = "".obs;
  var correctOptionIndex = 1.obs;
  var noOfQuestion = Get.put(QuizController()).noOfQuestions.value;

  var currentQuestionIndex = 0.obs;
  


}
