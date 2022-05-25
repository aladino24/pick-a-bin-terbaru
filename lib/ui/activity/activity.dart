import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ActivityPage extends StatelessWidget {
  ActivityPage({Key? key}) : super(key: key);
  final ref = FirebaseDatabase.instance.ref().child('aktivitas').orderByChild('tanggal');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Aktivitas',
          style: TextStyle(color: Color(0xff00783E)),
        ),
        automaticallyImplyLeading: false,
        leadingWidth: 100,
      ),
      body: FirebaseAnimatedList(
        query: ref,
        itemBuilder: (BuildContext context, DataSnapshot snapshot, Animation<double> animation, int index) {
          return Column(
            children: <Widget>[
              Dismissible(
                key: Key(index.toString()),
                direction: DismissDirection.endToStart,
                background: Container(
                  color: Colors.red,
                  child: Text("Hapus", style: TextStyle(color: Colors.white)),
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.only(right: 20),
                ),
                confirmDismiss: (direction){
                  return showDialog(
                      context: context,
                      builder: (context){
                        return AlertDialog(
                          title: Text("Konfirmasi"),
                          content: Text("Apakah Anda yakin akan menghapus aktivitas ini? "),
                          actions: [
                            FlatButton(
                                onPressed: (){
                                  Navigator.of(context).pop();
                                },
                                child: Text("Tidak")
                            ),
                            FlatButton(
                                onPressed: (){
                                  Navigator.of(context).pop();
                                  var key = snapshot.key;
                                  DatabaseReference del = FirebaseDatabase.instance.ref("aktivitas/$key");
                                  del.remove();
                                },
                                child: Text("Yakin")
                            ),
                          ],
                        );
                      });
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    title: Text(
                      "Anda sudah mengambil sampah",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(snapshot.child('instansi').value.toString() + " - " + snapshot.child('penanggungjawab').value.toString() + "\n" + snapshot.child('alamat').value.toString() ),
                    trailing: snapshot.child('tanggal').value.toString() == DateFormat('dd/MM/yyyy').format(DateTime.now())
                        ? Text(snapshot.child('waktu').value.toString(), style: TextStyle(color: Colors.grey))
                        : snapshot.child('tanggal').value.toString() == DateFormat('dd/MM/yyyy').format(DateTime.now().subtract(Duration(days:1)))
                          ? Text("Yesterday", style: TextStyle(color: Colors.grey))
                          : Text(snapshot.child('tanggal').value.toString(), style: TextStyle(color: Colors.grey)),
                        leading: CircleAvatar(
                          backgroundImage: AssetImage("assets/images/activity_icon.png"),
                        ),
                  ),
                ),
              ),
              Divider(color: Colors.black)
            ],
          );
        }
      )
    );
  }
}
