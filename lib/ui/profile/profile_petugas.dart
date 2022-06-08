import 'package:boilerplate/data/service/auth_service.dart';
import 'package:boilerplate/data/sharedpref/constants/preferences.dart';
import 'package:boilerplate/ui/authentication/choose_role.dart';
import 'package:boilerplate/ui/login/login_petugas.dart';
import 'package:boilerplate/ui/login/login_warga.dart';
import 'package:boilerplate/utils/routes/routes.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePetugasPage extends StatefulWidget {
  const ProfilePetugasPage({Key? key}) : super(key: key);

  @override
  State<ProfilePetugasPage> createState() => _ProfilePetugasPageState();
}

class _ProfilePetugasPageState extends State<ProfilePetugasPage> {
  //Read data once from Realtime Database
  final ref = FirebaseDatabase.instance.ref().child('petugas');
  AuthService authService = AuthService();


  @override
  // DatabaseReference ref = FirebaseDatabase.instance.ref("petugas/1001");
  // Future<void> initState() async {
  //   super.initState();
  //   DatabaseEvent event = await ref.once();
  // }
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Profile',
            style: TextStyle(color: Color(0xff00783E)),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0),
      body: FutureBuilder(
        future: _getPrefs(),
        builder: (context,snapshot){
          if(snapshot.hasData){
            print(snapshot.data);
            return FirebaseAnimatedList(
          query: ref.orderByChild('email').equalTo("${snapshot.data}"),
          itemBuilder: (BuildContext context, DataSnapshot snapshot,
              Animation<double> animation, int index) {
            return Column(
              children: [
                Stack(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Center(),
                        const SizedBox(
                          height: 85.0,
                        ),
                        Container(
                          height: 450.0,
                          width: 320,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              color: Colors.black12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //Nama Lengkap
                              Container(
                                padding:
                                const EdgeInsets.only(top: 100.0, left: 30.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Nama Lengkap',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Text(
                                      snapshot.child('nama').value.toString(),
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.black45,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              //Alamat
                              Container(
                                padding: EdgeInsets.only(top: 15.0, left: 30.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Alamat',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Text(
                                      snapshot.child('alamat').value.toString(),
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.black45,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              //Alamat
                              Container(
                                padding: EdgeInsets.only(top: 15.0, left: 30.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'No Telepon',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Text(
                                      snapshot.child('telp').value.toString(),
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.black45,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              //Email
                              Container(
                                padding: EdgeInsets.only(top: 15.0, left: 30.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children:  [
                                    Text(
                                      'Email',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Text(
                                      snapshot.child('email').value.toString(),
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.black45,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              //Button Logout
                              Container(
                                padding: const EdgeInsets.only(
                                    top: 30.0, left: 15.0, right: 30.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 270,
                                      child: ElevatedButton(
                                        child: const Center(
                                          child: Text(
                                            'Logout',
                                            style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        style: ElevatedButton.styleFrom(
                                          primary: Colors.green,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(20.0),
                                          ),
                                        ),

                                        onPressed: () async {
                                          SharedPreferences prefs = await SharedPreferences.getInstance();
                                          // prefs.remove('uid');
                                          prefs.clear();
                                          authService.logout();
                                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ChooseRole()));
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    //circle image
                    Positioned(
                      top: 20,
                      left: MediaQuery.of(context).size.width / 2 - 70,
                      child: Center(
                        child: Container(
                          height: 140,
                          width: 140,
                          child: const CircleAvatar(
                            radius: 60,
                            backgroundColor: Colors.green,
                            child: CircleAvatar(
                              backgroundImage: AssetImage('assets/images/user_icon.png'),
                              radius: 68,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 60.0,
                ),
              ],
            );
          });
          }else{
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        }
      )
    );
  }

   Future<String?> 
  _getPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString('email');
    return email;
  }
}