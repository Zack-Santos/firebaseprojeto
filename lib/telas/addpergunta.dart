import 'package:firebaseflutter/faqmanipulation.dart';
import 'package:flutter/material.dart';

class AddPergunta extends StatefulWidget {
  @override
  _AddPerguntaState createState() => _AddPerguntaState();
}

class _AddPerguntaState extends State<AddPergunta> {
  TextEditingController perguntaController = TextEditingController();
  TextEditingController respostaController = TextEditingController();

  List<Doc> listdoc = [];

  FaqManipulation faqManipulation = FaqManipulation();

  pegarDocs() async {
    listdoc = await faqManipulation.getAllDocs();
    for (var item in listdoc) {
      print(item.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    pegarDocs();
    return Scaffold(
      backgroundColor: Colors.white,
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
              onPressed: () async {
                await faqManipulation.addQuestion(
                  query: perguntaController.text,
                  answer: respostaController.text,
                );
              },
              child: Text("adicionar"),
            )
          ],
        ),
      ),
    );
  }
}
