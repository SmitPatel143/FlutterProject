import 'package:flutter_project/core/models/category.dart';
import 'package:flutter_project/core/services/category_service.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController {
  final _availableCategory = <String>[].obs;

  List<String> get availableCategory => _availableCategory;

  Future<void> loadCategories() async {
    try {
      final categoryService = await CategoryService.getInstance();
      final categories = await categoryService.getAllCategories();
      _availableCategory.value =
          categories.map((category) => category.name).toList();
    } catch (e) {
      print('Error loading categories: $e');
    }
  }

  @override
  void onInit() {
    super.onInit();
    loadCategories();
  }

  void getData() {
    loadCategories();
  }
}
