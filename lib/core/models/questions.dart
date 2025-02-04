class QuestionModel {
  int? id;
  final String question;
  final String option1;
  final String option2;
  final String option3;
  final String option4;
  final int correctAnswerIndex;
  int? quizzes_id;

  QuestionModel(
      {required this.question,
      required this.option1,
      required this.option2,
      required this.option3,
      required this.option4,
      required this.correctAnswerIndex,
      this.quizzes_id});

  Map<String, dynamic> toMap() {
    return {
      "question": question,
      "option1": option1,
      "option2": option2,
      "option3": option3,
      "option4": option4,
      "correctAnswerIndex": correctAnswerIndex,
      "quizzes_id": quizzes_id
    };
  }

  factory QuestionModel.fromMap(Map<String, dynamic> map) {
    return QuestionModel(
        question: map["question"],
        option1: map["option1"],
        option2: map["option2"],
        option3: map["option3"],
        option4: map["option4"],
        correctAnswerIndex: map["correctAnswerIndex"],
        quizzes_id: map["quizzes_id"]);
  }

  List<String> getOptions() {
    return [option1, option2, option3, option4];
  }
}
