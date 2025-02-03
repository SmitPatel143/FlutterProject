import 'package:flutter/cupertino.dart';
import 'package:flutter_project/constants/tabs.dart';
import 'package:flutter_project/core/Bindings/Home_Binding.dart';
import 'package:flutter_project/core/Bindings/category_bindings.dart';
import 'package:flutter_project/core/Bindings/create_quiz_binding.dart';
import 'package:flutter_project/core/Bindings/question_binding.dart';
import 'package:flutter_project/core/Bindings/quiz_bindings.dart';
import 'package:flutter_project/core/views/add_category.dart';
import 'package:flutter_project/core/views/create_quiz.dart';
import 'package:flutter_project/core/views/homepage.dart';
import 'package:flutter_project/core/views/add_questions.dart';
import 'package:flutter_project/core/views/add_quiz.dart';
import 'package:get/get.dart';

class AppPages {
  AppPages._();

  static const String home = "/home";
  static const String login = "/login";
  static const String quiz = "/quiz";
  static const String category = "/category";
  static const String quizResult = "/quizResult";
  static const String questions = "/questions";
  static const String createQuiz = "/createQuiz";

  static final routes = [
    GetPage(
      name: home,
      page: () => const HomePage(),
      binding: HomeBindings(),
    ),
    GetPage(
        name: category,
        page: () => const CategoryAdd(),
        binding: CategoryBindings()),
    GetPage(
      name: quiz,
      page: () => const Quiz(),
      binding: QuizBindings(),
    ),
    // GetPage(
    //   name: questions,
    //   page: () => const Questions(),
    //   binding: QuestionBinding(),
    // ),
    GetPage(
      name: createQuiz,
      page: () =>  CreateQuiz(),
      binding: CreateQuizBinding(),
    )
  ];

  static final List<Widget> tabPages = [
    const HomeTab(),
    const CategoryTab(),
    const QuizTab(),
  ];
}
