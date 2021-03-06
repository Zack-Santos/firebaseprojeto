import 'dart:io';

import 'package:firebaseflutter/modelo/afazer.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBAjudante {
  static final DBAjudante _instance = DBAjudante.internal();

  factory DBAjudante() => _instance;

  final String nomeTabela = "afazeresTabela";
  final String colunaId = "id";
  final String afazeresNome = "nome";
  final String afazeresDataCriado = "data";
  final String status = "status";

  static Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }

    _db = await initDb();

    return _db;
  }

  DBAjudante.internal();

  initDb() async {
    Directory documentoDirectorio = await getApplicationDocumentsDirectory();
    String path = join(documentoDirectorio.path, "afazeres_db.db");
    print(">>>>>>path = $path");
    var nossaDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return nossaDb;
  }

  void _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE $nomeTabela(id INTEGER PRIMARY KEY, $afazeresNome TEXT, $afazeresDataCriado TEXT, $status TEXT)");
  }

  Future<int> salvarAfazer(Afazer item) async {
    var dbCliente = await db;
    print(">>>>>>item = ${item.toMap()}");

    int res = await dbCliente.insert("$nomeTabela", item.toMap());
    print(">>>>>res = $res");
    return res;
  }

  Future<List> recuperarTodosAfazers() async {
    var dbCliente = await db;
    var res = await dbCliente
        .rawQuery("SELECT * FROM $nomeTabela ORDER BY $afazeresNome ASC");

    for (var item in res) {
      print("+++++++ = $item");
    }

    return res.toList();
  }

  Future<int> contagem() async {
    var dbCliente = await db;
    return Sqflite.firstIntValue(
        await dbCliente.rawQuery("SELECT COUNT(*) FROM $nomeTabela"));
  }

  Future<Afazer> recuperarAfazer(int id) async {
    var dbCliente = await db;
    var res =
        await dbCliente.rawQuery("SELECT * FROM $nomeTabela WHERE id = $id");

    if (res.length == 0) {
      return null;
    }

    return Afazer.fromMap(res.first);
  }

  Future<int> apagarAfazer(int id) async {
    var dbCliente = await db;
    return await dbCliente
        .delete(nomeTabela, where: "$colunaId = ?", whereArgs: [id]);
  }

  Future<int> atualizarAfazer(Afazer item) async {
    var dbCliente = await db;
    return await dbCliente.update("$nomeTabela", item.toMap(),
        where: "$colunaId = ?", whereArgs: [item.id]);
  }

  Future fechar() async {
    var dbCliente = await db;
    dbCliente.close();
  }
}
