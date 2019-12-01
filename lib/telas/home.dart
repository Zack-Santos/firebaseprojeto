import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> _list = [];
  Future getQuestions() async {
    QuerySnapshot snapshot = await Firestore.instance
        .collection("perguntasfrequentes")
        .getDocuments();

    for (var item in snapshot.documents) {
      _list.add(item.data["query"]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: RaisedButton(
          onPressed: () async {
            await getQuestions();
          },
          child: Text("click"),
        ),
      ),
    );
  }
}
