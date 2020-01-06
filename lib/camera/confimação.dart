import 'package:flutter/material.dart';

class Confirmar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: Container(
          color: Colors.blue,
          child: Container(
            child: Center(
                child: Text(
              "Thanks!",
              style: TextStyle(color: Colors.white, fontSize: 40),
            )),
          ),
        ));
  }
}
