import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:firebaseflutter/camera/widget.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart';

import 'confimação.dart';
import 'foto.dart';

bool test = false;

// A screen that allows users to take a picture using a given camera.
class TakePictureScreen extends StatefulWidget {
  final CameraDescription camera;

  const TakePictureScreen({
    Key key,
    @required this.camera,
  }) : super(key: key);

  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}

class TakePictureScreenState extends State<TakePictureScreen> {
  CameraController _controller;
  Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    // To display the current output from the Camera,
    // create a CameraController.
    _controller = CameraController(
      // Get a specific camera from the list of available cameras.
      widget.camera,
      // Define the resolution to use.
      ResolutionPreset.medium,
      enableAudio: false,
    );

    // Next, initialize the controller. This returns a Future.
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Foto(),
                    ),
                  );
                }),
          ),
          // Wait until the controller is initialized before displaying the
          // camera preview. Use a FutureBuilder to display a loading spinner
          // until the controller has finished initializing.
          body: SafeArea(
            child: FutureBuilder<void>(
              future: _initializeControllerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  // If the Future is complete, display the preview.
                  return CameraPreview(_controller);
                } else {
                  // Otherwise, display a loading indicator.
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.camera_alt),
            // Provide an onPressed callback.
            onPressed: () async {
              // Take the Picture in a try / catch block. If anything goes wrong,
              // catch the error.
              try {
                // Ensure that the camera is initialized.
                await _initializeControllerFuture;

                // Construct the path where the image should be saved using the
                // pattern package.
                final path = join(
                  // Store the picture in the temp directory.
                  // Find the temp directory using the `path_provider` plugin.
                  (await getTemporaryDirectory()).path,
                  '${DateTime.now()}.png',
                );

                // Attempt to take a picture and log where it's been saved.
                await _controller.takePicture(path);

                // If the picture was taken, display it on a new screen.
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DisplayPictureScreen(imagePath: path),
                  ),
                );
              } catch (e) {
                // If an error occurs, log the error to the console.
                print(e);
              }
            },
          ),
        ));
  }
}

// A widget that displays the picture taken by the user.
class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;

  const DisplayPictureScreen({Key key, this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    getCamera() async {
      final cameras = await availableCameras();

      // Get a specific camera from the list of available cameras.
      final firstCamera = cameras.first;
      return firstCamera;
    }

    return WillPopScope(
        onWillPop: () async => false,
        child: SafeArea(
          child: Scaffold(
            // The image is stored as a file on the device. Use the `Image.file`
            // constructor with the given path to display the image.
            body: Container(
              color: Colors.lightBlue,
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Card(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    SizedBox(height: 10,),
                    Text(
                      'Frente do seu Documento',
                      style: TextStyle(color: Colors.black),
                    ),
                    Container(
                      color: Colors.white,
                      alignment: Alignment.center,
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.6,
                        width: MediaQuery.of(context).size.width * 0.8,
                        padding: const EdgeInsets.all(8.0),
                        color: Colors.red,
                        child: Image.file(
                          File(imagePath),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.15,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.white,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          ButtomB(
                            title: "Tentar novamente",
                            eventFunc: () async {
                              // If the picture was taken, display it on a new screen.
                              final camera = await getCamera();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      TakePictureScreen(camera: camera),
                                ),
                              );
                            },
                          ),
                          ButtomB(
                            title: "Continuar",
                            eventFunc: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Confirmar(),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
