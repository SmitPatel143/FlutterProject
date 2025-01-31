import 'package:flutter/material.dart';
import 'package:flutter_project/View/login.dart';
import 'package:flutter_project/core/controllers/category_controller.dart';
import 'package:flutter_project/core/views/add_question.dart';
import 'package:flutter_project/core/views/category.dart';
import 'package:flutter_project/core/views/quiz.dart';
import 'package:flutter_project/core/views/shopping_page.dart';
import 'package:flutter_project/core/views/signup.dart';
import 'package:get/get.dart';

import 'core/services/category_service.dart';

Future<void> main() async {

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(body: CategoryAdd()

          // bottomNavigationBar: BottomNavBar(
          //   currentIndex: _selectedIndex,
          //   onTap: _onItemTapped,
          // ),
          ),
    );
  }
}
