import 'package:flutter/material.dart';
import 'dart:async';
import '../bloc/bloc.dart';

class FirstScreen extends StatefulWidget {
  TestBloc bloc;

  FirstScreen(this.bloc);
  
  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  List<ItemModel> items;
  List<ItemModel> items2;
  int score;
  bool gameOver;
  StreamSubscription _subscription;
  String _tempo;
  
  @override
  void initState() {
    super.initState();
    initGame();
    _subscription = incrementa().listen((value){
      int centisecondi = (((value/100) - (value/100).truncate())*100).truncate();
      int secondi = ((value / 100)%60).truncate();
      int minuti = (((value / 100)/60)%60).truncate();

      setState(() {
        _tempo = '$minuti:$secondi:$centisecondi';  
      });
    });
  }

  initGame() {
    gameOver = false;
    score = 0;
    items = [
      ItemModel(icon: Image(image: AssetImage('icons/pear.png'), width: 50, height: 50,), name: "Pear", value: "pear", color: Colors.green),
      ItemModel(icon: Image(image: AssetImage('icons/blueberry.png'), width: 50, height: 50,), name: "Blueberry", value: "blueberry", color: Colors.indigo[800]),
      ItemModel(icon: Image(image: AssetImage('icons/coconut.png'), width: 50, height: 50,), name: "Coconut", value: "coconut", color: Colors.brown),
      ItemModel(icon: Image(image: AssetImage('icons/lemon.png'), width: 50, height: 50,), name: "Lemon", value: "lemon", color: Colors.yellow[700]),
      ItemModel(icon: Image(image: AssetImage('icons/strawberry.png'), width: 50, height: 50,), name: "Strawberry", value: "strawberry", color: Colors.red[800]),
    ];
    items2 = List<ItemModel>.from(items);
    items.shuffle();
    items2.shuffle();
  }
  
  int transform(int x) => x+1;
  
  Stream<int> incrementa() async*{
    yield* Stream.periodic(Duration(milliseconds: 10), transform);
  }

  @override
  Widget build(BuildContext context) {
    if(items.length == 0){
      gameOver = true;
      _subscription.pause();
    }
    
    return Center(
      child: Column(
        children: <Widget>[
          Text.rich(TextSpan(
            children: [
              TextSpan(text: "Score: " , style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30.0
              )),
              TextSpan(text: "$score", style: TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
                fontSize: 30.0
              ))
            ]
          )),
          Text.rich(TextSpan(
            children: [
              TextSpan(text: "Time: ", style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30.0
              )),
              TextSpan(text: _tempo, style: TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
                fontSize: 30.0
              ))
            ]
          )),
          if(!gameOver)
          Row(
            children: <Widget>[
              Column(
                children: items.map((item){
                  return Container(
                    margin: const EdgeInsets.all(8.0),
                    child: Draggable<ItemModel>(
                      data: item,
                      childWhenDragging: SizedBox(),
                      feedback: item.icon,
                      child: item.icon,));
                }).toList()
              ),
              Spacer(),
              Column(
                children: items2.map((item){
                  return DragTarget<ItemModel>(
                    onAccept: (receivedItem) {
                      if(item.value == receivedItem.value) {
                        setState(() {
                          items.remove(receivedItem);
                          items2.remove(item);
                          score+=10;
                          item.accepting = false;
                        });
                      }else{
                        setState(() {
                          score-=5;
                          item.accepting = false;
                        });
                      }
                    },
                    onLeave: (receivedItem) {
                      setState(() {
                        item.accepting = false;
                      });
                    },
                    onWillAccept: (receivedItem) {
                      setState(() {
                        item.accepting = true;
                      });
                      return true;
                    },
                    builder: (context, acceptedItems, rejectedItems) => Container(
                      color: item.accepting ? item.color.withAlpha(120) : item.color,
                      height: 50,
                      width: 100,
                      alignment: Alignment.center,
                      margin: const EdgeInsets.all(8.0),
                      child: Text(item.name, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18.0),)),
                  );
                }).toList()
              ),
            ],
          ),
          if(gameOver)
          SizedBox(height: 200,),
          if(gameOver)
          Text("Next Level", style: TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.bold,
            fontSize: 24.0
          ),),
          if(gameOver)
          RaisedButton(
            textColor: Colors.white,
            color: Colors.pink,
            child: Text("Next Level"),
            onPressed: (){
              widget.bloc.fetchSecondScreen();
            },
          )
        ],
      ),
    );
  }
}

class ItemModel {
  final String name;
  final String value;
  final Image icon;
  final Color color;
  bool accepting;

  ItemModel({this.name, this.value, this.icon, this.color, this.accepting=false});
}