// import 'package:boilerplate/data/sharedpref/constants/preferences.dart';
// import 'package:boilerplate/utils/routes/routes.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:firebase_database/ui/firebase_animated_list.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class ProfilePage extends StatefulWidget {
//   const ProfilePage({Key? key}) : super(key: key);

//   @override
//   State<ProfilePage> createState() => _ProfilePageState();
// }

// class _ProfilePageState extends State<ProfilePage> {
//   //Read data once from Realtime Database
//   final ref = FirebaseDatabase.instance.ref().child('petugas');
  

//   @override
//   // DatabaseReference ref = FirebaseDatabase.instance.ref("petugas/1001");
//   // Future<void> initState() async {
//   //   super.initState();
//   //   DatabaseEvent event = await ref.once();
//   // }
//   Widget build(BuildContext context) {
    
//     return Scaffold(
      
//       appBar: AppBar(
//           centerTitle: true,
//           title: const Text(
//             'Profile',
//             style: TextStyle(color: Color(0xff00783E)),
//           ),
//           backgroundColor: Colors.transparent,
//           elevation: 0),
//       body: FirebaseAnimatedList(
//         query: ref.orderByChild('nama').equalTo('Aradhana Luqman'),
//         itemBuilder: (BuildContext context, DataSnapshot snapshot,
//             Animation<double> animation, int index) {
//         return Column(
//           children: [
//             Stack(
//               children: [
//                 Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     const Center(),
//                     const SizedBox(
//                       height: 120.0,
//                     ),
//                     Container(
//                       height: 490.0,
//                       width: 320,
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(20.0),
//                           color: Colors.black12),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           //Nama Lengkap
//                           Container(
//                             padding:
//                             const EdgeInsets.only(top: 120.0, left: 30.0),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   'Nama Lengkap',
//                                   style: TextStyle(
//                                     fontSize: 20,
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.black,
//                                   ),
//                                 ),
//                                 Text(
//                                   snapshot.child('nama').value.toString(),
//                                   style: TextStyle(
//                                     fontSize: 20,
//                                     color: Colors.black45,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
      
//                           //Alamat
//                           Container(
//                             padding: EdgeInsets.only(top: 30.0, left: 30.0),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   'Alamat',
//                                   style: TextStyle(
//                                     fontSize: 20,
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.black,
//                                   ),
//                                 ),
//                                 Text(
//                                   snapshot.child('alamat').value.toString(),
//                                   style: TextStyle(
//                                     fontSize: 20,
//                                     color: Colors.black45,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
      
//                           //Email
//                           Container(
//                             padding: EdgeInsets.only(top: 30.0, left: 30.0),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children:  [
//                                 Text(
//                                   'Email',
//                                   style: TextStyle(
//                                     fontSize: 20,
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.black,
//                                   ),
//                                 ),
//                                 Text(
//                                   snapshot.child('email').value.toString(),
//                                   style: TextStyle(
//                                     fontSize: 20,
//                                     color: Colors.black45,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
      
//                           //Button Logout
//                           Container(
//                             padding: const EdgeInsets.only(
//                                 top: 70.0, left: 30.0, right: 30.0),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Container(
//                                   width: 270,
//                                   child: ElevatedButton(
//                                     child: const Center(
//                                       child: Text(
//                                         'Logout',
//                                         style: TextStyle(
//                                           fontSize: 20,
//                                           color: Colors.white,
//                                         ),
//                                       ),
//                                     ),
//                                     style: ElevatedButton.styleFrom(
//                                       primary: Colors.green,
//                                       shape: RoundedRectangleBorder(
//                                         borderRadius: BorderRadius.circular(20.0),
//                                       ),
//                                     ),
//                                     onPressed: () {
//                                       SharedPreferences.getInstance().then((preference) {
//                                         preference.setBool(Preferences.is_logged_in, false);
//                                         Navigator.of(context).pushReplacementNamed(Routes.login);
//                                       });
//                                     },
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     )
//                   ],
//                 ),
//                 //circle image
//                 Positioned(
//                   top: 50,
//                   left: MediaQuery.of(context).size.width / 2 - 70,
//                   child: Center(
//                     child: Container(
//                       height: 140,
//                       width: 140,
//                       child: const CircleAvatar(
//                         radius: 60,
//                         backgroundColor: Colors.green,
//                         child: CircleAvatar(
//                           backgroundImage: AssetImage('assets/images/profile.png'),
//                           radius: 68,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(
//               height: 60.0,
//             ),
//           ],
//         );
//       }),
//     );
//   }
// }
