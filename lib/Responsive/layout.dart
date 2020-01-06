import 'package:firebaseflutter/Responsive/responsive.dart';
import 'package:flutter/material.dart';

class TestResponsive extends StatefulWidget {
  @override
  _TestResponsiveState createState() => _TestResponsiveState();
}

class _TestResponsiveState extends State<TestResponsive> {
  @override
  Widget build(BuildContext context) {

    double altura = height(context, heightV: 0.5,maxV:300);
    print(altura);
    double largura = width(context, widthV:0.5,);
    double a = MediaQuery.of(context).size.height;
    double l = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(title: Text("Teste responsividade")),
      body: Container(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
                child: Container(
                    color: Colors.blue,
                    height: altura,
                    width: largura,
                    child: Column(
                      children: <Widget>[
                        Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "height: ${altura.truncate()} width:${largura.truncate()}",
                              style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 20,
                                  color: Colors.white),
                                ),
                                Text("Total\nA:${a.truncate()} L:${l.truncate()}",  style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 20,
                                  color: Colors.white))
                          ],
                        )),
                      ],
                    )),
              )
            ]),
      ),
    );
  }
}
