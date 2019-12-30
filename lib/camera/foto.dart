import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import 'camera.dart';

class Foto extends StatelessWidget {
  getCamera() async {
    final cameras = await availableCameras();

    // Get a specific camera from the list of available cameras.
    final firstCamera = cameras.first;
    return firstCamera;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: FlatButton(
          color: Colors.yellow,
          child: Text("Tirar Foto"),
          onPressed: () async {
            final camera = await getCamera();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TakePictureScreen(camera: camera),
              ),
            );
          },
        ),
      ),
    );
  }
}
