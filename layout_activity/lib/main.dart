import 'package:flutter/material.dart';

void main() => runApp(MyApp());


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.teal,
        body: SafeArea(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                height: 100.0,
                width: 100.0,
                color: Colors.red
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: 100.0,
                    width: 100.0,
                    color: Colors.yellowAccent
                  ),
                  Container(
                    height: 100.0,
                    width: 100.0,
                    color: Colors.greenAccent
                  ),
                ],
              ),
              //SizedBox(width: 40.0),
              Container(
                height: 100.0,
                width: 100.0,
                color: Colors.blue
              ),
            ],
          ),
        ),
      ),
    );
  }
}