import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:shop/constants.dart';
import 'package:shop/screens/home_page.dart';
import 'package:shop/screens/login_page.dart';

class LandingPage extends StatelessWidget {
  // ignore: non_constant_identifier_names
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
          // stream builder check the login state
          return StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, streamsnapshot) {
              // if streamsnapshot has error
              if (snapshot.hasError) {
                return Scaffold(
                  body: Center(
                    child: Text("Error: ${streamsnapshot.error}"),
                  ),
                );
              }

              // Connection state active - Do the user login check inside if statement
              if (streamsnapshot.connectionState == ConnectionState.active) {
                // Get the user
                User _user = streamsnapshot.data;

                // if the use is null, we're not logged in
                if (_user == null) {
                  return LoginPage();
                } else {
                  // The user is logged in head to home page
                  return HomePage();
                }
              }

              // checking the auth state -loading
              return Scaffold(
                body: Center(
                  child: Text(
                    "checking Authentication...",
                    style: Constants.regularHeading,
                  ),
                ),
              );
            },
          );
        }

        // connecting to firebase - loading

        return Scaffold(
          body: Center(
            child: Text(
              "initializing App...",
              style: Constants.regularHeading,
            ),
          ),
        );
      },
    );
  }
}
