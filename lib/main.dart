import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebaseflutter/telas/Faq.dart';
import 'package:flutter/material.dart';

main() async {
  List<String> _list = [];
  QuerySnapshot snapshot =
      await Firestore.instance.collection("perguntasfrequentes").getDocuments();

  for (var item in snapshot.documents) {
    _list.add(item.data["query"]);
  }

  runApp(MaterialApp(
    home: Faq(_list),
  ));
}
