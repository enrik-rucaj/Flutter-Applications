import 'package:flutter/material.dart';
import 'dart:async';
import '../bloc/bloc.dart';

class SecondScreen extends StatefulWidget {
  TestBloc bloc;

  SecondScreen(this.bloc);
  
  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
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
      ItemModel(icon: Image(image: AssetImage('icons/cockroach.png'), width: 30, height: 30,), name: "Cockroach", value: "cockroach", height: 30),
      ItemModel(icon: Image(image: AssetImage('icons/rat.png'), width: 50, height: 50,), name: "Rat", value: "rat", height: 50),
      ItemModel(icon: Image(image: AssetImage('icons/cat.png'), width: 70, height: 70,), name: "Cat", value: "cat", height: 70),
      ItemModel(icon: Image(image: AssetImage('icons/dog.png'), width: 90, height: 90,), name: "Dog", value: "dog", height: 100),
      ItemModel(icon: Image(image: AssetImage('icons/lion.png'), width: 130, height: 130,), name: "Lion", value: "lion", height: 130),
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
                      color: item.accepting ? Colors.red.shade300 : Colors.red,
                      height: item.height,
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
          Text("Game Over", style: TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.bold,
            fontSize: 24.0
          ),),
          if(gameOver)
          RaisedButton(
            textColor: Colors.white,
            color: Colors.pink,
            child: Text("Game Over"),
            onPressed: (){
              widget.bloc.fetchFirstScreen();
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
  final double height;
  bool accepting;

  ItemModel({this.name, this.value, this.icon, this.height, this.accepting=false});
}