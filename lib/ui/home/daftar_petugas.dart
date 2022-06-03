import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class DaftarPetugasPage extends StatefulWidget {
  DaftarPetugasPage({Key? key}) : super(key: key);

  @override
  State<DaftarPetugasPage> createState() => _DaftarPetugasPageState();
}

class _DaftarPetugasPageState extends State<DaftarPetugasPage> {
  final ref = FirebaseDatabase.instance.ref().child('petugas');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text(
            'List Petugas',
            style: TextStyle(color: Color(0xff00783E)),
          ),
          automaticallyImplyLeading: false,
          leadingWidth: 100,
          leading: ElevatedButton.icon(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Color(0xff00783E),
            ),
            label: const Text(
              'Back',
              style: TextStyle(color: Color(0xff00783E)),
            ),
            style: ElevatedButton.styleFrom(
                elevation: 0, primary: Colors.transparent),
          ),
        ),
        body: FirebaseAnimatedList(
            query: ref,
            itemBuilder: (BuildContext context, DataSnapshot snapshot,
                Animation<double> animation, int index) {
              return Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: ListTile(
                      trailing: Icon(Icons.phone),
                      title: Text(
                        snapshot.child('nama').value.toString(),
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(snapshot.child('telp').value.toString()),
                      leading: CircleAvatar(
                        backgroundImage:
                            AssetImage("assets/images/user_icon.png"),
                      ),
                    ),
                  ),
                  Divider(
                    color: Colors.black,
                  )
                ],
              );
            }));
  }
}
