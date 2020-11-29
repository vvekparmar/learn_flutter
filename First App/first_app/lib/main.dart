import 'package:flutter/material.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.teal,
        appBar: AppBar(
          title: Text('Session - 1'),
        ),
        body: Center(
          child: Text(
            "Vivek Parmar",
            style: TextStyle(fontSize: 25),
          ),
        ),
      ),
    );
  }
}