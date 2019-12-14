import 'dart:async';

import 'package:http/http.dart' as http;

class CheckConnection {
  StreamController _streamController = StreamController.broadcast();
  Sink get input => _streamController.sink;
  Stream get output => _streamController.stream;

  checkconnection() async {
    bool r = false;
    http.get("https://www.google.com/").then((response) {
      r = true;
    });

    await Future.delayed(Duration(seconds: 2));

    input.add(r);
  }

  void dispose() {
    _streamController.close();
  }
}
