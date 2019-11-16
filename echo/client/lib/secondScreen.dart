import 'globals.dart' as globals;
import 'package:flutter/material.dart';

class Client2 extends StatefulWidget {
  @override
  _Client2State createState() => _Client2State();
}

class _Client2State extends State<Client2> {
  TextEditingController _text  = TextEditingController();
  String _testo = "";

  void send() {
    globals.client.write(_text.text);
    globals.client.listen((data){
      setState(() {
        _testo = String.fromCharCodes(data).trim();
        print(_testo);  
      });
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
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
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
              Container(
                width: 350.0,
                height: 80.0,
                margin: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.green),
                  color: Colors.grey[700],
                ),
                child: Center(
                  child: Text("$_testo",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
 
}
