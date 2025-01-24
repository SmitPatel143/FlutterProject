import 'package:flutter/material.dart';
import 'package:flutter_project/View/login.dart';

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
      home: Scaffold(
        // appBar: AppBar(
        //   title: Text('My App Bar'),
        //   centerTitle: true,
        //   backgroundColor: Colors.deepPurpleAccent,
        //   leading: Icon(Icons.menu),
        //   actions: [IconButton(onPressed: () {}, icon: Icon(Icons.logout))],
        // ),
        body: Column(
          children: [
            Login()
          ]
          // child: QuestionsPage(),
        )

        // bottomNavigationBar: BottomNavBar(
        //   currentIndex: _selectedIndex,
        //   onTap: _onItemTapped,
        // ),
      ),
    );
  }
}
