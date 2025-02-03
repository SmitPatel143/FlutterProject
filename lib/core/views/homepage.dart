import "package:flutter/material.dart";
import "package:flutter_project/core/controllers/BottomNavigationController.dart";
import "package:get/get.dart";
import "../../constants/app_pages.dart";

class HomePage extends GetView<BottomNavigationController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Obx(() => IndexedStack(
        index: controller.selectedIndex.value,
        children: AppPages.tabPages,
      )),
      bottomNavigationBar: Obx(() => BottomNavigationBar(
        currentIndex: controller.selectedIndex.value,
        onTap: controller.onChange,
        backgroundColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        iconSize: 23,
        unselectedItemColor: Colors.grey,
        selectedItemColor: const Color(0xFF0F85EE),
        selectedFontSize: 12,
        unselectedFontSize: 12,
        elevation: 5,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.quiz_outlined), label: 'Quiz'),
        ],
      )),
    );
  }
}
