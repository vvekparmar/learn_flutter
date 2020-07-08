import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'main.dart';

void main() => runApp(RegisterPage());

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Abel'),
      home: Scaffold(
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
                      "Register",
                      style: TextStyle(fontSize: 50.0),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Lets get",
                      style: TextStyle(fontSize: 25.0),
                    ),
                    Text(
                      "you on board",
                      style: TextStyle(fontSize: 25.0),
                    ),
                    SizedBox(height: 20),
                    TextField(
                      decoration: InputDecoration(
                        labelText: "Full Name",
                        labelStyle: TextStyle(
                          fontSize: 20,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    TextField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: "Email",
                        labelStyle: TextStyle(
                          fontSize: 20,
                          color: Colors.grey,
                        ),
                      ),
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
                        "Register",
                        style: TextStyle(fontSize: 25, letterSpacing: 2),
                      ),
                      disabledTextColor: Colors.white,
                      disabledColor: Colors.blue,
                    ),
                    SizedBox(height:30),
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
                    SizedBox(height:30),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: RaisedButton(
                            disabledColor : Colors.white,
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
                          ),
                        ),
                        SizedBox(width: 30),
                        Expanded(
                          child: RaisedButton(
                            padding: EdgeInsets.only(right:10),
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
                    SizedBox(height:30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Already have an account?',
                          style: TextStyle(fontSize: 25.0),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
                          },
                          child: Text(
                            ' Sign In',
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
      ),
    );
  }
}
