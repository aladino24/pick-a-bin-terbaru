import 'dart:async';

import 'package:boilerplate/models/UserJadwal.dart';
import 'package:boilerplate/models/schedule/list_schedule.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SchedulePage extends StatefulWidget {
  @override
  _SchedulePageState createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  final ref = FirebaseDatabase.instance
      .ref()
      .child('jadwal')
      .orderByChild('status')
      .equalTo(false);
  // bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: FirebaseAnimatedList(
              query: ref,
              itemBuilder: (BuildContext context, DataSnapshot snapshot,
                  Animation<double> animation, int index) {
                bool isChecked = snapshot.child('status').value as bool;
                return InkWell(
                  child: Column(
                    children: <Widget>[
                      CheckboxListTile(
                        title: Text(
                          snapshot.child('instansi').value.toString() +
                              " - " +
                              snapshot
                                  .child('penanggungJawab')
                                  .value
                                  .toString(),
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle:
                            Text(snapshot.child('alamat').value.toString()),
                        secondary: CircleAvatar(
                            backgroundImage: AssetImage(
                          "assets/images/user_icon.png",
                        )),
                        activeColor: Colors.green,
                        checkColor: Colors.white,
                        selected: isChecked,
                        value: isChecked,
                        onChanged: (bool? value) async {
                          final database = FirebaseDatabase.instance.ref();
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          setState(() {
                            isChecked = value!;
                          });
                          // await new Future.delayed(const Duration(seconds: 2));
                          var key = snapshot.key;
                          final data =
                              await database.child('jadwal/$key').get();
                          final status = await database
                              .child('jadwal/$key')
                              .child('status')
                              .get();

                          DatabaseReference up =
                              FirebaseDatabase.instance.ref("jadwal/$key");
                          up.update({
                            "petugas": prefs.getString('nama'),
                            "status": true,
                          });

                          print("value: ${status.value}");

                          if(data.exists){
                            Timer(Duration(minutes: 1), (){
                              up.update({
                              "status": false,
                            });
                            });
                          }else{
                            Timer(Duration(minutes: 2), () {
                            database.child('jadwal').push().set({
                              'instansi':
                                  snapshot.child('instansi').value.toString(),
                              'penanggungJawab': snapshot
                                  .child('penanggungJawab')
                                  .value
                                  .toString(),
                              'alamat':
                                  snapshot.child('alamat').value.toString(),
                              'telp': snapshot.child('telp').value.toString(),
                              'status': false,
                            });
                          });
                          }

                          

                          //setelah ganti hari tapi belum konfirmasi data di langsung insert ke activity
                      
                          if (data.value != null && status.value == false) {
                            Timer(Duration(seconds: 10), () {
                              database.child("aktivitas").push().set({
                                'instansi':
                                    snapshot.child('instansi').value.toString(),
                                'penanggungJawab': snapshot
                                    .child('penanggungJawab')
                                    .value
                                    .toString(),
                                'alamat':
                                    snapshot.child('alamat').value.toString(),
                                'telp': snapshot.child('telp').value.toString(),
                                'tanggal': DateFormat('dd/MM/yyyy')
                                    .format(DateTime.now())
                                    .toString(),
                                'waktu': DateFormat('hh:mm')
                                    .format(DateTime.now())
                                    .toString(),
                                'petugas': prefs.getString('nama'),
                              });
                              DatabaseReference del =
                                  FirebaseDatabase.instance.ref("jadwal/$key");
                              del.remove();
                            });
                          }


                        },
                      ),
                    ],
                  ),
                );
              }),
        ));
  }
}
