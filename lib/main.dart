import 'package:flutter/material.dart';
import 'package:flutter_project/constants/app_pages.dart';
import 'package:flutter_project/core/Bindings/Home_Binding.dart';
import 'package:flutter_project/core/controllers/BottomNavigationController.dart';
import 'package:flutter_project/core/controllers/category_controller.dart';
import 'package:flutter_project/core/controllers/question_controller.dart';
import 'package:flutter_project/core/controllers/quiz_controller.dart';
import 'package:flutter_project/core/views/homepage.dart';
import 'package:flutter_project/database/localdatabase.dart';
import 'package:get/get.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(BottomNavigationController(), permanent: true);
  Get.put(CategoryController(), permanent: true);
  Get.put(QuizController(), permanent: true);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppPages.home,
      getPages: AppPages.routes,
      initialBinding: HomeBindings(),
    );
  }
}
