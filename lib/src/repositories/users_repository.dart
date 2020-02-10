import 'package:prueba_gbp/src/api/services/users_http_service.dart';
import 'package:prueba_gbp/src/models/users_model.dart';

class UserRepository  {
  UsersHttp _usersHttp = UsersHttp();

  Future<List<UserModel>> getUsers() async {
    try {
      return await _usersHttp.getUsers();
    }catch (error) {
      return Future.error(error);
    }
  }
}