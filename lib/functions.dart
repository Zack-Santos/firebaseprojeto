import 'package:cloud_firestore/cloud_firestore.dart';

Future adicionar(String resposta, String pergunta) async {
  await Firestore.instance
      .collection("perguntasfrequentes")
      .document()
      .setData({"answer": resposta, "query": pergunta, "category": "câncer"});
}
