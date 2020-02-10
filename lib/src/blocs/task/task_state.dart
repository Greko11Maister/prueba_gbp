import 'package:equatable/equatable.dart';
import 'package:prueba_gbp/src/models/task_model.dart';

abstract class TaskSate extends Equatable{
  TaskSate([List props = const []]) : super(props);
}

class UnloadTaskState extends TaskSate{}

class LoadedTaskState extends TaskSate{
  final List<TaskModel> tasks;
  LoadedTaskState(this.tasks) : super([tasks]);
}

class SuccessCreateTaskState extends TaskSate {}

class SuccessUpdateTaskState extends TaskSate {}

