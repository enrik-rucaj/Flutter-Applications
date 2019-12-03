import 'globals.dart' as globals;
import 'package:flutter/material.dart';
import 'dart:convert' show utf8;

class Client2 extends StatefulWidget {
  @override
  _Client2State createState() => _Client2State();
}

class _Client2State extends State<Client2> {
  TextEditingController _text  = TextEditingController();
  String _userName;
  String _testo;
  bool _isUserName = true;

  @override
  void initState() {
    super.initState();
    globals.client.listen((data){
      setState(() {
        if(_isUserName){
          _userName = utf8.decode(data);
          _isUserName = false;
        }
        else{
          _testo = utf8.decode(data);
          globals.messaggi.insert(0, _testo); 
          globals.userNames.insert(0, _userName);
          globals.mioMessaggio.insert(0, false);
          _isUserName = true;
        }
      });
    });
  }

  void send() {
    globals.client.write(_text.text);
    setState(() {
      globals.messaggi.insert(0, _text.text); 
      globals.userNames.insert(0, globals.userName.text);
      globals.mioMessaggio.insert(0, true); 
      _text.clear();
    });
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
                  else {
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
                    ),
                  ),
                ),
                FloatingActionButton(
                  onPressed: send,
                  child: Icon(Icons.send),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
 
}
