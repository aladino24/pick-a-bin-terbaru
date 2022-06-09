import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class ListDonePage extends StatelessWidget {
  ListDonePage({Key? key}) : super(key: key);
  final fb = FirebaseDatabase.instance;
  final databaseRef = FirebaseDatabase.instance.ref();
  

  @override
  Widget build(BuildContext context) {
    final ref = fb.ref().child('jadwal').orderByChild('status').equalTo(true);
    
    return Scaffold(
      body: FirebaseAnimatedList(
          query: ref,
          itemBuilder: (BuildContext context, DataSnapshot snapshot, Animation<double> animation, int index) {
            
            Timer(Duration(minutes: 1), (){

            });
            return InkWell(
              child: Padding(
                padding: EdgeInsets.only(top: 0),
                child: Column(
                  children: <Widget>[
                    ListTile(
                      title: Text(snapshot.child('instansi').value.toString() + " - " + snapshot.child('penanggungJawab').value.toString(),
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(snapshot.child('alamat').value.toString()),
                      leading: CircleAvatar(
                        backgroundImage: AssetImage("assets/images/user_icon.png"),
                      ),
                      trailing: new Wrap(
                        children: <Widget>[
                          new Container(
                            child: new IconButton(
                              icon: new Icon(Icons.highlight_off, color: Colors.orange),
                              onPressed: () {
                                var key = snapshot.key;
                                DatabaseReference up = FirebaseDatabase.instance.ref("jadwal/$key");
                                up.update({
                                  "status": false,
                                });
                              },
                            ),
                          ),new Container(
                            child: new IconButton(
                              icon: new Icon(Icons.chat_outlined, color: Colors.green),
                              onPressed: () async {
                                final SharedPreferences prefs = await SharedPreferences.getInstance();
                                databaseRef.child("aktivitas").push().set({
                                  'instansi': snapshot.child('instansi').value.toString(),
                                  'penanggungjawab': snapshot.child('penanggungJawab').value.toString(),
                                  'alamat': snapshot.child('alamat').value.toString(),
                                  'telp': snapshot.child('telp').value.toString(),
                                  'tanggal': DateFormat('dd/MM/yyyy').format(DateTime.now()).toString(),
                                  'waktu': DateFormat('hh:mm').format(DateTime.now()).toString(),
                                  'petugas' : prefs.getString('nama'),
                                });
                                var key = snapshot.key;
                                DatabaseReference del = FirebaseDatabase.instance.ref("jadwal/$key");
                                del.remove();
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
      ),
    );
  }
}

// function timer to insert data to aktivitas after 1 minute

// void _getTimer({required BuildContext context, required DataSnapshot snapshot, required String date, required String time, required String instansi, required String alamat, required String telp, required String penanggungJawab}) async {
//   final SharedPreferences prefs = await SharedPreferences.getInstance();
//   final database = FirebaseDatabase.instance.ref();
//   var key = snapshot.key;
//   final data = await database.child('jadwal/$key').get();
//   final status = await database.child('jadwal/$key').child('status').get();
  
//   database.child("aktivitas").push().set({
//     'instansi': instansi,
//     'penanggungjawab': penanggungJawab,
//     'alamat': alamat,
//     'telp': telp,
//     'tanggal': date,
//     'waktu': time,
//     'petugas' : prefs.getString('nama'),
//   });

  
// }

void launchWhatsApp({required int phone}) async {
  String url() {
    return "whatsapp://send?phone="+phone.toString()+"&text=Sampah Anda sudah diambil";
  }

  if (await canLaunch(url())) {
    await launch(url());
  } else {
    throw 'Could not launch ${url()}';
  }
}