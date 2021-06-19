import 'package:attendance/screen/home_screen.dart';
import 'package:attendance/screen/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FirebaseUser firebaseUser = Provider.of<FirebaseUser>(context);
    var ab = firebaseUser;
    print(ab);
    return LoginScreen();
    // return (firebaseUser == null) ? LoginScreen() : HomeScreen();
  }
}
