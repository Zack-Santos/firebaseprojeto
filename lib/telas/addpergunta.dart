import 'package:firebaseflutter/functions.dart';
import 'package:flutter/material.dart';

class AddPergunta extends StatefulWidget {
  @override
  _AddPerguntaState createState() => _AddPerguntaState();
}

class _AddPerguntaState extends State<AddPergunta> {
  TextEditingController perguntaController = TextEditingController();
  TextEditingController respostaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                await adicionar(
                    respostaController.text, respostaController.text);
              },
              child: Text("adicionar"),
            )
          ],
        ),
      ),
    );
  }
}
