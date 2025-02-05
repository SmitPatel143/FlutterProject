import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(padding: EdgeInsets.fromLTRB(50, 10, 15, 0),
          ),
          SearchBar(
            leading: Icon(Icons.search),
            hintText: "Search Quiz",
            hintStyle: MaterialStateProperty.resolveWith(
                (states) => TextStyle(color: Colors.black)),
          )
        ],
      ),
    );
  }
}
