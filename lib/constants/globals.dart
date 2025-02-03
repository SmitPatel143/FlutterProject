import 'package:flutter_project/database/localdatabase.dart';

class Globals {
  //localdatabase details:
  static const String localDatabaseName = "my_database.db";
  static const int localDatabaseVersion = 2;
  static LocalDatabase? localDatabase;

  Future<LocalDatabase> get _localDatabase async{
    return localDatabase ??= await LocalDatabase.getInstance();
  }


  //Table names:
  static const String userTable = "users";
  static const String categoryTable = "categories";
  static const String questionTable = "questions";
  static const String quizTable = "quizzes";
}
