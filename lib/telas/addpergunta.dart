import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebaseflutter/faqmanipulation.dart';
import 'package:firebaseflutter/telas/Faq.dart';
import 'package:flutter/foundation.dart';
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
    //Mesnsages de confirmações
    void _modalAvisos(context, String text) {
      showModalBottomSheet(
          context: context,
          builder: (BuildContext bc) {
            return Container(
              color: Colors.green,
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                    leading: new Icon(
                      Icons.check,
                    ),
                    title: Text(text),
                  ),
                ],
              ),
            );
          });
    }

    pegarDocs();

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            AppBar(
              actions: <Widget>[
                IconButton(
                  color: Colors.black,
                  iconSize: 40,
                  icon: Icon(
                    Icons.restore_from_trash,
                  ),
                  onPressed: () {
                    _modalAvisos(context,"Removido com sucesso!");
                    //  Navigator.push(context,
                    //  MaterialPageRoute(builder: (context) => Faq()));
                  
                  }, //passar função apagar
                )
              ],
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back_ios),
                iconSize: 20.0,
                color: Colors.black,
                // onPressed: eventFunc,
              ),
              elevation: 0,
              backgroundColor: Colors.transparent,
            ),
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
                _modalAvisos(context, "Adicionada com sucesso!");
              },
              child: Text("adicionar"),
            )
          ],
        ),
      ),
    );
  }
}
