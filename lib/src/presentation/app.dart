import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prueba_gbp/src/blocs/task/task_bloc.dart';
import 'package:prueba_gbp/src/blocs/users/users_bloc.dart';
import 'package:prueba_gbp/src/presentation/screens/home/home.dart';
import 'package:prueba_gbp/src/repositories/task_repository.dart';
import 'package:prueba_gbp/src/repositories/users_repository.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UsersBloc>(builder: (context)=> UsersBloc(userRepository: UserRepository()),),
        BlocProvider<TaskBloc>(builder: (context)=> TaskBloc(taskRepository: TaskRepository()),)
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: HomePage.routeName,
        routes: {
          HomePage.routeName: (context) => HomePage()
        },
      ),
    );
  }
}
