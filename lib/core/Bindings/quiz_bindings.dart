import 'package:flutter_project/core/controllers/quiz_controller.dart';
import 'package:get/get.dart';

class QuizBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => QuizController());
  }
}
