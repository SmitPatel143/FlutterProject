import 'package:flutter/cupertino.dart';
import 'package:flutter_project/core/models/category.dart';
import 'package:flutter_project/core/services/category_service.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController {
  final _availableCategory = <String>[].obs;
  RxString selectedCategory = ''.obs;
  final categoryService = CategoryService();
  ValueNotifier<bool> isLoading = ValueNotifier(true);

  RxList<String> get availableCategory => _availableCategory;

  @override
  void onInit() {
    super.onInit();
    loadCategories().then((categories) {
      _availableCategory.value = categories;
      isLoading.value = false;
    });
  }

  void setSelectedCategory(String? category) {
    if (category != null) {
      selectedCategory.value = category;
    }
  }

  Future<List<String>> loadCategories() async {
    try {
      final categories = await categoryService.getAllCategories();
      return categories.map((category) => category.name).toList();
    } catch (e) {
      throw Exception('Failed to load categories');
    }
  }
}
