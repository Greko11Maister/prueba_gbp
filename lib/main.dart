import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:prueba_gbp/src/blocs/my_bloc_delegate.dart';
import 'package:prueba_gbp/src/presentation/app.dart';

void main() {
  BlocSupervisor.delegate = MyBlocDelegate();
  runApp(App());
}

