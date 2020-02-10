import 'package:dio/dio.dart';
import 'package:prueba_gbp/src/api/Api.dart';
import 'package:prueba_gbp/src/models/users_model.dart';

class UsersHttp extends ApiProvider {
  Future<List<UserModel>> getUsers() async {
    try{
        Response response = await dio.get("/users");
        
      return (response.data  as List)
          .map((data) => new UserModel.fromJson(data))
          .toList();

    }catch (error) {
      return Future.error(error);
    }
  }
}