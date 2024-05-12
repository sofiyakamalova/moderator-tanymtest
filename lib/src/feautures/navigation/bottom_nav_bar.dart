import 'package:flutter/material.dart';
import 'package:tanymtest_moderator_app/src/core/constants/app_colors.dart';
import 'package:tanymtest_moderator_app/src/feautures/groups/groups_page.dart';
import 'package:tanymtest_moderator_app/src/feautures/results/tests_page.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  List pages = [
    const GroupsPage(),
    const TestsPage(),
    Container(color: Colors.yellow),
    Container(color: Colors.blue),
  ];
  int currentIndex = 0;
  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: pages[currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          onTap: onTap,
          currentIndex: currentIndex,
          selectedItemColor: AppColors.primary_color,
          unselectedItemColor: AppColors.grey_color,
          items: const [
            BottomNavigationBarItem(
              label: "Классы",
              icon: ImageIcon(
                AssetImage('assets/icons/category.png'),
              ),
            ),
            BottomNavigationBarItem(
              label: "Результаты",
              icon: ImageIcon(
                AssetImage('assets/icons/tick.png'),
              ),
            ),
            BottomNavigationBarItem(
              label: "Чат",
              icon: Icon(Icons.chat_outlined),
            ),
            BottomNavigationBarItem(
              label: "Встречи",
              icon: Icon(Icons.access_time),
            ),
          ],
        ),
      ),
    );
  }
}
