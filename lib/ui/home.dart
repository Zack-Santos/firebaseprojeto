import 'package:firebaseflutter/ui/afazerestela.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Afazeres"),
        centerTitle: true,
        backgroundColor: Colors.black54,
      ),
      body: AfazeresTela(),
    );
  }
}
