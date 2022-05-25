import 'package:firebase_auth/firebase_auth.dart';


class AuthService{
  final FirebaseAuth _auth;
  
  AuthService(this._auth);
  Stream<User?> get authStateChange => _auth.idTokenChanges();
  Future<String> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return "Login Successful";
    } catch (e) {
     return e.toString();
    }
  }

  Future<String> register(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return "Registration Successful";
    } catch (e) {
      return e.toString();
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
  }

}