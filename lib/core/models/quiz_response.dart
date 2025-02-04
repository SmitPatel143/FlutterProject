import 'package:flutter_project/core/models/questions.dart';

class QuizResponse {
  final int id;
  final String name;
  final int timeLimit;
  final int noOfQuestions;
  final int categoryId;
  final String categoryName;
  final List<QuestionModel> questions;

  QuizResponse({
    required this.id,
    required this.name,
    required this.timeLimit,
    required this.noOfQuestions,
    required this.categoryId,
    required this.categoryName,
    required this.questions,
  });

  // Convert Quiz object to a Map to store in the database
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'timeLimit': timeLimit,
      'noOfQuestions': noOfQuestions,
      'category_id': categoryId,
      'category_name': categoryName,
    };
  }

  // Convert Map to a Quiz object
  factory QuizResponse.fromMap(Map<String, dynamic> map, List<QuestionModel> questions) {
    return QuizResponse(
      id: map['id'],
      name: map['name'],
      timeLimit: map['timeLimit'],
      noOfQuestions: map['noOfQuestions'],
      categoryId: map['category_id'],
      categoryName: map['category_name'],
      questions: questions,
    );
  }
}
