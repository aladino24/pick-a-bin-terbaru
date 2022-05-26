import 'package:boilerplate/ui/login/login_page.dart';
import 'package:boilerplate/ui/navbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  Stream<User?> get authStateChange => _auth.idTokenChanges();

  void loginUser(context) async {
    try {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Center(
                  child: CircularProgressIndicator(
                backgroundColor: Colors.green,
              )),
            );
          });
      await _auth
          .signInWithEmailAndPassword(
              email: email.text, password: password.text)
          .then((value) => {
                print("Login Successfully"),
                
                Navigator.push(
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
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => LoginPage()));
                },
              ),
            ],
          );
        },
      );
    }
  }

  Future<String> register(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return "Registration Successful";
      //Register Successful Notification

    } catch (e) {
      return e.toString();
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
  }
}
