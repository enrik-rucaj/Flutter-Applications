import 'globals.dart' as globals;
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:client/secondScreen.dart';

void main() {
  

  return runApp(MaterialApp(
    //theme: globals.isDark? globals.darkMode : ThemeData.light(),
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
  Icon _userIcon;

  void connect() async{
      try {
        if((globals.userName.text.length < 1) || (globals.userName.text.length > 10)){
          setState(() {
            _userIcon = Icon(Icons.close, color: Colors.red);  
          });
        }
        else{
          setState(() {
            _userIcon = Icon(Icons.done, color: Colors.green);
          });
          globals.client = await Socket.connect(_ip.text, 3000); 
          print("connesso");
          setState(() {
            _ipIcon = Icon(Icons.done, color: Colors.green);  
            globals.client.write(globals.userName.text);
          });

          Navigator.push(
            context,
            new MaterialPageRoute(builder: (context) => Client2()),
          ); 
        }
      } catch (e) {
        setState(() {
          _ipIcon = Icon(Icons.close, color: Colors.red);  
        });
      }  
      
  }

  void disconnect() {
    globals.client.destroy();
    setState(() {
      globals.messaggi.clear();
      globals.mioMessaggio.clear();
      globals.userNames.clear();
      _userIcon = null;
      _ipIcon = null;
      globals.userName.clear();
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
                padding: EdgeInsets.all(10.0),
                child: TextField(
                  controller: globals.userName,
                  decoration: InputDecoration(
                    icon: Icon(Icons.supervised_user_circle, 
                      color: Colors.purple[800],
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0)
                    ),
                    labelText: "Insert UserName",
                    labelStyle: TextStyle(
                      fontSize: 12.0,
                      color: Colors.purple[600]
                    ),
                    suffixIcon: _userIcon,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  controller: _ip,
                  decoration: InputDecoration(
                    icon: Icon(Icons.cast_connected, 
                      color: Colors.purple[800],
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0)
                    ),
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
