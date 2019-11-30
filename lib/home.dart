import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController perguntaController = TextEditingController();
  TextEditingController respostaController = TextEditingController();

  Future adicionar() async {
    await Firestore.instance
        .collection("perguntasfrequentes")
        .document()
        .setData({
      "answer": respostaController.text,
      "query": respostaController.text,
      "category": "câncer"
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: perguntaController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            TextField(
              controller: respostaController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            RaisedButton(
              onPressed: adicionar,
              child: Text("adicionar"),
            )
          ],
        ),
      ),
    );
  }
}
