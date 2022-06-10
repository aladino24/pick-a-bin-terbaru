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

class UpdateWargaPage extends StatefulWidget {
  const UpdateWargaPage({Key? key}) : super(key: key);

  @override
  State<UpdateWargaPage> createState() => _UpdateWargaPageState();
}

class _UpdateWargaPageState extends State<UpdateWargaPage> {
  AuthService authService = AuthService();
  final ref = FirebaseDatabase.instance.ref().child('warga');

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
                    final TextEditingController _instansiController =
                        new TextEditingController(
                            text: snapshot.child('instansi').value.toString());
                    final TextEditingController _penanggungJawabController =
                        new TextEditingController(
                            text: snapshot
                                .child('penanggungJawab')
                                .value
                                .toString());
                    final TextEditingController _alamatController =
                        new TextEditingController(
                            text: snapshot.child('alamat').value.toString());
                    final TextEditingController _emailController =
                        new TextEditingController(
                            text: snapshot.child('email').value.toString());
                    final TextEditingController _telpController =
                        new TextEditingController(
                            text: snapshot.child('telp').value.toString());
                    final TextEditingController _tglAmbilSampahControler =
                        new TextEditingController(
                            text: snapshot
                                .child('tglAmbilSampah')
                                .value
                                .toString());
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
                                    "Nama Instansi",
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 5),
                                TextFormField(
                                  controller: _instansiController,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Nama Instansi Harus Diisi';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.person,
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
                                    "Penanggung Jawab",
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 5),
                                TextFormField(
                                  controller: _penanggungJawabController,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Nama Penanggung Jawab Harus Diisi';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.person,
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
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    "Pengambilan Sampah",
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 5),
                                TextFormField(
                                  controller: _tglAmbilSampahControler,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Pengambilan Sampah Harus Diisi';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.date_range,
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
                                SizedBox(height: 35),
                                Container(
                                  width: 325,
                                  height: 50,
                                  child: ElevatedButton(
                                      onPressed: () async {
                                        final String namaInstansi =
                                            _instansiController.text.trim();
                                        final String penanggungJawab =
                                            _penanggungJawabController.text
                                                .trim();
                                        final String alamat =
                                            _alamatController.text.trim();
                                        final String email =
                                            _emailController.text.trim();
                                        final String tglAmbilSampah =
                                            _tglAmbilSampahControler.text
                                                .trim();
                                        final String telp =
                                            _telpController.text.trim();

                                        if (_formKey.currentState!
                                            .validate()) {}

                                        if (namaInstansi.isEmpty) {
                                          print("Nama Instansi kosong");
                                        } else {
                                          if (penanggungJawab.isEmpty) {
                                            print("Penanggung Jawab kosong");
                                          } else {
                                            if (alamat.isEmpty) {
                                              print("Alamat kosong");
                                            } else {
                                              if (email.isEmpty) {
                                                print("Email kosong");
                                              } else {
                                                if (telp.isEmpty) {
                                                  print("No. Telp kosong");
                                                } else {
                                                  if (tglAmbilSampah.isEmpty) {
                                                    print(
                                                        "Tanggal Pengambilan Sampah kosong");
                                                  } else {
                                                    print(
                                                        "penanggungJawab : ${penanggungJawab}");
                                                    print("email : ${email}");
                                                    var key = snapshot.key;
                                                    print(
                                                        "penanggungJawab : ${penanggungJawab}");
                                                    print("email : ${email}");
                                                  //  authService
                                                  //       .updateEmail(email);
                                                    authService
                                                        .updateDisplayName(
                                                            penanggungJawab)
                                                        .then((value) async {
                                                      DatabaseReference data =
                                                          FirebaseDatabase
                                                              .instance
                                                              .ref(
                                                                  "warga/$key");
                                                      data.update({
                                                        "instansi":
                                                            namaInstansi,
                                                        "penanggungJawab":
                                                            penanggungJawab,
                                                        "alamat": alamat,
                                                        "email": email,
                                                        "telp": telp,
                                                        "tglAmbilSampah":
                                                            tglAmbilSampah,
                                                      });
                                                      DatabaseReference
                                                          dataJadwal =
                                                          FirebaseDatabase
                                                              .instance
                                                              .ref(
                                                                  "jadwal/$key");
                                                      dataJadwal.update({
                                                        "instansi":
                                                            namaInstansi,
                                                        "penanggungJawab":
                                                            penanggungJawab,
                                                        "alamat": alamat,
                                                        "email": email,
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
