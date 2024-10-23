import 'package:ai_saas_application/pages/homepage.dart';
import 'package:ai_saas_application/pages/hostorypage.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  void _onIconTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _selectedIndex == 0 ? const Homepage() : const Historypage(),
      bottomNavigationBar: BottomNavigationBar(
          onTap: _onIconTapped,
          currentIndex: _selectedIndex,
          selectedFontSize: 14,
          unselectedFontSize: 14,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home_outlined,
                  size: 24,
                ),
                label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.history,
                  size: 24,
                ),
                label: "History")
          ]),
    );
  }
}
