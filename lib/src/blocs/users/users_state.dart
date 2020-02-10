import 'package:equatable/equatable.dart';
import 'package:prueba_gbp/src/models/users_model.dart';
import 'package:meta/meta.dart';

abstract class UsersState extends Equatable{
  UsersState([List props = const []]) : super(props);
}

class UnloadUsersState extends UsersState{}

class LoadedUsersState extends UsersState{
  final List<UserModel> users;
  LoadedUsersState(this.users) : super([users]);

  @override
  String toString() => '$runtimeType { $users }';
}

class ErrorUsersState extends UsersState{
  final String message;
  ErrorUsersState({@required this.message}) : super([message]);

  @override
  String toString() =>  '$runtimeType { $message}';
}