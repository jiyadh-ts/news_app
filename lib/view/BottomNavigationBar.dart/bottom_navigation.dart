import 'package:flutter/material.dart';
import 'package:news_app/view/HomePage/homepage.dart';
import 'package:news_app/view/bookmarpage/bookmarkpage.dart';
import 'package:news_app/view/profile_page/profile_page.dart';
import 'package:news_app/view/searchscreen/search_screen.dart';

class BottomNavbarScreen extends StatefulWidget {
  const BottomNavbarScreen({super.key});

  @override
  State<BottomNavbarScreen> createState() => _BottomNavbarScreenState();
}

class _BottomNavbarScreenState extends State<BottomNavbarScreen> {
  List Screen = [
    Homepage(),
    Searchscreen(),
    BookmarksPage(),
    ProfilePage(),
  ];
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Screen[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        currentIndex: selectedIndex,
        unselectedFontSize: 10,
        selectedFontSize: 10,
        backgroundColor: Colors.black,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "home"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "search"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.bookmark_sharp,
              ),
              label: "BookMark"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
        onTap: (value) {
          selectedIndex = value;
          setState(() {});
        },
      ),
    );
  }
}
