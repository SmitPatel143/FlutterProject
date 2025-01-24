import 'package:flutter/material.dart' show BottomNavigationBar, BottomNavigationBarItem, BottomNavigationBarType, BuildContext, Color, FontWeight, Icon, Icons, StatelessWidget, TextStyle, Widget;


class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavBar(
      {super.key, required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      elevation: 0,
      backgroundColor: Color(0xFF121212),
      selectedItemColor: Color(0xFF00A1FF),
      unselectedItemColor: Color(0xFF9E9E9E),
      type: BottomNavigationBarType.fixed,
      unselectedLabelStyle: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.bold,
        color: Color(0xFFFFFFFF),

      ),
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
        BottomNavigationBarItem(icon: Icon(Icons.notifications), label: 'Notifications'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
      ],
    );
  }
}
