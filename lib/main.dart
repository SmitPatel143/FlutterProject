import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/constants/app_pages.dart';
import 'package:flutter_project/core/Bindings/Home_Binding.dart';
import 'package:flutter_project/core/controllers/BottomNavigationController.dart';
import 'package:flutter_project/core/controllers/category_controller.dart';
import 'package:flutter_project/core/controllers/quiz_controller.dart';
import 'package:flutter_project/service/authenticate/auth_service.dart';
import 'package:flutter_project/firebase_options.dart';
import 'package:flutter_project/service/messaging/firebase_messaging.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Get.put(BottomNavigationController(), permanent: true);
  Get.put(CategoryController(), permanent: true);
  Get.put(QuizController(), permanent: true);
  Firebase.initializeApp();
  // await FirebaseMessage.getNotificationSettings();
  // await FirebaseMessage.getFCMToken();
  // FirebaseMessage.getFirebaseInstallationID();
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
