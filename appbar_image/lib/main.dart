import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.redAccent,
          centerTitle: true,
          leading: Icon(Icons.account_circle,size:35),
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 30, 0),
              child: Icon(Icons.mail, size: 33),
            )
          ],
          title: TextField(
            autocorrect: true,
            cursorColor: Colors.black,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search),
              hintText: "Search....",
              filled: true,
              fillColor: Colors.white,
              suffixIcon: Icon(Icons.tune),
            ),
          ),
        ),
        body: Center(
          child: Image.network('https://picsum.photos/250?image=9')
        ),
      ),
    );
  }
}