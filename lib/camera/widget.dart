import 'package:flutter/material.dart';

class ButtomB extends StatelessWidget {
   Function eventFunc;
  String title;
  ButtomB({this.title, this.eventFunc});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.067,
      width: MediaQuery.of(context).size.width * 0.80,
      child: RaisedButton(

        color: Colors.blue,
        onPressed: eventFunc,
        child: Text("$title", textScaleFactor: 0.98),
      ),
    );
  }
}
