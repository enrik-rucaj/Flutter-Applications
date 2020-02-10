import 'package:floor/floor.dart';

@entity
class Task {
  
  @primaryKey
  final int id;

  final String message;

  Task(this.id, this.message);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Task &&
              runtimeType == other.runtimeType &&
              id == other.id &&
              message == other.message;

  // for == operator and Dismissible, ^: exclusive-or operator
  @override
  int get hashCode => id.hashCode ^ message.hashCode;

  @override
  String toString() {
    return 'Task{id: $id, message: $message}';
  }
}