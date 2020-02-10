import 'package:prueba_gbp/src/database/database_helpers.dart';
import 'package:prueba_gbp/src/models/task_model.dart';

class TaskRepository {
  DatabaseHelper _databaseHelper = DatabaseHelper.instance;


  Future<List<TaskModel>> getTask(int userID) async {
    List<TaskModel> taskList;
    final res = await _databaseHelper.selectQuery("UserTask", [], "UserID = ? ", [userID]);
    if(res != null){
      print("Resultado DB");
      print(res);
      /*final data = res[0];
      // Todo implement for
      taskList.add(TaskModel(id: data["ID"], userID: data["UserID"], description: data["Description"], status: data["Status"]));

      return taskList;*/
      return (res as List)
          .map((data) => new TaskModel(id: data["Id"], userID: data["UserID"], description: data["Description"], status: data["Status"] ))
          .toList();
    }

    return null;
  }

  Future createTask(TaskModel taskModel) async {
    await _databaseHelper.rawInsertOrReplace("UserTask", "UserID, Description, Status", [taskModel.userID, taskModel.description, taskModel.status]);
  }

  Future updateTask(TaskModel taskModel) async {
    Map<String, dynamic> values = {'Status': 1};
    await _databaseHelper.update("UserTask", values,  "UserID = ? AND Id = ? ", [taskModel.userID, taskModel.id]);
  }
}