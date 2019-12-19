import 'package:image/image.dart' as img;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:camera/camera.dart';

import 'globals.dart' as globals;
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';

String path;

class Client2 extends StatefulWidget {
  @override
  _Client2State createState() => _Client2State();
}

class _Client2State extends State<Client2> {
  TextEditingController _text  = TextEditingController();
  String _userName;
  String _testo;
  bool _isUserName = true;
  //bool _isImage = false;
  var _buffer;

  @override
  void initState() {
    super.initState();
    globals.client.listen((data){
      setState(() {
        if(_isUserName){
          try {
            _userName = utf8.decode(data);
            _isUserName = false;
          } catch (e) {
            print("lol non dovevi entrare!!!!!");
            //_buffer += data;
          }
        }
        else{
          try {
            _testo = utf8.decode(data);
            if(_testo == "3nd1m4g3"){
              img.Image image = img.decodeImage(_buffer);
              globals.messaggi.insert(0, img.encodePng(image)); 
              globals.userNames.insert(0, _userName);
              globals.mioMessaggio.insert(0, false);
              globals.isImage.insert(0, true);
              _isUserName = true;
              _buffer = null;
            }
            else{
              globals.messaggi.insert(0, _testo); 
              globals.userNames.insert(0, _userName);
              globals.mioMessaggio.insert(0, false);
              globals.isImage.insert(0, false);
              _isUserName = true;
            }
          }catch (e) {
            _buffer += data;
          }
        }
      });
    });
  }

  void send() {
    globals.client.write("${_text.text} ");
    setState(() {
      globals.messaggi.insert(0, _text.text); 
      globals.userNames.insert(0, globals.userName.text);
      globals.mioMessaggio.insert(0, true); 
      globals.isImage.insert(0, false);
      _text.clear();
    });
  }

  void sendImage() async {
    var dati = File(path).readAsBytesSync();
    img.Image image = img.decodeImage(dati);

    //inizioDatiFoto();
    await inviaDatiFoto(image);
    await Future.delayed(Duration(milliseconds: 100));
    fineDatiFoto();
    setState(() {
      globals.messaggi.insert(0, img.encodePng(image)); 
      globals.userNames.insert(0, globals.userName.text);
      globals.mioMessaggio.insert(0, true); 
      globals.isImage.insert(0, true);
    });
  }

  void inizioDatiFoto() {
    globals.client.write("1m4g3");
    print("inviato 1m4g3");
  }
  
  Future<void> inviaDatiFoto(img.Image image) {
    globals.client.add(img.encodePng(image));
    return null;
  }

  void fineDatiFoto() {
    globals.client.write("3nd1m4g3");
    print("inviato 3nd1m4g3");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Client"),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              color: Colors.red,
              child: ListView.builder(
                reverse: true,
                itemCount: globals.messaggi.length,
                itemBuilder: (BuildContext context, int index) {
                  if (globals.mioMessaggio[index] == true) {
                    if (globals.isImage[index] == true){
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Stack(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.fromLTRB(0, 15, 0, 7),
                                margin: EdgeInsets.fromLTRB(60, 5, 5, 5),
                                decoration: BoxDecoration(
                                  color: Colors.greenAccent,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(5.0),
                                    bottomLeft: Radius.circular(5.0),
                                    bottomRight: Radius.circular(10.0),
                                  )
                                ),
                                child: Image.memory(globals.messaggi[index], height: 200, width: 180,)
                              ),
                              Positioned(
                                top: 5.0,
                                left: 62.0,
                                child: Text(globals.userNames[index],
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.blueGrey,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    }
                    else{
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Stack(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.fromLTRB(97, 15, 10, 7),
                                margin: EdgeInsets.fromLTRB(60, 5, 5, 5),
                                decoration: BoxDecoration(
                                  color: Colors.greenAccent,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(5.0),
                                    bottomLeft: Radius.circular(5.0),
                                    bottomRight: Radius.circular(10.0),
                                  )
                                ),
                                child: Text(globals.messaggi[index],
                                  textAlign: TextAlign.end,
                                ),
                              ),
                              Positioned(
                                top: 5.0,
                                left: 62.0,
                                child: Text(globals.userNames[index],
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.blueGrey,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    }
                  }
                  else {
                    if (globals.isImage[index] == true){
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Stack(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.fromLTRB(0, 15, 0, 7),
                                margin: EdgeInsets.fromLTRB(60, 5, 5, 5),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(5.0),
                                    bottomLeft: Radius.circular(5.0),
                                    bottomRight: Radius.circular(10.0),
                                  )
                                ),
                                child: Image.memory(globals.messaggi[index], height: 200, width: 180,)
                              ),
                              Positioned(
                                top: 5.0,
                                left: 62.0,
                                child: Text(globals.userNames[index],
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.blueGrey,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    }
                    else{
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Stack(
                            children:<Widget>[
                                Container(
                                padding: EdgeInsets.fromLTRB(97, 15, 10, 7),
                                margin: EdgeInsets.fromLTRB(5, 5, 60, 5),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(5.0),
                                    bottomLeft: Radius.circular(10.0),
                                    bottomRight: Radius.circular(5.0),
                                  )
                                ),
                                child: Text(globals.messaggi[index],
                                  textAlign: TextAlign.end,
                                ),
                              ),
                              Positioned(
                                top: 5.0,
                                left: 6.0,
                                child: Text("${globals.userNames[index]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.blueGrey,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    }
                  }
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _text,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      labelText: "Write Text",
                      labelStyle: TextStyle(
                        fontSize: 12.0,
                        color: Colors.purple[600]
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.photo_camera),
                        onPressed: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => TakePicture()),
                          );
                          sendImage();
                        },  
                      ),
                    ),
                  ),
                ),
                FloatingActionButton(
                  onPressed: send,
                  child: Icon(Icons.send),
                  mini: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TakePicture extends StatefulWidget {
  @override
  _TakePictureState createState() => _TakePictureState();
}

class _TakePictureState extends State<TakePicture> {
  CameraController _controller;
  Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(globals.camera, ResolutionPreset.medium);
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Take a picture')),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return CameraPreview(_controller);
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        shape: CircleBorder(
          side: BorderSide(
            color: Colors.grey,
            width: 3,
          )
        ),
        onPressed: () async {
          try {
            await _initializeControllerFuture;
            path = join(
              (await getTemporaryDirectory()).path,
              '${DateTime.now()}.png',
            );
            print(path);
            await _controller.takePicture(path);
            Navigator.pop(context);
          } catch (e) {
            print(e);
          }
        },
      ),
    );
  }
}

class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;

  const DisplayPictureScreen({Key key, this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Display the Picture')),
      body: ListView.builder(
        reverse: true,
        itemCount: globals.messaggi.length,
        itemBuilder: (BuildContext context, int index) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Container(
                color: Colors.red,
                height: 150,
                width: 200,
                child: Image.file(File(imagePath))
              ),
            ],
          );
        }
      ),
    );
  }
}
