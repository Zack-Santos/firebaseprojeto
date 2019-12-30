import 'package:flutter/material.dart';

class Confirmar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child:
    
    Container(
      color: Colors.white,
      child: Center(child: Text("Deu Certo!", style: TextStyle(color: Colors.black),)),
    ));
  }
}