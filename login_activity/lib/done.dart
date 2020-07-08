import 'package:flutter/material.dart';

class Done extends StatefulWidget {
  @override
  _DoneState createState() => _DoneState();
}

class _DoneState extends State<Done> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Done"),
        ),
      ),
    );
  }
}
