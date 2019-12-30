import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Tela(),
  ));
}

class Tela extends StatefulWidget {
  @override
  _TelaState createState() => _TelaState();
}

class _TelaState extends State<Tela> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: RaisedButton(
          onPressed: () {},
          child: Text("ADD"),
        ),
      ),
    );
  }
}
