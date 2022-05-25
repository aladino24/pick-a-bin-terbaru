import 'package:boilerplate/ui/activity/activity.dart';
import 'package:boilerplate/ui/home/home.dart';
import 'package:boilerplate/ui/profile/profile.dart';
import 'package:boilerplate/ui/schedule/list_schedule.dart';
import 'package:boilerplate/ui/schedule/tab_bar.dart';
import 'package:flutter/material.dart';

class Navbar extends StatefulWidget {
  @override
  _NavbarState createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  int selectedPage = 0;

  final _pageOptions = [
    HomePage(),
    StackOver(),
    ActivityPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _pageOptions[selectedPage],
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month_outlined),
              label: 'Jadwal',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.list_alt_outlined),
              label: 'Aktivitas',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.supervised_user_circle_outlined),
              label: 'Profile',
            ),
          ],
          showUnselectedLabels: true,
          currentIndex: selectedPage,
          unselectedItemColor: Colors.grey,
          selectedItemColor: Colors.green,
          onTap: (index){
            setState(() {
              selectedPage = index;
            });
          },
        ),
    );
  }
}