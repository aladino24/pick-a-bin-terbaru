// import 'package:boilerplate/constants/font_family.dart';
import 'package:boilerplate/ui/login/login_petugas.dart';
import 'package:boilerplate/ui/login/login_warga.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChooseRole extends StatelessWidget {
  const ChooseRole({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQueryHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.only(left: 35, right: 35),
            child: ListView(
                children: <Widget>[
                  Container(
                      height: mediaQueryHeight * 0.4,
                      margin: EdgeInsets.only(top: 50),
                      child: Image.asset("assets/images/role_baru.png",)
                  ),
                  Container(
                      height: mediaQueryHeight * 0.2,
                      child: Column(
                        children: [
                          const Text(
                            "Pick A Bin",
                            style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Color(0xff00783E)),
                            textAlign: TextAlign.center,
                          ),
                          const Text(
                            "Aplikasi Penjadwalan Pengambilan Sampah",
                            style: TextStyle(fontSize: 15, fontFamily: 'Sans', fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      )
                  ),
                  Container(
                      height: mediaQueryHeight * 0.23,
                      // margin: EdgeInsets.only(top: 100),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Text(
                            "Silahkan Pilih Role Anda",
                            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Color(0xff00783E)),
                            textAlign: TextAlign.center,
                          ),
                          // margin: EdgeInsets.only(top: 10),
                          Container(
                            width: 500,
                            margin: EdgeInsets.only(top: 10),
                            child: ElevatedButton(
                              onPressed: ()async{
                                final SharedPreferences prefs = await SharedPreferences.getInstance();
                                prefs.setString('role', 'petugas');
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPetugasPage()));
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(17),
                                child: Text('PETUGAS', style: TextStyle(fontSize: 17),),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Container(
                            width: 500,
                            child: OutlinedButton(
                              onPressed: ()async{
                                final SharedPreferences prefs = await SharedPreferences.getInstance();
                                prefs.setString('role', 'warga');
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginWargaPage()));
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(17),
                                child: Text("WARGA", style: TextStyle(fontSize: 17),),
                              ),
                            ),
                          )
                        ],
                      )
                  ),
                ]
            )
        )
    );
  }
}