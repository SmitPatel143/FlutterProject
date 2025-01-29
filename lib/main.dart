import 'package:flutter/material.dart';
import 'package:flutter_project/View/login.dart';
import 'package:flutter_project/core/views/add_question.dart';
import 'package:flutter_project/core/views/shopping_page.dart';
import 'package:flutter_project/core/views/signup.dart';

void main() {
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(body: AddQuestions()

          // bottomNavigationBar: BottomNavBar(
          //   currentIndex: _selectedIndex,
          //   onTap: _onItemTapped,
          // ),
          ),
    );
  }
}
