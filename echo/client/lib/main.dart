import 'globals.dart' as globals;
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:client/secondScreen.dart';

void main() {
  

  return runApp(MaterialApp(
    home: Client()
  ));
} 

class Client extends StatefulWidget {
  @override
  _ClientState createState() => _ClientState();
}

class _ClientState extends State<Client> {
  TextEditingController _ip = TextEditingController();
  Icon _ipIcon;

  void connect() async{
      try {
        globals.client = await Socket.connect(_ip.text, 3000);
        print("connesso");

        setState(() {
          _ipIcon = Icon(Icons.done, color: Colors.green);  
        });

        Navigator.push(
          context,
          new MaterialPageRoute(builder: (context) => new Client2()),
        );
      } catch (e) {
        setState(() {
          _ipIcon = Icon(Icons.close, color: Colors.red);  
        });
      }  
  }

  void disconnect() {
    globals.client.destroy();
    setState(() {
      _ipIcon = null;
      _ip.clear();  
    });
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Connessione Server"),
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
            ],
          ),
        ),
      ),
    );
  }
}
