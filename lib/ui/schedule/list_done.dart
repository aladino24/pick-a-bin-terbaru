import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class ListDonePage extends StatelessWidget {
  ListDonePage({Key? key}) : super(key: key);
  final fb = FirebaseDatabase.instance;
  final databaseRef = FirebaseDatabase.instance.reference();

  @override
  Widget build(BuildContext context) {
    final ref = fb.ref().child('jadwal').orderByChild('status').equalTo(true);
    return Scaffold(
      body: FirebaseAnimatedList(
          query: ref,
          itemBuilder: (BuildContext context, DataSnapshot snapshot, Animation<double> animation, int index) {
            return InkWell(
              child: Padding(
                padding: EdgeInsets.only(top: 0),
                child: Column(
                  children: <Widget>[
                    ListTile(
                      title: Text(snapshot.child('instansi').value.toString() + " - " + snapshot.child('penanggungjawab').value.toString(),
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
                              onPressed: () {
                                launchWhatsApp(phone: int.parse(snapshot.child('telp').value.toString()));
                                databaseRef.child("aktivitas").push().set({
                                  'instansi': snapshot.child('instansi').value.toString(),
                                  'penanggungjawab': snapshot.child('penanggungjawab').value.toString(),
                                  'alamat': snapshot.child('alamat').value.toString(),
                                  'telp': snapshot.child('telp').value.toString(),
                                  'tanggal': DateFormat('dd/MM/yyyy').format(DateTime.now()).toString(),
                                  'waktu': DateFormat('hh:mm').format(DateTime.now()).toString(),
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