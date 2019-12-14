import 'package:firebaseflutter/checkConnection/checkconnection.dart';
import 'package:flutter/material.dart';

class CheckConnectionScreen extends StatefulWidget {
  @override
  _CheckConnectionScreenState createState() => _CheckConnectionScreenState();
}

class _CheckConnectionScreenState extends State<CheckConnectionScreen> {
  CheckConnection checkConnection = CheckConnection();

  @override
  void dispose() {
    super.dispose();
    checkConnection.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: StreamBuilder(
          initialData: false,
          stream: checkConnection.output,
          builder: (context, snapshot) {
            checkConnection.checkconnection();
            switch (snapshot.data) {
              case false:
                //caso não tenha conexão retorna esse widget
                return CircularProgressIndicator();
              default:
                //caso tenha conexão retorna esse widget
                return Text(snapshot.data.toString());
            }
          },
        ),
      ),
    );
  }
}
