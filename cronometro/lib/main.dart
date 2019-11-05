import 'dart:async';

import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
  home: Cronometro(),
));

class Cronometro extends StatefulWidget {
  @override
  _CronometroState createState() => _CronometroState();
}
class _CronometroState extends State<Cronometro> {
  StreamSubscription _subscription;
  
  List<String> _stringSegnalibro = [];
  IconData _bottoneSinistro = Icons.play_arrow;
  Color _coloreBookmarkButton = Colors.grey[700];
  String _writeTempo = '00:00';
  bool _cronometroAttivo = false;
  bool _inPausa = false;

  int transform(int x) => x+1;
  
  Stream<int> incrementa() async*{
    _cronometroAttivo = true;
    _coloreBookmarkButton = Colors.red[900];
    yield* Stream.periodic(Duration(seconds: 1), transform);
  }

  void cambiaIcona() {
    _bottoneSinistro = Icons.pause;
  }

  void pausaCronometro() {
    _subscription.pause();
    _bottoneSinistro = Icons.play_arrow;
    _inPausa = true;
  }

  void riprendiCronometro() {
    _subscription.resume();
    _bottoneSinistro = Icons.pause;
    _inPausa = false;
  }

  void reset() {
    _subscription.cancel();
    _writeTempo = '00:00';
    _stringSegnalibro.clear();
    _bottoneSinistro = Icons.play_arrow;
    _cronometroAttivo = false;
    _coloreBookmarkButton = Colors.grey[700];
    _inPausa = false;
  }

  void segnalibro() {
    _stringSegnalibro.add(_writeTempo);
  }

  @override
  Widget build(BuildContext contet) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        backgroundColor: Colors.grey[850],
        title: Text('La mia App'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 90.0),
            CircleAvatar(
              backgroundColor: Colors.blueGrey[600],
              foregroundColor: Colors.black,
              radius: 100.0,
              child: Text(_writeTempo,
                textScaleFactor: 3.0,
              ),
            ),
            SizedBox(height: 30.0),
            Expanded(
              child: ListView.builder (
                itemCount: _stringSegnalibro.length,
                itemBuilder: (BuildContext context, int index) {
                  return new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.bookmark,
                        color: Colors.white54,
                      ),
                      Text(_stringSegnalibro[index],
                        textScaleFactor: 1.8,
                        style: TextStyle(
                          color: Colors.white54,
                        ),
                      )
                    ],
                  ); 
                },            
              ),
            ),
            SizedBox(height: 80.0),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          FloatingActionButton(
            onPressed: () async{
              if(_cronometroAttivo == false){
                setState(cambiaIcona); //per prevenire ritardo di 1 sec nel cambio dell'icona.
                _subscription = incrementa().listen((value){
                  setState(() {
                    int minuti = (value / 60).truncate();
                    int secondi = value % 60;

                    if(minuti < 10 && secondi < 10)
                      _writeTempo = '0$minuti:0$secondi';
                    if(minuti < 10 && secondi >= 10)
                      _writeTempo = '0$minuti:$secondi';
                    if(minuti >= 10 && secondi <10)
                      _writeTempo = '$minuti:0$secondi';
                    if(minuti >= 10 && secondi >= 10)
                      _writeTempo = '$minuti:$secondi';
                  });
                });
              }
              else {
                if(_inPausa == false){
                  setState(pausaCronometro);
                }
                else{
                  setState(riprendiCronometro);
                }
              } 
            },
            backgroundColor: Colors.red[900],
            child: Icon(_bottoneSinistro,
              color: Colors.brown[900],
              size: 40.0,
            ),
          ),
          FloatingActionButton(
            onPressed: () {
              if(_cronometroAttivo == false)
                setState(null);
              else{
                setState(segnalibro);
              }
            },
            backgroundColor: _coloreBookmarkButton,
            child: Icon(Icons.bookmark,
              color: Colors.brown[900],
              size: 31.0,
            ),
          ),
          FloatingActionButton(
            onPressed: () {
              setState(reset);
            },
            backgroundColor: Colors.red[900],
            child: Icon(Icons.delete,
              color: Colors.brown[900],
              size: 30.0,
            ),
          )
        ],
      ),
    );
  }
}

