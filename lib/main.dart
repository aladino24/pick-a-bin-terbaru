import 'dart:async';

import 'package:boilerplate/ui/my_app.dart';
import 'package:boilerplate/ui/navbar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'di/components/service_locator.dart';

//komentar
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var uid = prefs.getString('email');
  await setPreferredOrientations();
  await setupLocator();
  return runZonedGuarded(() async {
    runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: uid == null? MyApp(): Navbar()));
  }, (error, stack) {
    print(stack);
    print(error);
  });
}

Future<void> setPreferredOrientations() {
  return SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
    DeviceOrientation.landscapeRight,
    DeviceOrientation.landscapeLeft,
  ]);
}
