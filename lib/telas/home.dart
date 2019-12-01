import 'package:firebaseflutter/faqmanipulation.dart';
import 'package:firebaseflutter/telas/Faq.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Doc> _list = [];
  FaqManipulation _faqManipulation = FaqManipulation();

  void getDocs() async {
    _list = await _faqManipulation.getAllDocs();

    for (var item in _list) {
      print(item.pergunta);
    }
  }

  @override
  void initState() {
    super.initState();
    getDocs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: RaisedButton(
          onPressed: () async {
            getDocs();
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Faq(_list)));
          },
          child: Text("click"),
        ),
      ),
    );
  }
}
