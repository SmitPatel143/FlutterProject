import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ViewQuiz extends StatelessWidget {
  const ViewQuiz({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return const Padding(
            padding: EdgeInsets.all(8.0),
            child: Card(
              elevation: 3,
              child: ListTile(
                leading: Icon(Icons.quiz),
                title: Text('Question 1'),
                subtitle: Text('Answer 1'),
              ),
            ),
          );
        },
      ),
    );
  }
}
