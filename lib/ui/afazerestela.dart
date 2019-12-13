import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebaseflutter/modelo/afazer.dart';
import 'package:firebaseflutter/util/db_ajudante.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class AfazeresTela extends StatefulWidget {
  @override
  _AfazeresTelaState createState() => _AfazeresTelaState();
}

class _AfazeresTelaState extends State<AfazeresTela> {
  final TextEditingController _controller = TextEditingController();

  var db = DBAjudante();

  final List<Afazer> _afazerlista = <Afazer>[];

  @override
  void initState() {
    super.initState();

    _pegarAfazerres();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: Column(
        children: <Widget>[
          Flexible(
            child: ListView.builder(
              itemCount: _afazerlista.length,
              padding: EdgeInsets.all(8),
              itemBuilder: (_, int posicao) {
                return Card(
                  color: Colors.white10,
                  child: ListTile(
                    title: _afazerlista[posicao],
                    onLongPress: () =>
                        _atualizarAfazer(_afazerlista[posicao], posicao),
                    trailing: Listener(
                      key: Key(_afazerlista[posicao].afazerNome),
                      child: Icon(
                        Icons.remove_circle,
                        color: Colors.red,
                      ),
                      onPointerDown: (pointerEvent) =>
                          _apagarafazer(_afazerlista[posicao].id, posicao),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _mostrarFormulario,
        backgroundColor: Colors.red,
        child: ListTile(
          title: Icon(Icons.add),
        ),
      ),
    );
  }

  Future _pegarAfazerres() async {
    List afazeres = await db.recuperarTodosAfazers();

    afazeres.forEach((item) {
      print("xxxxxx = $item");
      setState(() {
        _afazerlista.add(Afazer.map(item));
      });
    });
  }

  void _mostrarFormulario() {
    var alert = AlertDialog(
      content: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: _controller,
              autofocus: true,
              decoration: InputDecoration(
                labelText: "Afazer",
                hintText: "Cozinhar feijão",
                icon: Icon(Icons.note_add),
              ),
            ),
          ),
        ],
      ),
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            _lidarComTexto(_controller.text);
            _controller.clear();
            Navigator.pop(context);
          },
          child: Text("Salvar"),
        ),
      ],
    );

    showDialog(
        context: context,
        builder: (_) {
          return alert;
        });
  }

  Future _lidarComTexto(String text) async {
    _controller.clear();

    Firestore.instance
        .collection("teste")
        .document()
        .setData({"pergunta": text});

    DocumentSnapshot documentSnapshot =
        await Firestore.instance.collection("status").document("status").get();

    int status = int.parse(documentSnapshot.data["status"]) + 1;
    print(">>>>>>>status = $status");

    Firestore.instance
        .collection("status")
        .document("status")
        .updateData({"status": status.toString()});

    QuerySnapshot querySnapshot =
        await Firestore.instance.collection("teste").getDocuments();

    for (var item in querySnapshot.documents) {
      print(item.data["pergunta"]);
    }

    Afazer afazer = Afazer(
      text,
      dataFormatada(),
    );

    int salvoId = await db.salvarAfazer(afazer);

    Afazer itemSalvo = await db.recuperarAfazer(salvoId);

    setState(() {
      _afazerlista.insert(0, itemSalvo);
    });
  }

  String dataFormatada() {
    var agora = DateTime.now();
    initializeDateFormatting("pt_BR", null);
    var formatado = DateFormat.yMMMd("pt_BR");

    return formatado.format(agora);
  }

  _atualizarAfazer(Afazer afazer, int posicao) {
    var alert = AlertDialog(
      title: Text("Atualizar afazer"),
      content: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: _controller,
              autofocus: true,
              decoration: InputDecoration(
                labelText: "Afazer",
                icon: Icon(Icons.update),
              ),
            ),
          ),
        ],
      ),
      actions: <Widget>[
        FlatButton(
          onPressed: () async {
            Afazer atualizaritem = Afazer.fromMap({
              "nome": _controller.text,
              "data": dataFormatada(),
              "id": afazer.id,
            });

            _lidarComAtualizacao(posicao, afazer);

            await db.atualizarAfazer(atualizaritem);
            setState(() {
              _pegarAfazerres();
            });
            Navigator.pop(context);
          },
          child: Text("Atualizar"),
        ),
        FlatButton(
          child: Text("Cancelar"),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
    showDialog(
        context: context,
        builder: (_) {
          return alert;
        });
  }

  _lidarComAtualizacao(int posicao, Afazer afazer) {
    setState(() {
      _afazerlista.removeWhere((elemento) {
        _afazerlista[posicao].afazerNome == afazer.afazerNome;
      });
    });
  }

  _apagarafazer(int id, int posicao) async {
    await db.apagarAfazer(id);

    setState(() {
      _afazerlista.removeAt(posicao);
    });
  }
}
