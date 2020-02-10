
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:prueba_gbp/src/blocs/users/users_event.dart';
import 'package:prueba_gbp/src/blocs/users/users_state.dart';
import 'package:prueba_gbp/src/repositories/users_repository.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {

  final UserRepository _userRepository;

  UsersBloc({@required UserRepository userRepository})
  : assert(userRepository != null), _userRepository = userRepository;

  @override
  UsersState get initialState => UnloadUsersState();

  @override
  Stream<UsersState> mapEventToState(UsersEvent event) async* {
    if(event is LoadUsersEvent) {
      yield* _mapLoadUserToState();
    }
  }

  Stream<UsersState> _mapLoadUserToState() async* {
    try {
      final res = await _userRepository.getUsers();
      yield LoadedUsersState(res);
    }catch (error){
     yield ErrorUsersState(message: error.toString());
    }
  }
}