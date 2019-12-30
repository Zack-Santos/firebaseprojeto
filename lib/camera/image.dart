import 'package:flutter/material.dart';

class Image extends StatefulWidget {
  @override
  _ImageState createState() => _ImageState();
}

class _ImageState extends State<Image> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Frente do seu documento"),
      ),
      body:Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(50),
              
            )
          ],
        ),
      )
    );
  }
}