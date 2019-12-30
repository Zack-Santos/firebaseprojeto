import 'package:firebaseflutter/checkConnection/checkconnection.dart';
import 'package:flutter/material.dart';

class Tela extends StatefulWidget {
  @override
  _TelaState createState() => _TelaState();
}

class _TelaState extends State<Tela> {
  CheckConnection checkConnection = CheckConnection();
  bool conect = false;
  bool buttum = false;
  TextEditingController queryController = TextEditingController();
  TextEditingController answerController = TextEditingController();

  writeFirebase() async {
    setState(() {
      buttum = true;
    });
    conect = await checkConnection.checkconnection();
    conect = await checkConnection.checkconnection();
    if (!conect) {
      setState(() {
        buttum = false;
      });
      print("Verifique sua conexão");
    } else {
      setState(() {
        buttum = false;
      });
      print("Adicionado com sucesso");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            children: <Widget>[
              TextField(
                controller: queryController,
              ),
              TextField(
                controller: answerController,
              ),
              Divider(),
              buttum
                  ? CircularProgressIndicator()
                  : Container(
                      width: double.infinity,
                      height: 50,
                      child: RaisedButton(
                        color: Colors.red,
                        onPressed: writeFirebase,
                        child: Text("ADD"),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
