import 'globals.dart' as globals;
import 'package:flutter/material.dart';
import 'dart:convert' show utf8;

class Client2 extends StatefulWidget {
  @override
  _Client2State createState() => _Client2State();
}

class _Client2State extends State<Client2> {
  TextEditingController _text  = TextEditingController();
  String _testo;

  @override
  void initState() {
    super.initState();
    globals.client.listen((data){
      setState(() {
        //_testo = String.fromCharCodes(data).trim();
        _testo = utf8.decode(data);
        globals.messaggi.insert(0, _testo); 
        globals.mioMessaggio.insert(0, false);
      });
    });
  }

  void send() {
    print(utf8.encode(_text.text));
    print(utf8.decode(utf8.encode(_text.text)));
    globals.client.write(_text.text);
    setState(() {
      globals.messaggi.insert(0, _text.text); 
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
      body: Center(
        child: Column(
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
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              SizedBox(width: 60,),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Text(globals.messaggi[index],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 5,)
                        ],
                      );
                    }
                    else {
                      return Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Text(globals.messaggi[index]),
                                  ],
                                ),
                              ),
                              SizedBox(width: 60,),
                            ],
                          ),
                          SizedBox(height: 5,)
                        ],
                      );
                    }
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                controller: _text,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  icon: Icon(Icons.computer, 
                    color: Colors.purple[800],
                  ),
                  labelText: "Write Text",
                  labelStyle: TextStyle(
                    fontSize: 12.0,
                    color: Colors.purple[600]
                  ),
                ),
              ),
            ),
            RaisedButton(
              onPressed: send,
              child: Text("Send"),
            ),
          ],
        ),
      ),
    );
  }
 
}
