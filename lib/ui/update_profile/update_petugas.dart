import 'package:boilerplate/ui/login/login.dart';
import 'package:boilerplate/ui/login/login_warga.dart';
import 'package:boilerplate/ui/navbar.dart';
import 'package:boilerplate/ui/profile/profile_warga.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/gestures.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/service/auth_service.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UpdatePetugasPage extends StatefulWidget {
  const UpdatePetugasPage({Key? key}) : super(key: key);

  @override
  State<UpdatePetugasPage> createState() => _UpdatePetugasPageState();
}

class _UpdatePetugasPageState extends State<UpdatePetugasPage> {
  AuthService authService = AuthService();
  final ref = FirebaseDatabase.instance.ref().child('petugas');

  final GlobalKey<FormState> _formKey = new GlobalKey();
  final _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Update Profile',
          style: TextStyle(color: Color(0xff00783E)),
        ),
        automaticallyImplyLeading: false,
        leadingWidth: 100,
      ),
      body: FutureBuilder(
          future: _getPrefs(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              print(snapshot.data);
              return FirebaseAnimatedList(
                  query: ref.orderByChild('email').equalTo("${snapshot.data}"),
                  itemBuilder: (BuildContext context, DataSnapshot snapshot,
                      Animation<double> animation, int index) {
                    final TextEditingController _namaLengkapController =
                        new TextEditingController(
                            text: snapshot.child('nama').value.toString());
                    
                    final TextEditingController _alamatController =
                        new TextEditingController(
                            text: snapshot.child('alamat').value.toString());
                
                    final TextEditingController _telpController =
                        new TextEditingController(
                            text: snapshot.child('telp').value.toString());
                   
                    return SingleChildScrollView(
                        child: Column(children: [
                      Positioned(
                        top: 50,
                        left: MediaQuery.of(context).size.width / 2 - 70,
                        child: Center(
                          child: Container(
                            height: 140,
                            width: 140,
                            child: const CircleAvatar(
                              radius: 60,
                              backgroundColor: Colors.green,
                              child: CircleAvatar(
                                backgroundImage:
                                    AssetImage('assets/images/user_icon.png'),
                                radius: 68,
                              ),
                            ),
                          ),
                        ),
                      ),
                      //create form with border
                      Container(
                        padding: EdgeInsets.all(15),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                //create email field
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    "Nama Lengkap",
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                               TextFormField(
                                  controller: _namaLengkapController,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Nama Harus Diisi';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.home,
                                      color: Colors.green,
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: BorderSide(
                                        width: 2,
                                        color: Colors.green,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: BorderSide(
                                        width: 2,
                                        color: Colors.green,
                                      ),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: BorderSide(
                                        width: 2,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 15),
                       
                               
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    "Alamat",
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 5),
                                TextFormField(
                                  controller: _alamatController,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Alamat Harus Diisi';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.home,
                                      color: Colors.green,
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: BorderSide(
                                        width: 2,
                                        color: Colors.green,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: BorderSide(
                                        width: 2,
                                        color: Colors.green,
                                      ),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: BorderSide(
                                        width: 2,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 15),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    "No.Telp",
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 5),
                                TextFormField(
                                  controller: _telpController,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'No. Telp harus diisi';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.phone,
                                      color: Colors.green,
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: BorderSide(
                                        width: 2,
                                        color: Colors.green,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: BorderSide(
                                        width: 2,
                                        color: Colors.green,
                                      ),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: BorderSide(
                                        width: 2,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                ),
                            
                                SizedBox(height: 15),
                                
                                Container(
                                  width: 325,
                                  height: 50,
                                  child: ElevatedButton(
                                      onPressed: () async {
                                        final String namaLengkap =
                                            _namaLengkapController.text.trim();
                                    
                                        final String alamat =
                                            _alamatController.text.trim();
                                    
                                       
                                        final String telp =
                                            _telpController.text.trim();

                                        if (_formKey.currentState!
                                            .validate()) {}

                                        if (namaLengkap.isEmpty) {
                                          print("Nama kosong");
                                        } else {
                                         
                                            if (alamat.isEmpty) {
                                              print("Alamat kosong");
                                            } else {
                                              
                                                if (telp.isEmpty) {
                                                  print("No. Telp kosong");
                                                } else {
                                                  
                                                   
                                                 
                                                    var key = snapshot.key;
                                                  
                                                   
                                                  //  authService
                                                  //       .updateEmail(email);
                                                    authService
                                                        .updateDisplayName(
                                                            namaLengkap)
                                                        .then((value) async {
                                                      DatabaseReference data =
                                                          FirebaseDatabase
                                                              .instance
                                                              .ref(
                                                                  "petugas/$key");
                                                      data.update({
                                                        "nama":
                                                            namaLengkap,
                                                        "alamat": alamat,
                                                        "telp": telp,
                                                       
                                                      });
                                                      
                                                    });
                                                   
                                                    Navigator.pushReplacement(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                Navbar()));
                                                  
                                                }
                                              
                                            }
                                          
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors.green,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                      ),
                                      child: Text(
                                        "Update Profile",
                                        style: TextStyle(
                                          fontSize: 20,
                                        ),
                                      )),
                                ),
                                SizedBox(height: 15),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ]));
                  });
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }

  Future<String?> _getPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString('email');
    return email;
  }
}
