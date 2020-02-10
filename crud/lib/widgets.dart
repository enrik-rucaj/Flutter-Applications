import 'package:flutter/material.dart';

import 'task.dart';
import 'task_dao.dart';

class ListCell extends StatelessWidget {
  const ListCell({
    Key key,
    @required this.task,
    @required this.dao,
  }) : super(key: key);

  final Task task;
  final TaskDao dao;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key('${task.hashCode}'),
      background: Container(
        color: Colors.red[900], 
        alignment: Alignment.centerRight,
        child: Icon(Icons.delete, color: Colors.white),
      ),
      direction: DismissDirection.endToStart,
      child: ListTile(title: Text(task.message)),
      onDismissed: (direction) async {
        await dao.deleteTask(task);
        Scaffold.of(context).showSnackBar(
          SnackBar(content: const Text('Removed task')),
        );
      },
    );
  }
}