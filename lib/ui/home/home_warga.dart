import 'package:boilerplate/ui/activity/activity.dart';
import 'package:boilerplate/ui/home/list_contact.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomeWarga extends StatefulWidget {
  const HomeWarga({Key? key}) : super(key: key);

  @override
  State<HomeWarga> createState() => _HomeWargaState();
}

class _HomeWargaState extends State<HomeWarga> {
  bool isChecked = false;
  final ref = FirebaseDatabase.instance.ref().child('jadwal');

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
                  "Jadwal Terbaru",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                )
            ),
            FirebaseAnimatedList(
                shrinkWrap: true,
                query: ref.limitToLast(3),
                itemBuilder: (BuildContext context, DataSnapshot snapshot, Animation<double> animation, int index) {
                  return Column(
                    children: <Widget>[
                      ListTile(
                        title: Text(
                          snapshot.child('instansi').value.toString() + " - " + snapshot.child('penanggungjawab').value.toString(),
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: snapshot.child('tanggal').value.toString() == DateFormat('dd/MM/yyyy').format(DateTime.now())
                            ? Text(snapshot.child('waktu').value.toString(), style: TextStyle(color: Colors.grey))
                            : snapshot.child('tanggal').value.toString() == DateFormat('dd/MM/yyyy').format(DateTime.now().subtract(Duration(days:1)))
                            ? Text("Yesterday", style: TextStyle(color: Colors.grey))
                            : Text(snapshot.child('tanggal').value.toString(), style: TextStyle(color: Colors.grey)),
                        leading: CircleAvatar(
                          backgroundImage: AssetImage("assets/images/activity_icon.png"),
                        ),
                      ),
                      Divider(
                        color: Colors.black,
                      ),
                    ],
                  );
                }
            )
          ],
        ),
      ),
    );
  }
}