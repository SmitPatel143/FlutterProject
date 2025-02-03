import 'package:flutter/cupertino.dart';
import 'package:flutter_project/constants/tabs.dart';
import 'package:flutter_project/core/Bindings/Home_Binding.dart';
import 'package:flutter_project/core/Bindings/category_bindings.dart';
import 'package:flutter_project/core/Bindings/quiz_bindings.dart';
import 'package:flutter_project/core/views/category.dart';
import 'package:flutter_project/core/views/homepage.dart';
import 'package:flutter_project/core/views/quiz.dart';
import 'package:get/get.dart';

class AppPages {
  AppPages._();

  static const String home = "/home";
  static const String login = "/login";
  static const String quiz = "/quiz";
  static const String category = "/category";
  static const String quizResult = "/quizResult";

  static final routes = [
    GetPage(
      name: home,
      page: () => const HomePage(),
      binding: HomeBindings(),
    ),
    GetPage(
      name: category,
      page: () => const CategoryAdd(),
      binding: CategoryBindings()
    ),
    GetPage(
      name: quiz,
      page: () => const Quiz(),
      binding: QuizBindings(),
    ),
  ];

  static final List<Widget> tabPages = [
    const HomeTab(),
    const CategoryTab(),
    const QuizTab(),
  ];
}
