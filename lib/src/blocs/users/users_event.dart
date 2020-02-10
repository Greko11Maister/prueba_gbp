import 'package:equatable/equatable.dart';

abstract class UsersEvent extends Equatable{
  UsersEvent([List props = const []]) : super(props);
}

class LoadUsersEvent  extends UsersEvent{}

class ResetUsersEvent extends UsersEvent{}