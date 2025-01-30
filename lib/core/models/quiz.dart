class Quiz {
  final int categoryId;
  final String name;
  final DateTime timeLimit;
  final int noOfQuestions;

  Quiz(
      {required this.categoryId,
      required this.name,
      required this.timeLimit,
      required this.noOfQuestions}
      );

}
