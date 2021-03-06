import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebaseflutter/faqmanipulation.dart';
import 'package:flutter/material.dart';

import 'addpergunta.dart';

//Represents the Homepage widget
class Faq extends StatefulWidget {
  List<Doc> _listdocs;
  Faq(this._listdocs);
  //`createState()` will create the mutable state for this widget at
  //a given location in the tree.
  @override
  _FaqState createState() => _FaqState();
}

//Our Home state, the logic and internal state for a StatefulWidget.
class _FaqState extends State<Faq> {
  //A controller for an editable text field.
  //Whenever the user modifies a text field with an associated
  //TextEditingController, the text field updates value and the
  //controller notifies its listeners.
  var _searchview = new TextEditingController();

  bool _firstSearch = true;
  String _query = "";

  List<String> _filterList;
  List<String> _nebulae = [];
  List<String> _perguntas = [];
  List<Doc> _listdocs = [];
  List<NovoDoc> _listmap = [];
  bool veryfi = true;

  //pega as perguntas e armazena em uma lista de Strings.

  //pega todos os documentos e armazena em uma lista de documentos.

  @override
  void initState() {
    super.initState();

    _nebulae = new List<String>();
    _listdocs = widget._listdocs;

    _listdocs.sort((a, b) => a.pergunta.compareTo(b.pergunta));
  }

  _FaqState() {
    //Register a closure to be called when the object changes.
    _searchview.addListener(() {
      if (_searchview.text.isEmpty) {
        //Notify the framework that the internal state of this object has changed.
        setState(() {
          _firstSearch = true;
          _query = "";
        });
      } else {
        setState(() {
          _firstSearch = false;
          _query = _searchview.text;
        });
      }
    });
  }

//Build our Home widget
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Container(
        margin: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
        child: new Column(
          children: <Widget>[
            _createSearchView(),
            _firstSearch ? _createListView() : _performSearch()
          ],
        ),
      ),
    );
  }

  //Create a SearchView
  Widget _createSearchView({double top = 40}) => Row(
        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 4, right: 4, top: top),
              margin: EdgeInsets.only(bottom: 15),
              child: Material(
                elevation: 5,
                child: TextField(
                  controller: _searchview,
                  style: TextStyle(color: Colors.black, fontSize: 18),
                  cursorColor: Colors.green,
                  decoration: InputDecoration(
                    hintText: "Pesquisar pergunta",
                    // hintStyle: MyTextStyles.textInformation,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                    suffixIcon: Material(
                      elevation: 0,
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 4, right: 4, top: top),
            margin: EdgeInsets.only(bottom: 15),
            child: Material(
              elevation: 5,
              child: IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AddPergunta()));
                },
                icon: Icon(Icons.add),
              ),
            ),
          ),
        ],
      );
  // Widget _createSearchView() {
  //   return new Container(
  //     decoration: BoxDecoration(border: Border.all(width: 1.0)),
  //     child: new TextField(
  //       controller: _searchview,
  //       decoration: InputDecoration(
  //         hintText: "Digite sua dúvida",
  //         hintStyle: new TextStyle(color: Colors.grey[300]),
  //       ),
  //       textAlign: TextAlign.center,
  //     ),
  //   );
  // }

  //Create a ListView widget
  Widget _createListView() {
    return new Flexible(
      child: FutureBuilder(
        future:
            Firestore.instance.collection("perguntasfrequentes").getDocuments(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(
                child: CircularProgressIndicator(),
              );

            default:
              if (veryfi) {
                for (int i = 0; i < snapshot.data.documents.length; i++) {
                  _nebulae.add(snapshot.data.documents[i].data["query"]);
                  NovoDoc _novoDoc = NovoDoc(snapshot.data.documents[i].data);
                  _listmap.add(_novoDoc);
                }

                _nebulae.sort();

                veryfi = false;
              }

              return ListView.builder(
                itemCount: _nebulae.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {
                      print(_perguntas[index]);
                    },
                    title: Text(_nebulae[index]),
                  );
                },
              );
          }
        },
      ),
    );
  }

  //Perform actual search
  Widget _performSearch() {
    _filterList = new List<String>();
    for (int i = 0; i < _nebulae.length; i++) {
      var item = _nebulae[i];

      if (item.toLowerCase().contains(_query.toLowerCase())) {
        _filterList.add(item);
      }
    }
    return _createFilteredListView();
  }

  //Create the Filtered ListView
  Widget _createFilteredListView() {
    return new Flexible(
      child: new ListView.builder(
          itemCount: _filterList.length,
          itemBuilder: (BuildContext context, int index) {
            return new Card(
              color: Colors.white,
              elevation: 5.0,
              child: new Container(
                margin: EdgeInsets.all(15.0),
                child: new Text("${_filterList[index]}"),
              ),
            );
          }),
    );
  }
}
