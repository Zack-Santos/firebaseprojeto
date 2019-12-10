import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final googleSignIn = GoogleSignIn();
  final auth = FirebaseAuth.instance;

  Future<Null> _ensureLoggeIn() async {
    GoogleSignInAccount user = googleSignIn.currentUser;

    if (user == null) {
      user = await googleSignIn.signInSilently();
    }

    if (user == null) {
      user = await googleSignIn.signIn();
    }

    if (await auth.currentUser() == null) {
      GoogleSignInAuthentication credentials =
          await googleSignIn.currentUser.authentication;
      await auth.signInWithCredential(GoogleAuthProvider.getCredential(
          idToken: credentials.idToken, accessToken: credentials.accessToken));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: <Widget>[
            TextFormField(),
            TextFormField(),
            RaisedButton(
              onPressed: () async {
                await _ensureLoggeIn();
              },
              child: Text("Login"),
            ),
          ],
        ),
      ),
    );
  }
}
