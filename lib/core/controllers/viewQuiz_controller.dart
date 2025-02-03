import 'package:flutter_project/database/localdatabase.dart';
import 'package:get/get.dart';
import 'package:sqflite_common/sqlite_api.dart';

class ViewQuizController extends GetxController {
  Future<LocalDatabase> localDatabase = LocalDatabase.getInstance();

  static Future<void> getAvailableQuizzes() async {
    String sql =

        "SELECT * FROM questions q JOIN quizzes quiz ON q.quizzes_id = quiz.id JOIN categories c ON quiz.category_id = c.id";
    List<Map<String,Object?>> response = await LocalDatabase.getTableDataByQuery(sql);
    print(response);
    print(response[0]);
    print(response.length);
  }
}

