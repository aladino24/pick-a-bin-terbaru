import 'package:boilerplate/ui/login/login_petugas.dart';
import 'package:boilerplate/ui/login/login_warga.dart';
import 'package:boilerplate/ui/navbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
 
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  Stream<User?> get authStateChange => _auth.idTokenChanges();

  //get current User ID
  Future<String?> getCurrentUID() async {
    final User? user = await _auth.currentUser;
    return user?.uid;
  }

  // Future<String?> getCurrentEmail () async {
  //   String? _userEmail = FirebaseAuth.instance.currentUser?.email;
  //   return _userEmail;
  // }

  void loginUserWarga(context) async {
    try {
     
      await _auth
          .signInWithEmailAndPassword(
              email: email.text, password: password.text)
          .then((value) => {
                print("Login Successfully"),
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => Navbar()))
              });
    } catch (e) {
      // print(e.toString());
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Username atau Password Salah"),
            content: Text("Pastikan Username dan Password Anda Benar"),
            actions: <Widget>[
              FlatButton(
                child: Text("Close"),
                color: Colors.red,
                onPressed: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (BuildContext context) => LoginWargaPage()));
                },
              ),
            ],
          );
        },
      );
    }
  }

  void loginUserPetugas(context) async {
    try {
      AlertDialog(
        title: Center(
            child: CircularProgressIndicator(
          backgroundColor: Colors.green,
        )),
      );

      await _auth
          .signInWithEmailAndPassword(
              email: email.text, password: password.text)
          .then((value) => {
                print("Login Successfully"),
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => Navbar()))
              });
    } catch (e) {
      // print(e.toString());
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Username atau Password Salah"),
            content: Text("Pastikan Username dan Password Anda Benar"),
            actions: <Widget>[
              FlatButton(
                child: Text("Close"),
                color: Colors.red,
                onPressed: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (BuildContext context) => LoginPetugasPage()));
                },
              ),
            ],
          );
        },
      );
    }
  }

  Future<String> register(String nama, String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      await _auth.currentUser?.updateDisplayName(nama);
      Fluttertoast.showToast(msg: "Registration Successfully",toastLength: Toast.LENGTH_SHORT);
      return "Registration Successfully";
      //Register Successful Notification

    } catch (e) {
      return e.toString();
    }
  }

  //Reset Password
  Future resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      Fluttertoast.showToast(msg: "Reset Password Successfully",toastLength: Toast.LENGTH_SHORT);
    } on FirebaseAuthException catch (e) {
      return e.toString();
    }
 
  }

  //Update Profile email
  // Future updateEmail(String email) async {
  //   try {
  //     await _auth.currentUser?.updateEmail(email);
  //     Fluttertoast.showToast(msg: "Update Profile Successfully",toastLength: Toast.LENGTH_SHORT);
  //   } catch (e) {
  //     return e.toString();
  //   }
  // }

  //Update Profile displayName
  Future updateDisplayName(String nama) async {
    try {
      await _auth.currentUser?.updateDisplayName(nama);
      Fluttertoast.showToast(msg: "Update Profile Successfully",toastLength: Toast.LENGTH_SHORT);
    } catch (e) {
      return e.toString();
    }
  }
  
   

  Future<void> logout() async {
    await _auth.signOut();
  }
}
