import 'package:boilerplate/models/sharedpreference/SharedPrefrences.dart';
import 'package:boilerplate/ui/activity/activity.dart';
import 'package:boilerplate/ui/activity/user_activity.dart';
import 'package:boilerplate/ui/home/home_petugas.dart';
import 'package:boilerplate/ui/home/home_warga.dart';
import 'package:boilerplate/ui/home/list_petugas.dart';
import 'package:boilerplate/ui/profile/profile_petugas.dart';
import 'package:boilerplate/ui/profile/profile_warga.dart';
import 'package:boilerplate/ui/schedule/list_schedule.dart';
import 'package:boilerplate/ui/schedule/tab_bar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Navbar extends StatefulWidget {
  @override
  _NavbarState createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  

// @override
// void initState() async {
//   super.initState();
//   final SharedPreferences prefs = await SharedPreferences.getInstance();
//   final String? rule = prefs.getString('role');
// }

  int selectedPage = 0;

  final _pageOptionsPetugas = [
    HomePetugasPage(),
    StackOver(),
    ActivityPage(),
    ProfilePetugasPage(),
  ];

  final _pageOptionsWarga = [
    HomeWarga(),
    DaftarPetugasPage(),
    AktifitasWarga(),
    ProfileWargaPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getRole(),
      builder: (context, snapshot){
        if(snapshot.hasData){
          print(snapshot.data);
          return Scaffold(
          backgroundColor: Colors.white,
          body: snapshot.data == 'petugas' ? _pageOptionsPetugas[selectedPage] : _pageOptionsWarga[selectedPage],
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: snapshot.data == 'petugas' ? Icon(Icons.calendar_month_outlined) : Icon(Icons.perm_contact_calendar_outlined),
                label: snapshot.data == 'petugas' ? "Jadwal" : "Petugas",
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
        }else{
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }

  Future<String?> _getRole() async{
   final SharedPreferences prefs = await SharedPreferences.getInstance();
   final String? role = prefs.getString('role');
   return role;
}

}