import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'register.dart';
import 'dart:async';
import 'done.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Abel'),
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<String> signInWithGoogle() async {
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final AuthResult authResult = await _auth.signInWithCredential(credential);
    final FirebaseUser user = authResult.user;

    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);

    print('signInWithGoogle succeeded: $user');
    return 'signInWithGoogle succeeded: $user';
  }

  String getEmail,getPassword;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.topRight,
              child: Image.asset('assets/images/background.png'),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 60, 20, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    "Login",
                    style: TextStyle(fontSize: 50.0),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Welcome back,",
                    style: TextStyle(fontSize: 25.0),
                  ),
                  Text(
                    "please login",
                    style: TextStyle(fontSize: 25.0),
                  ),
                  Text(
                    "to your account",
                    style: TextStyle(fontSize: 25.0),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: "Email",
                      labelStyle: TextStyle(
                        fontSize: 20,
                        color: Colors.grey,
                      ),
                    ),
                    onChanged: (value){
                      this.getEmail = value;
                    },
                  ),
                  TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: "Password",
                      labelStyle: TextStyle(
                        fontSize: 20,
                        color: Colors.grey,
                      ),
                    ),
                    onChanged: (value){
                      this.getPassword = value;
                    },
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "Forward Password?",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  FlatButton(
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    child: Text(
                      "Login",
                      style: TextStyle(fontSize: 25, letterSpacing: 2),
                    ),
                    textColor: Colors.white,
                    color: Colors.blue,
                    onPressed: (){
                      Map userData = {'userEmail':this.getEmail, 'password':this.getPassword};
                      Firestore.instance.collection('userInformation').add(userData).catchError((e){
                        print(e);
                      });
                    },
                  ),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: Container(
                          height: 1.0,
                          width: 60.0,
                          color: Colors.black87,
                        ),
                      ),
                      Text(
                        'or',
                        style: TextStyle(fontSize: 25.0),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: Container(
                          height: 1.0,
                          width: 60.0,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: RaisedButton(
                          color: Colors.white,
                          shape: ContinuousRectangleBorder(
                            side: BorderSide(width: 1.5, color: Colors.grey),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset('assets/images/google.png',
                                  fit: BoxFit.contain,
                                  width: 40.0,
                                  height: 40.0),
                              Text(
                                'Google',
                                style: TextStyle(
                                    fontSize: 25.0, color: Colors.black),
                              ),
                            ],
                          ),
                          onPressed: () {
                            signInWithGoogle().whenComplete(() {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) {
                                    return Done();
                                  },
                                ),
                              );
                            });
                          },
                        ),
                      ),
                      SizedBox(width: 30),
                      Expanded(
                        child: RaisedButton(
                          padding: EdgeInsets.only(right: 10),
                          disabledColor: Colors.white,
                          shape: ContinuousRectangleBorder(
                            side: BorderSide(width: 1.5, color: Colors.grey),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset('assets/images/facebook.png',
                                  fit: BoxFit.contain,
                                  width: 40.0,
                                  height: 40.0),
                              Text(
                                'Facebook',
                                style: TextStyle(
                                    fontSize: 25.0, color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Don\'t have an account?',
                        style: TextStyle(fontSize: 25.0),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RegisterPage()));
                        },
                        child: Text(
                          ' Sign Up',
                          style: TextStyle(fontSize: 25.0, color: Colors.blue),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
