import 'dart:io';
import 'package:flutter/material.dart';

void main() => runApp(Client());

class Client extends StatefulWidget {
  @override
  _ClientState createState() => _ClientState();
}

class _ClientState extends State<Client> {
  Socket _client;
  TextEditingController _ip = TextEditingController();
  TextEditingController _text  = TextEditingController();
  Icon _ipIcon;
  String _testo = "";

  void connect() async{
      try {
        _client = await Socket.connect(_ip.text, 3000);
        print("connesso");

        setState(() {
          _ipIcon = Icon(Icons.done, color: Colors.green);  
        });
      } catch (e) {
        setState(() {
          _ipIcon = Icon(Icons.close, color: Colors.red);  
        });
      }  
  }

  void send() {
    _client.write(_text.text);
    _client.listen((data){
      setState(() {
        _testo = String.fromCharCodes(data).trim();
        print(_testo);  
      });
    });
  }

  void disconnect() {
    _client.destroy();
    setState(() {
      _ipIcon = null;
      _ip.clear();  
      _text.clear();
      _testo = "";
    });
    
  }

  
  bool isDark = false;
  ThemeData darkMode = ThemeData(
    brightness: Brightness.dark,
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: isDark? darkMode : ThemeData.light(),
      home: MyHomePage(),
    );
  }
  
  
  Widget MyHomePage() {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text("Client"),
            IconButton(
              icon: Icon(Icons.lightbulb_outline),
              onPressed: () {
                setState(() {
                  if(isDark == false)
                    isDark = true;
                  else
                    isDark = false;
                });
              },
            )
          ],
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                controller: _ip,
                decoration: InputDecoration(
                  icon: Icon(Icons.computer, 
                    color: Colors.purple[800],
                  ),
                  border: OutlineInputBorder(),
                  labelText: "Insert IP",
                  labelStyle: TextStyle(
                    fontSize: 12.0,
                    color: Colors.purple[600]
                  ),
                  suffixIcon: _ipIcon
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                  onPressed: connect,
                  child: Text("Connect"),
                ),
                SizedBox(width: 10.0,),
                RaisedButton(
                  onPressed: disconnect,
                  child: Text("Disconnect"),
                ),
              ],
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
            Container(
              margin: EdgeInsets.all(10.0),
              padding: EdgeInsets.fromLTRB(100.0, 3.0, 100.0, 3.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.green),
                color: Colors.grey[700],
              ),
              child: Text("$_testo",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
