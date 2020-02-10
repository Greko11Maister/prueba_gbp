import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prueba_gbp/src/blocs/task/task_bloc.dart';
import 'package:prueba_gbp/src/blocs/task/task_event.dart';
import 'package:prueba_gbp/src/blocs/task/task_state.dart';
import 'package:prueba_gbp/src/models/task_model.dart';
import 'package:prueba_gbp/src/models/users_model.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class DetailPage extends StatefulWidget {
  UserModel args;
  DetailPage({@required this.args});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  TaskBloc _taskBloc;
  TextEditingController descriptionController = new TextEditingController();

  @override
  void initState() {
    _taskBloc = BlocProvider.of<TaskBloc>(context);
    _taskBloc.dispatch(LoadTaskEvent(widget.args.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(title: Text("Actividades del usuario"),),
      backgroundColor: Colors.white,
      body: Container(
        child: Column(
          children: <Widget>[
            userInfo(),
            Expanded(child: taskUser() ,),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){

          Alert(
              context: context,
              title: "Crear Actividad",
              content: Column(
                children: <Widget>[
                  Divider(),
                  TextField(
                    controller: descriptionController,
                    decoration: InputDecoration(
                      icon: Icon(Icons.account_circle),
                      labelText: 'Descripción',
                    ),
                  ),
                ],
              ),
              buttons: [
                DialogButton(
                  onPressed: () {
                    descriptionController.clear();
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Cancelar",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
                DialogButton(
                  onPressed: () {
                    TaskModel task = TaskModel(userID: widget.args.id, description:descriptionController.text,status: 0);
                    _taskBloc.dispatch(CreateTaskEvent(task));
                    descriptionController.clear();
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Crear",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                )
              ]).show();
        },
      ),
    );
  }
  Widget userInfo() {
    return ListTile(
      leading: new CircleAvatar(
        backgroundImage: new NetworkImage(widget.args.avatarUrl),
      ),
      title: Text(widget.args.login, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0)),
      subtitle: Text(widget.args.organizationsUrl),
      onTap: () {
      },
    );
  }

  Widget activityPending(List<TaskModel> task) {
    return Container(
      child: Column(
           children: <Widget>[
             Container(
               width: MediaQuery.of(context).size.width,
               color: Colors.deepOrangeAccent[100],
               child: Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: Text("Pendientes", textAlign: TextAlign.left,style: TextStyle(color: Colors.deepOrange, fontWeight: FontWeight.bold),),
               ),
             ),
             task.length > 0 ? Expanded(child: ListView.separated(
                itemBuilder: (context, i) => _item(context, task[i]),
                separatorBuilder: (BuildContext context, int index){
                  return Container(
                    color: Colors.blueAccent.withOpacity(0.15),
                    height: 8.0,
                  );
                },
                itemCount: task.length),)
                 : Container()

                 ],
      ),
    );
  }
  Widget activityDone(List<TaskModel> task) {
    return Container(
      child: Column(
           children: <Widget>[
             Container(
               width: MediaQuery.of(context).size.width,
               color: Colors.green[200],
               child: Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: Text("Realizadas", textAlign: TextAlign.left,style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),),
               ),
             ),
             Expanded(child:  ListView.separated(
                 itemBuilder: (context, i) => _item(context, task[i]),
                 separatorBuilder: (BuildContext context, int index){
                   return Container(
                     color: Colors.blueAccent.withOpacity(0.15),
                     height: 8.0,
                   );
                 },
                 itemCount: task.length),)

           ],
      ),
    );
  }

  Widget taskUser() {
    return BlocBuilder<TaskBloc,TaskSate>(
      builder: (context, state){
        if(state is LoadedTaskState){
          if(state.tasks != null && state.tasks.length > 0){
            var  taskPending = state.tasks.where((item) => item.status == 0).toList();
           var  taskDone = state.tasks.where((item) => item.status == 1).toList();
            return Column(
              children: <Widget>[
                Expanded(
                  child: activityPending(taskPending),
                )
                ,
                Expanded(
                  child:  activityDone(taskDone),
                )

              ],
            );
          }
          return Container(
            width: MediaQuery.of(context).size.width,
            height: 20,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Registra una actividad.", textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 20),),
              ));
        }
        return Container(child: Text("Aun no hay actividades."));
      },
    );
  }

  Widget _item(BuildContext context, TaskModel task){
    return ListTile(
      leading: task.status == 0 ? Icon(Icons.panorama_fish_eye) : Icon(Icons.check_circle_outline, color: Colors.green,),
      title: Text("${task.description}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0)),
      onLongPress: () async {
       _taskBloc.dispatch(UpdateTaskEvent(task));
      },
    );
  }
}
