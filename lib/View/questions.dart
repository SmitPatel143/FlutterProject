
import "package:flutter/material.dart";

class Question {
  final String text;
  String? userAnswer;
  String actualAnswer;

  Question({
    required this.text,
    required this.userAnswer,
    required String actualAnswer,
  }) : actualAnswer = actualAnswer.toLowerCase();
}

class QuestionsPage extends StatefulWidget {
  const QuestionsPage({super.key});

  @override
  State createState() => _QuestionsPageState();
}

class _QuestionsPageState extends State<QuestionsPage> {
  List<Question> questions = [
    Question(
        text: "What is the capital of France?",
        userAnswer: null,
        actualAnswer: "paris"),
    Question(
        text: "What is the largest planet in our solar system?",
        userAnswer: null,
        actualAnswer: "jupiter"),
    Question(
        text: "What is the largest country in the world by land area?",
        userAnswer: null,
        actualAnswer: "russia"),
    Question(
        text: "What is the chemical symbol for gold?",
        userAnswer: null,
        actualAnswer: "Au"),
  ];

  int currentQuestionIndex = 0;

  final TextEditingController _answerController = TextEditingController();

  void _showResultSnackBar(BuildContext context, bool isCorrect) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(isCorrect ? 'Correct!' : 'Incorrect!'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _saveAnswer() {
    if (_answerController.text.trim().isEmpty) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Please enter an answer'),
              actions: [
                TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text('Ok'))
              ],
            );
          });
    } else {
      questions[currentQuestionIndex].userAnswer = _answerController.text.trim();
      questions[currentQuestionIndex].userAnswer ==
              questions[currentQuestionIndex].actualAnswer.toLowerCase()
          ? _showResultSnackBar(context, true)
          : _showResultSnackBar(context, false);

      if (currentQuestionIndex == questions.length - 1) {
        _showResults();
        return;
      }
      setState(() {
        currentQuestionIndex++;
        _answerController.clear();
      });
    }
  }

  void _showResults() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Your Answers'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: questions
                  .map((question) => Text(
                      'Q: ${question.text}\nA: ${question.userAnswer ?? "No answer"}'))
                  .toList(),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
          title: Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Text('General Quiz',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      fontSize: 24))),
        ),
        body: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Text(
                    questions[currentQuestionIndex].text,
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                ),
                TextField(
                  controller: _answerController,
                  decoration: InputDecoration(
                    hintText: 'Type your answer here',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 30),
                ElevatedButton(
                    onPressed: _saveAnswer,
                    child: Text(currentQuestionIndex < questions.length - 1
                        ? "Next Question"
                        : "Submit")),
                Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    child: Text(
                      'Question ${currentQuestionIndex + 1} of ${questions.length}, ${questions[currentQuestionIndex].userAnswer ?? ''}',
                    )),
              ],
            )));
  }
}
