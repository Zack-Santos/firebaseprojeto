import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Teste(),
  ));
}

class Teste extends StatefulWidget {
  @override
  _TesteState createState() => _TesteState();
}

class _TesteState extends State<Teste> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.white,
      body: Center(
        child: RaisedButton(
          onPressed: () async {
            try {
              await Firestore.instance
                  .collection("teste")
                  .add({"teste": "teste25"}).catchError((e) {
                print("+++++++$e");
              });
            } catch (e) {
              print(">>>>>>${e.toString()}");
            }
          },
          child: Text("ADD"),
        ),
      ),
    );
  }
}
