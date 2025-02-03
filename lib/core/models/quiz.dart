class Quiz {
  final int category_id;
  final String name;
  final String timeLimit;
  final int noOfQuestions;

  Quiz(
      {required this.category_id,
      required this.name,
      required this.timeLimit,
      required this.noOfQuestions}
      );

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "category_id": category_id,
      "timeLimit": timeLimit,
      "noOfQuestions": noOfQuestions,
    };
  }

}
