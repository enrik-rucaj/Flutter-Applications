//import 'dart:html';

import 'package:flutter/material.dart';

import 'task.dart';
import 'task_dao.dart';

class ListCell extends StatefulWidget {
  ListCell({
    Key key,
    @required this.task,
    @required this.dao,
  }) : super(key: key);

  final Task task;
  final TaskDao dao;
  
  @override
  _ListCellState createState() => _ListCellState();
}

class _ListCellState extends State<ListCell> {
  //int rating;
  
  @override
  Widget build(BuildContext context) {
    print("prima prova@@@@@@@@@@@@@@@@@@@@@@@");
    print(widget.task.rating);
    return Dismissible(
      key: UniqueKey(),
      background: Container(
        color: Colors.red[900], 
        alignment: Alignment.centerRight,
        child: Icon(Icons.delete, color: Colors.white),
      ),
      direction: DismissDirection.endToStart,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(title: Text(widget.task.message)),
          StarRating(
            //rating: rating,
            task: widget.task,
            dao: widget.dao,
            //onRatingChanged: (rating) => setState(() => rating = rating),
          )
        ],
      ),
      onDismissed: (direction) async {
        await widget.dao.deleteTask(widget.task);
        Scaffold.of(context).showSnackBar(
          SnackBar(content: const Text('Removed task')),
        );
      },
    );
  }
}

//typedef void RatingChangeCallback(int rating);

class StarRating extends StatelessWidget {
  final int starCount;
  //final int rating;
  //final RatingChangeCallback onRatingChanged;
  final Color color;
  final Task task;
  final TaskDao dao;

  StarRating({this.starCount = 5, /*this.rating , this.onRatingChanged,*/ this.color, this.task, this.dao});
  
  @override
  Widget build(BuildContext context) {
    print("seconda prova@@@@@@@@@@@@@@@@@@@@@@@");
    print(task.rating);
    return new Row(children: new List.generate(starCount, (index) => buildStar(context, index)));
  }
  
  Widget buildStar(BuildContext context, int index) {
    Icon icon;
    if (index >= task.rating) {
      icon = new Icon(
        Icons.star_border,
        color: Theme.of(context).buttonColor,
      );
    }
    else {
      icon = new Icon(
        Icons.star,
        color: color ?? Theme.of(context).primaryColor,
      );
    }
    return new InkResponse(
      child: icon,
      onTap: () async {
        final task2 = Task(task.id, task.message, index+1);
        //if (onRatingChanged != null){
          await dao.updateTask(task2);
          //return onRatingChanged(index+1);
        //}
      },//onRatingChanged == null ? null : () => onRatingChanged(index + 1.0),
    );
  }
}