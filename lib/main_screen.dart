import 'package:ai_saas_application/constant/colors.dart';
import 'package:ai_saas_application/pages/homepage.dart';
import 'package:ai_saas_application/pages/hostorypage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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
          items:[
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                "assets/languages.svg",
                colorFilter: ColorFilter.mode(
                    _selectedIndex == 0 ? secondaryColor : terneryColor,
                    BlendMode.srcIn),
                height: 24,
                width: 24,
                semanticsLabel: 'My SVG Image',
              ),
                label: "Home"),
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                "assets/folder-clock.svg",
                colorFilter: ColorFilter.mode(
                    _selectedIndex == 1 ? secondaryColor : terneryColor,
                    BlendMode.srcIn),
                height: 24,
                width: 24,
                semanticsLabel: 'My SVG Image',
              ),
                label: "History")
          ]),
    );
  }
}
