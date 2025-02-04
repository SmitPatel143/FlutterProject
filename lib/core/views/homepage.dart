import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:flutter_project/View/login.dart";
import "package:flutter_project/core/views/add_category.dart";
import "package:flutter_project/core/views/searchbar.dart";
import "package:flutter_project/core/views/Quiz/view_quiz.dart";
import "package:flutter_project/core/views/signup.dart";

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomBottomNavigationBar();
  }
}

class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar({super.key});
  @override
  State<CustomBottomNavigationBar> createState() => _CustomBottomNavigation();
}

class _CustomBottomNavigation extends State<CustomBottomNavigationBar> {
  int _selectedIndex = 0;
  static final  List<Widget> _widgetOptions = <Widget>[
    ViewQuiz(),
    CustomSearchBar(),
    CategoryAdd(),
    SignUp(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            "Quiz-App",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
        ),
        elevation: 2,
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: _widgetOptions,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        iconSize: 23,
        unselectedItemColor: Colors.grey,
        selectedItemColor: const Color(0xFF0F85EE),
        selectedFontSize: 12,
        unselectedFontSize: 12,
        elevation: 5,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(
              icon: Icon(Icons.quiz_outlined), label: 'Quiz'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
