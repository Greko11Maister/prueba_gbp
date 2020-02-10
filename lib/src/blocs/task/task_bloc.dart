import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:prueba_gbp/src/blocs/task/task_event.dart';
import 'package:prueba_gbp/src/blocs/task/task_state.dart';
import 'package:prueba_gbp/src/repositories/task_repository.dart';

class TaskBloc extends Bloc<TaskEvent, TaskSate> {
  final TaskRepository _taskRepository;

  TaskBloc({@required TaskRepository taskRepository})
  : assert(taskRepository != null), _taskRepository = taskRepository;


  @override
  TaskSate get initialState => UnloadTaskState();

  @override
  Stream<TaskSate> mapEventToState(TaskEvent event) async* {
    if(event is LoadTaskEvent) {
      yield* _mapLoadTasks(event);
    }
    else if(event is CreateTaskEvent){
     yield* _mapCreateTask(event);
    }
    if(event is UpdateTaskEvent){
      yield* _mapUpdateTasks(event);
    }

  }

  Stream<TaskSate> _mapCreateTask(CreateTaskEvent event) async* {
    try {
      final res = await _taskRepository.createTask(event.task);
      dispatch(LoadTaskEvent(event.task.userID));
    }catch(error){

    }
  }

  Stream<TaskSate> _mapLoadTasks(LoadTaskEvent event) async* {
    try {
      final res = await _taskRepository.getTask(event.userID);
     yield  LoadedTaskState(res);
    }catch(error){

    }
  }

  Stream<TaskSate> _mapUpdateTasks(UpdateTaskEvent event) async* {
    try {
       await _taskRepository.updateTask(event.task);
      dispatch(LoadTaskEvent(event.task.userID));
    }catch(error){

    }
  }
}