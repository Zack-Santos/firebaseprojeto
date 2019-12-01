import 'package:firebaseflutter/faqmanipulation.dart';
import 'package:flutter/material.dart';

class AddPergunta extends StatefulWidget {
  @override
  _AddPerguntaState createState() => _AddPerguntaState();
}

class _AddPerguntaState extends State<AddPergunta> {
  TextEditingController perguntaController = TextEditingController();
  TextEditingController respostaController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  //Snackbar
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  _showSnackBar(String text) {
    final snackBar = SnackBar(
      elevation: 10,
      content: Text(text, style: TextStyle(fontSize: 18)),
      duration: Duration(seconds: 5),
      backgroundColor: Colors.green,
    );
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  ///Snackbar

  String text = "";
  FaqManipulation faqManipulation = FaqManipulation();

  @override
  Widget build(BuildContext context) {
    //Mesnsages de confirmações

    return Scaffold(
      backgroundColor: Colors.white,
      key: _scaffoldKey,
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
                    _showSnackBar("Removido com sucesso!");
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
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                     TextFormField(
                controller: perguntaController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Campo não pode ser vazio';
                  }
                  return null;
                },
              ),
            
             TextFormField(
                controller: respostaController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Campo não pode ser vazio';
                  }
                  return null;
                },
              ),
          
                ],
              )
              
           
          
            ),

          
           RaisedButton(
              color: Colors.orange,
              onPressed: () async {
                if (_formKey.currentState.validate() == true){
                     await faqManipulation.addQuestion(
                  query: perguntaController.text,
                  answer: respostaController.text,
                );

                _showSnackBar("Adicionada com sucesso!");

                Future.delayed(Duration(seconds: 2), () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                });
                }else{
                  return null;
                }

               
              },
              child: Text("adicionar"),
            )
          ],
        ),
      ),
    );
  }
}
