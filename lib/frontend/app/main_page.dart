import 'package:flutter/material.dart';
import 'package:orchid_furniture/constants.dart';

import 'package:orchid_furniture/frontend/app/posts/add_property.dart';
import 'package:orchid_furniture/frontend/app/home/home_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final homeNavKey = GlobalKey<NavigatorState>();
  final searchNavKey = GlobalKey<NavigatorState>();
  final notificationNavKey = GlobalKey<NavigatorState>();
  final profileNavKey = GlobalKey<NavigatorState>();
  int selectedTab = 0;
  List<Widget> pages = [
    const HomePage(),
    Text('data'),

    // ShiftPage(),
    AddFurniturePage(),
    // const ProfilePage()
    Text('data'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        backgroundColor: lightWoodcol,
        items: [
          BottomNavigationBarItem(
            label: '',
            icon: Icon(
                color: selectedTab == 0 ? woodcol : col60,
                size: selectedTab == 0 ? 40 : 28,
                Icons.home_outlined),
          ),
          BottomNavigationBarItem(
            label: '',
            icon: Icon(
                color: selectedTab == 1 ? woodcol : col60,
                size: selectedTab == 1 ? 40 : 28,
                Icons.bed_sharp),
          ),
          BottomNavigationBarItem(
            label: '',
            icon: Icon(
                color: selectedTab == 2 ? woodcol : col60,
                size: selectedTab == 2 ? 40 : 28,
                Icons.add_outlined),
          ),
          BottomNavigationBarItem(
            label: '',
            icon: Icon(
                color: selectedTab == 3 ? woodcol : col60,
                size: selectedTab == 3 ? 40 : 28,
                Icons.person_outline),
          ),
        ],
        currentIndex: selectedTab,
        onTap: (value) {
          setState(() {
            selectedTab = value;
          });
        },
      ),
      body: pages[selectedTab],
    );
  }
}
