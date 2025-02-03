import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:flutter_project/core/controllers/BottomNavigationController.dart";
import "package:get/get.dart";
import "../../constants/app_pages.dart";

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomBottomNavigationBar().build(context);
  }
}

class CustomBottomNavigationBar extends GetView<BottomNavigationController> {
  const CustomBottomNavigationBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            "Quiz-App",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
        ),
        elevation: 2,

      ),
      backgroundColor: Colors.white,
      body: Obx(() => IndexedStack(
            index: controller.selectedIndex.value,
            children: AppPages.tabPages,
          )),
      bottomNavigationBar: Obx(() => BottomNavigationBar(
            currentIndex: controller.selectedIndex.value,
            onTap: controller.onChange,
            backgroundColor: Colors.white,
            type: BottomNavigationBarType.fixed,
            iconSize: 23,
            unselectedItemColor: Colors.grey,
            selectedItemColor: const Color(0xFF0F85EE),
            selectedFontSize: 12,
            unselectedFontSize: 12,
            elevation: 5,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home_filled), label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.search), label: 'Search'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.quiz_outlined), label: 'Quiz'),
            ],
          )),
    );
  }
}


