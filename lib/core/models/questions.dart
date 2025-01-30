class Questions {
  int? id;
  final String question;
  final String option1;
  final String option2;
  final String option3;
  final String option4;
  final int correctAnswerIndex;


  Questions(
      {required this.question,
      required this.option1,
      required this.option2,
      required this.option3,
      required this.option4,
      required this.correctAnswerIndex});

  Map<String, dynamic> toMap() {
    return {
      "question": question,
      "option1": option1,
      "option2": option2,
      "option3": option3,
      "option4": option4,
      "correctAnswerIndex": correctAnswerIndex,
    };
  }
}
