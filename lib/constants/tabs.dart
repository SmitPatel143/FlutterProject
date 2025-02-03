
import 'package:flutter/cupertino.dart';
import 'package:flutter_project/core/controllers/category_controller.dart';
import 'package:flutter_project/core/views/add_category.dart';
import 'package:flutter_project/core/views/add_quiz.dart';
import 'package:get/get.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Home Content'),
    );
  }
}

class CategoryTab extends GetView<CategoryController> {
  const CategoryTab({super.key});

  @override
  Widget build(BuildContext context) {
    return CategoryAdd();
  }
}

class QuizTab extends GetView<CategoryController> {
  const QuizTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Quiz();
  }
}