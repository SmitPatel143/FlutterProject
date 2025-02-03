import 'package:flutter_project/core/controllers/category_controller.dart';
import 'package:get/get.dart';

class CategoryBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CategoryController());
  }
}