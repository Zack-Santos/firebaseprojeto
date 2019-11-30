import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

Future main() async {
  await Firestore.instance
      .collection("teste")
      .document("teste2")
      .setData({"teste2": "teste2"});

  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "teste",
        ),
        centerTitle: true,
      ),
    );
  }
}
