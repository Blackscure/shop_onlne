import 'dart:html';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: LandingPage());
  }
}

class LandingPage extends StatelessWidget {
  final Future<FirebaseApp> _Initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _Initialization,
      builder: (context, snapshot) {
        // if snapshot has error
        if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text("Error: ${snapshot.error}"),
            ),
          );
        }

        // Connection initialized - Firebase App is running
        if (snapshot.connectionState == ConnectionState.done) {
          Scaffold(
            body: Center(
              child: Text("Firebase App Initialized"),
            ),
          );
        }

        // connecting to firebase

        return Scaffold(
          body: Center(
            child: Text("initializing App..."),
          ),
        );
      },
    );
  }
}
