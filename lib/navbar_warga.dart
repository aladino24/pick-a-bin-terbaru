// import 'package:boilerplate/ui/activity/activity.dart';
// import 'package:boilerplate/ui/activity/user_activity.dart';
// import 'package:boilerplate/ui/home/home_petugas.dart';
// import 'package:boilerplate/ui/home/home_warga.dart';
// import 'package:boilerplate/ui/home/list_petugas.dart';
// import 'package:boilerplate/ui/profile/profile_warga.dart';
// import 'package:boilerplate/ui/profile/profile_petugas.dart';
// import 'package:boilerplate/ui/schedule/list_schedule.dart';
// import 'package:boilerplate/ui/schedule/tab_bar.dart';
// import 'package:flutter/material.dart';

// class NavbarWarga extends StatefulWidget {
//   @override
//   _NavbarWargaState createState() => _NavbarWargaState();
// }

// class _NavbarWargaState extends State<NavbarWarga> {
//   int selectedPage = 0;

//   final _pageOptions = [
//     HomeWarga(),
//     DaftarPetugasPage(),
//     AktifitasWarga(),
//     UserProfilePage(),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: _pageOptions[selectedPage],
//       bottomNavigationBar: BottomNavigationBar(
//           type: BottomNavigationBarType.fixed,
//           items: const <BottomNavigationBarItem>[
//             BottomNavigationBarItem(
//               icon: Icon(Icons.home_outlined),
//               label: 'Home',
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.calendar_month_outlined),
//               label: 'Petugas',
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.list_alt_outlined),
//               label: 'Aktivitas',
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.supervised_user_circle_outlined),
//               label: 'Profile',
//             ),
//           ],
//           showUnselectedLabels: true,
//           currentIndex: selectedPage,
//           unselectedItemColor: Colors.grey,
//           selectedItemColor: Colors.green,
//           onTap: (index){
//             setState(() {
//               selectedPage = index;
//             });
//           },
//         ),
//     );
//   }
// }