import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prueba_gbp/src/blocs/users/users_bloc.dart';
import 'package:prueba_gbp/src/blocs/users/users_event.dart';
import 'package:prueba_gbp/src/blocs/users/users_state.dart';
import 'package:prueba_gbp/src/models/users_model.dart';
import 'package:prueba_gbp/src/presentation/screens/detail/detail_page.dart';
class HomePage extends StatelessWidget {
  static const String routeName = 'home';
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<UsersBloc>(context).dispatch(LoadUsersEvent());

    return Scaffold(
      appBar: new AppBar(title: Text("Prueba GBP"),),
      body: BlocBuilder<UsersBloc, UsersState>(
        builder: (context, state){
          if(state is LoadedUsersState){
            return ListView.separated(
                itemBuilder: (context, i) => _item(context, state.users[i]),
                separatorBuilder: (BuildContext context, int index){
                  return Container(
                    color: Colors.blueAccent.withOpacity(0.15),
                    height: 8.0,
                  );
                },
                itemCount: state.users.length);
          }
          return Container(child: Text("Sin resultados"),);
        },
      ),
    );
  }

  Widget _item(BuildContext context, UserModel user){
    return ListTile(
      leading: new CircleAvatar(
        backgroundImage: new NetworkImage(user.avatarUrl),
      ),
      title: Text(user.login, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0)),
      subtitle: Text(user.organizationsUrl),
      onTap: () async {
        await Navigator.push(context,
            new MaterialPageRoute(builder: (context)=> DetailPage(args: user)));
      },
    );
  }
}
