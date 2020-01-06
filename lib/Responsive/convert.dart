import 'package:flutter/material.dart';
import 'package:firebaseflutter/Responsive/responsive.dart';

class Convert extends StatefulWidget {
  @override
  _ConvertState createState() => _ConvertState();
}

class _ConvertState extends State<Convert> {
  @override
  Widget build(BuildContext context) {

   double convert() {

      double v = 55; //enter value;
      double t = 0, i;

      for (i = 0; t.round() != v; i = i + 0.001) 
        t = height(context, heightV: i);

     return i;
    }

    return Scaffold(
        appBar: AppBar(
          title: Text("Convert Fixo/Responsivo"),
        ),
        body: Container(
            child: Center(
          child: FlatButton(
            child: Text("click here!"),
            onPressed: () {
              convert();
            },
          ),
        )));
  }
}
