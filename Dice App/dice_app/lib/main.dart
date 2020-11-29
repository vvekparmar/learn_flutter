import 'dart:math';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.teal,
        body: DicePage(),
      ),
    );
  }
}


class DicePage extends StatefulWidget {
  @override
  _DicePageState createState() => _DicePageState();
}

class _DicePageState extends State<DicePage> {
  int diceNumber = 1;

  void dicee() {
    setState(
          () {
            diceNumber = Random().nextInt(6) + 1;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child:Expanded(
        child: FlatButton(
          onPressed: () {
            dicee();
          },
          child: Image.asset('assets/images/dice$diceNumber.png'),
        ),
      ),
    );
  }
}