import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.teal,
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundImage: AssetImage('assets/images/natural.jpg'),
                maxRadius: 50,
              ),
              SizedBox(height: 10),
              Text(
                "Vivek Parmar",
                style: TextStyle(fontFamily: 'pacifico', fontSize: 30),
              ),
              Text(
                "Flutter Developer",
                style: TextStyle(fontSize: 18),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(50, 10, 50, 10),
                child: Divider(thickness: 3),
              ),
              Container(
                color: Colors.white24,
                width: 300,
                height: 50,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: Icon(
                        Icons.phone,
                        size: 24.0,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 40),
                      child: Text(
                        "+91 8765445678",
                        style: TextStyle(fontSize: 20),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                color: Colors.white24,
                width: 300,
                height: 50,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: Icon(
                        Icons.mail,
                        size: 24.0,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 40),
                      child: Text(
                        "abcxyz@gmail.com",
                        style: TextStyle(fontSize: 20),
                      ),
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
