import 'package:equatable/equatable.dart';
import 'package:prueba_gbp/src/models/task_model.dart';

abstract class TaskEvent extends Equatable{
  TaskEvent([List props = const []]) : super(props);
}

class LoadTaskEvent extends TaskEvent{
  final int userID;
  LoadTaskEvent(this.userID) : super([userID]);
}

class CreateTaskEvent extends TaskEvent{
  final TaskModel task;
  CreateTaskEvent(this.task) : super([task]);

}

class UpdateTaskEvent extends TaskEvent{
  final TaskModel task;
  UpdateTaskEvent(this.task) : super([task]);
}