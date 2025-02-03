import 'package:get/get.dart';

class BottomNavigationController extends GetxController {
  RxInt selectedIndex = 0.obs;

  final pages = <String>['/home', '/category', '/quiz'];

  void onChange(int index) {
    selectedIndex.value = index;
    Get.toNamed(pages[index]);
  }
}
