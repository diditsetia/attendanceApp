import 'package:attendance/application/bloc/auth_bloc.dart';
import 'package:attendance/screen/home_screen.dart';
import 'package:attendance/screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class RootScreen extends StatefulWidget {
  @override
  _RootScreenState createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  final _authBloc = AuthBloc();

  @override
  void initState() {
    _authBloc.add(CheckAuth());
    super.initState();
  }

  @override
  void dispose() {
    _authBloc.close();

    super.dispose();
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Attendance',
      home: BlocBuilder(
        cubit: _authBloc,
        builder: (context, state) {
          if (state is AuthSuccess) {
            if (state.uid != null) {
              return HomeScreen();
            }
          }
          if (state is AuthError) return LoginScreen();
          return Container();
        },
      ),
    );
  }
}
