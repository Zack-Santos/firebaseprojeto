import 'package:cloud_firestore/cloud_firestore.dart';

//Classe que contem métodos para manipular o banco de dados do firebase.
class FaqManipulation {
  //método pra adicionar perguntas ao BD do firebase.
  Future addQuestion({String answer, String query}) async {
    await Firestore.instance
        .collection("perguntasfrequentes")
        .document()
        .setData({"answer": answer, "query": query, "category": "câncer"});
  }

  //método que altera um documento específico do BD do firebase.
  Future alterQuestion({String id, String answer, String query}) async {
    await Firestore.instance
        .collection("perguntasfrequentes")
        .document(id)
        .updateData({"answer": answer, "query": query, "category": "câncer"});
  }

  //método para deletar um documento do firebase.
  Future deletQuestion({String id}) async {
    await Firestore.instance
        .collection("perguntasfrequentes")
        .document(id)
        .delete();
  }

  //esse método pega todos os documentos do firebase e armazenna em uma lista de documentos.
  Future<List<Doc>> getAllDocs() async {
    List<Doc> _listdoc = [];
    QuerySnapshot snapshot = await Firestore.instance
        .collection("perguntasfrequentes")
        .getDocuments();

    for (var doc in snapshot.documents) {
      Doc newDoc = Doc(
        id: doc.documentID,
        pergunta: doc.data["query"],
        resposta: doc.data["answer"],
      );
      _listdoc.add(newDoc);
    }

    return _listdoc;
  }
}

//objeto documento retornado no método acima.
class Doc {
  String pergunta;
  String resposta;
  String id;

  Doc({this.id, this.pergunta, this.resposta});
}
