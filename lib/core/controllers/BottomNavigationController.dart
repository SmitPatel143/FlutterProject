import 'package:flutter_project/constants/app_pages.dart';
import 'package:flutter_project/constants/globals.dart';
import 'package:get/get.dart';

class BottomNavigationController extends GetxController {
  RxInt selectedIndex = 0.obs;

  final pages = <String>[AppPages.home, '/', AppPages.category];

  void onChange(int index) {
    selectedIndex.value = index;
    Get.toNamed(pages[index]);
  }
}
