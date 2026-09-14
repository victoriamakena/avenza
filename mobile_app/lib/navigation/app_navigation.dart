import 'package:flutter/material.dart';

import '../screens/home/home_screen.dart';
import '../screens/goals/goals_screen.dart';
import '../screens/savings/savings_screen.dart';
import '../screens/learn/learn_screen.dart';
import '../screens/more/more_screen.dart';
import '../widgets/bottom_nav_bar.dart';

class AppNavigation extends StatefulWidget {
  const AppNavigation({super.key});

  @override
  State<AppNavigation> createState() => _AppNavigationState();
}

class _AppNavigationState extends State<AppNavigation> {
  int currentIndex = 0;

  final screens = const [
    HomeScreen(),
    GoalsScreen(),
    SavingsScreen(),
    LearnScreen(),
    MoreScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: screens,
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
    );
  }
}