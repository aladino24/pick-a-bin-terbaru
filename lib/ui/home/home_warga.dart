import 'package:boilerplate/ui/activity/activity.dart';
import 'package:boilerplate/ui/home/list_contact.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeWarga extends StatefulWidget {
  const HomeWarga({Key? key}) : super(key: key);

  @override
  State<HomeWarga> createState() => _HomeWargaState();
}

class _HomeWargaState extends State<HomeWarga> {
  bool isChecked = false;
  final ref = FirebaseDatabase.instance.ref().child('aktivitas');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Home',
            style: TextStyle(color: Color(0xff00783E)),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0),
      body: Padding(
        padding: const EdgeInsets.only(left: 30, right: 30),
        child: ListView(
          children: <Widget>[
            const Text(
              "Hi, User!",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 15,
            ),

            //Slider
            CarouselSlider(
              items: [
                //1st Image of Slider
                Container(
                  margin: EdgeInsets.all(6.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    image: DecorationImage(
                      image: ExactAssetImage('assets/images/slide1.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                //2nd Image of Slider
                Container(
                  margin: EdgeInsets.all(6.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    image: DecorationImage(
                      image: ExactAssetImage('assets/images/slide2.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                //3rd Image of Slider
                Container(
                  margin: EdgeInsets.all(6.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    image: DecorationImage(
                      image: ExactAssetImage('assets/images/slide3.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                //4th Image of Slider
                Container(
                  margin: EdgeInsets.all(6.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    image: DecorationImage(
                      image: ExactAssetImage('assets/images/slide4.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                //5th Image of Slider
                Container(
                  margin: EdgeInsets.all(4.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    image: DecorationImage(
                      image: ExactAssetImage('assets/images/slide5.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],

              //Slider Container properties
              options: CarouselOptions(
                height: 180.0,
                enlargeCenterPage: true,
                autoPlay: true,
                aspectRatio: 16 / 9,
                autoPlayCurve: Curves.fastOutSlowIn,
                enableInfiniteScroll: true,
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                viewportFraction: 0.8,
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    InkWell(
                        onTap: (){
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => ListContactPage()));
                        },
                      child: Container(
                        margin: const EdgeInsets.only(top: 40),
                        child: const Padding(
                            padding: EdgeInsets.all(10),
                            child: Icon(
                              Icons.supervised_user_circle_outlined,
                              size: 70,
                              color: Colors.green,
                            )),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(color: Colors.green, spreadRadius: 2),
                          ],
                        ),
                      ),
                    ),
                    Container(
                        margin: const EdgeInsets.only(top: 10),
                        child: const Text(
                          "Daftar Petugas \n",
                          textAlign: TextAlign.center,
                        ))
                  ],
                ),
                Column(
                  children: [
                    InkWell(
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => ActivityPage()));
                      },
                      child: Container(
                        margin: const EdgeInsets.only(top: 40),
                        child: const Padding(
                            padding: EdgeInsets.all(10),
                            child: Icon(
                              Icons.list_alt_outlined,
                              size: 70,
                              color: Colors.green,
                            )),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(color: Colors.green, spreadRadius: 2),
                          ],
                        ),

                      ),
                    ),
                    Container(
                        margin: const EdgeInsets.only(top: 10, bottom: 10),
                        child: const Text(
                          "Aktivitas",
                          textAlign: TextAlign.center,
                        ))
                  ],
                )
              ],
            ),

            Container(
                child: const Text(
                  "Aktivitas Terbaru",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                )
            ),
             //menambahkan listview
             SingleChildScrollView(
               child: FutureBuilder(
                       future: _getPrefs(),
                       builder: (context, snapshot) {
                         if (snapshot.hasData) {
                print("nama : ${snapshot.data}");
                return FirebaseAnimatedList(
                    //get email from shared preference
                    shrinkWrap: true,
                    query: ref
                        .orderByChild('penanggungjawab')
                        .equalTo("${snapshot.data}").limitToLast(2),
                    itemBuilder: (BuildContext context, DataSnapshot snapshot,
                        Animation<double> animation, int index) {
                      return Column(
                        children: <Widget>[
                          Dismissible(
                            key: Key(index.toString()),
                            direction: DismissDirection.endToStart,
                            background: Container(
                              color: Colors.red,
                              child: Text("Hapus",
                                  style: TextStyle(color: Colors.white)),
                              alignment: Alignment.centerRight,
                              padding: EdgeInsets.only(right: 20),
                            ),
                            confirmDismiss: (direction) {
                              return showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text("Konfirmasi"),
                                      content: Text(
                                          "Apakah Anda yakin akan menghapus aktivitas ini? "),
                                      actions: [
                                        FlatButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text("Tidak")),
                                        FlatButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                              var key = snapshot.key;
                                              DatabaseReference del =
                                                  FirebaseDatabase.instance
                                                      .ref("aktivitas/$key");
                                              del.remove();
                                            },
                                            child: Text("Yakin")),
                                      ],
                                    );
                                  });
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: ListTile(
                                title: Text.rich(
                                  TextSpan(
                                    children: <InlineSpan>[
                                      TextSpan(
                                        text: 'Sampah anda sudah diambil',
                                      ),
                                    ],
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                subtitle: Text.rich(
                                  TextSpan(
                                    children: <InlineSpan>[
                                      WidgetSpan(
                                          child: Icon(Icons.person_outline,
                                              color: Colors.green)),
                                      TextSpan(
                                          text: snapshot
                                                  .child('penanggungjawab')
                                                  .value
                                                  .toString() +
                                              "\n"),
                                      WidgetSpan(
                                          child: Icon(Icons.location_on_outlined,
                                              color: Colors.green)),
                                      TextSpan(
                                          text: snapshot
                                              .child('alamat')
                                              .value
                                              .toString()),
                                    ],
                                  ),
                                ),
                                trailing: snapshot
                                            .child('tanggal')
                                            .value
                                            .toString() ==
                                        DateFormat('dd/MM/yyyy')
                                            .format(DateTime.now())
                                    ? Text(
                                        snapshot.child('waktu').value.toString(),
                                        style: TextStyle(color: Colors.grey))
                                    : snapshot
                                                .child('tanggal')
                                                .value
                                                .toString() ==
                                            DateFormat('dd/MM/yyyy').format(
                                                DateTime.now()
                                                    .subtract(Duration(days: 1)))
                                        ? Text("Yesterday",
                                            style: TextStyle(color: Colors.grey))
                                        : Text(
                                            snapshot
                                                .child('tanggal')
                                                .value
                                                .toString(),
                                            style: TextStyle(color: Colors.grey)),
                                leading: CircleAvatar(
                                  backgroundImage: AssetImage(
                                      "assets/images/activity_icon.png"),
                                  backgroundColor: Colors.green,
                                ),
                              ),
                            ),
                          ),
                          Divider(color: Colors.black)
                        ],
                      );
                    });
                         } else {
                return Center(
                  child: Text("Belum ada aktivitas"),
                );
                         }
                       }),
             ),
             
          ],
        ),
      ),
    );
  }

  Future<String?> 
  _getPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? nama = prefs.getString('nama');
    return nama;
  }
}