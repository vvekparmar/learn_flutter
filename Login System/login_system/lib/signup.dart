import 'package:flutter/material.dart';
import 'main.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Stack(
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: ClipPath(
                      clipper: SideClipper(),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.2,
                        width: MediaQuery.of(context).size.width * 0.45,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [
                                Colors.lightBlueAccent,
                                Colors.lightBlueAccent
                              ],
                              begin: Alignment.bottomLeft,
                              end: Alignment.topLeft),
                        ),
                      ),
                    ),
                  ),
                  ClipPath(
                    clipper: OvalClipper(),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.3,
                      width: MediaQuery.of(context).size.width * 0.8,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: Colors.white,
                              offset: Offset(5, 5),
                              blurRadius: 1.0,
                              spreadRadius: 1.0)
                        ],
                        gradient: LinearGradient(colors: [
                          Colors.lightBlueAccent,
                          Colors.lightBlueAccent,
                          Colors.blue,
                          Colors.blue
                        ], begin: Alignment.bottomLeft, end: Alignment.topLeft),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(50),
                    child: Text("SIGN UP",
                        style: TextStyle(color: Colors.white, fontSize: 38)),
                  )
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.04),
              Padding(
                padding: EdgeInsets.only(left: 30, right: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextField(
                      decoration: new InputDecoration(
                        prefixIcon: Icon(Icons.mail),
                        border: new OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(30.0),
                          ),
                        ),
                        hintText: "Email Address",
                      ),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      decoration: new InputDecoration(
                        prefixIcon: Icon(Icons.person),
                        border: new OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(30.0),
                          ),
                        ),
                        hintText: "Username",
                      ),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      decoration: new InputDecoration(
                        prefixIcon: Icon(Icons.phone),
                        border: new OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(30.0),
                          ),
                        ),
                        hintText: "Contact No.",
                      ),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      obscureText: true,
                      decoration: new InputDecoration(
                        prefixIcon: Icon(Icons.lock),
                        border: new OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(30.0),
                          ),
                        ),
                        hintText: "Password",
                      ),
                    ),
                    SizedBox(height: 25),
                    Row(
                      children: [
                        Container(
                          height: 55,
                          width: MediaQuery.of(context).size.width*0.37,
                          child: FlatButton(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                            color: Colors.lightBlueAccent,
                            textColor: Colors.white,
                            child: Text("SIGN UP",style: TextStyle(fontWeight:FontWeight.bold,fontSize: 20)),
                            onPressed: (){},
                          ),
                        ),
                        SizedBox(width: 22),
                        CircleAvatar(backgroundImage:AssetImage('assets/images/google.jpg'),radius:28),
                        SizedBox(width: 22),
                        CircleAvatar(backgroundImage:AssetImage('assets/images/facebook.jpg'),radius:28),
                      ],
                    ),
                    SizedBox(height:25),
                    GestureDetector(
                      child: Text(
                        "Account Already Existed! Login",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.blueAccent, fontSize: 18),
                      ),
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                        );
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class SideClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final roundingHeight = size.height * 2 / 5;
    final filledRectangle =
    Rect.fromLTRB(0, 0, size.width, size.height - roundingHeight);
    final roundingRectangle = Rect.fromLTRB(
        0, size.height - roundingHeight * 2, size.width + 5, size.height);

    final path = Path();
    path.addRect(filledRectangle);
    path.arcTo(roundingRectangle, 3.14, -3.14, true);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

class OvalClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = new Path();
    final roundingHeight = size.height * 1;
    final roundingRectangle = Rect.fromLTRB(
        -100, size.height - roundingHeight * 2, size.width, size.height);
    path.arcTo(roundingRectangle, 3.14, -3.14, true);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
