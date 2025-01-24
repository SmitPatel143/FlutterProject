import "package:flutter/material.dart";

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
            children: [
          Container(
              margin: EdgeInsets.only(left: 10, right: 10, top: 250, bottom: 0),
              height: 300,
              width: 300,
              decoration: BoxDecoration(
                color: Colors.black45,
                borderRadius: BorderRadius.circular(15), // Rounded corners
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 0),
                    child: Text("Hello, Flutter!"),
                  )
                ],
              ))
        ],
      )),
    );
  }
}
