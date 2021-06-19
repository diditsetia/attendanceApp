import 'package:attendance/application/bloc/auth_bloc.dart';
import 'package:attendance/screen/home_screen.dart';
import 'package:attendance/screen/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  bool visibilityUsername = false;
  bool visibilityPassword = false;
  final _authBloc = AuthBloc();
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    _submitLogin() {
      if (username.text.isEmpty) {
        setState(() {
          visibilityUsername = true;
        });
      } else {
        setState(() {
          visibilityUsername = false;
        });
      }

      if (password.text.isEmpty) {
        setState(() {
          visibilityPassword = true;
        });
      } else {
        setState(() {
          visibilityPassword = false;
        });
      }

      if (visibilityUsername == false && visibilityPassword == false) {
        _authBloc.add(SignIn(
          username.text,
          password.text,
        ));
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: null,
      body: BlocListener(
        cubit: _authBloc,
        listener: (context, state) {
          if (state is AuthLoading) {
            setState(() {
              loading = true;
            });
          }
          if (state is AuthError) {
            setState(() {
              loading = false;
            });
          }
          if (state is AuthSuccess) {
            setState(() {
              loading = false;
            });
            String username = state.uid;

            Navigator.popUntil(context, (route) => route.isFirst);
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => HomeScreen(
                          name: username,
                        )));
          }
        },
        child: Padding(
          padding: const EdgeInsets.only(top: 60),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'ABSENT APP',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 80,
                    ),
                    Text(
                      'Hey,',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      'Login Now.',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Row(
                      children: [
                        Text(
                          'if you are new / ',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                              color: Colors.grey),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RegisterScreen()));
                          },
                          child: Text(
                            'Register Now ',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 50),
                    Container(
                      height: 50,
                      child: TextField(
                        controller: username,
                        cursorColor: Colors.black,
                        textInputAction: TextInputAction.done,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey.withOpacity(0.1),
                          hintText: 'Username',
                          hintStyle: TextStyle(
                            fontSize: 14,
                            color: Colors.black.withOpacity(0.5),
                            fontWeight: FontWeight.w500,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey.withOpacity(0.1)),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey.withOpacity(0.1)),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: visibilityUsername,
                      child: Column(
                        children: [
                          SizedBox(height: 12),
                          Text(
                            'Username is required',
                            style: TextStyle(color: Colors.red),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 18,
                    ),
                    Container(
                      height: 50,
                      child: TextField(
                        obscureText: true,
                        controller: password,
                        cursorColor: Colors.black,
                        textInputAction: TextInputAction.done,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey.withOpacity(0.1),
                          hintText: 'Password',
                          hintStyle: TextStyle(
                            fontSize: 14,
                            color: Colors.black.withOpacity(0.5),
                            fontWeight: FontWeight.w500,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey.withOpacity(0.1)),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey.withOpacity(0.1)),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: visibilityPassword,
                      child: Column(
                        children: [
                          SizedBox(height: 12),
                          Text(
                            'Password is required',
                            style: TextStyle(color: Colors.red),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 49, bottom: 20),
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Color(0xFF8ACAC0),
                      ),
                      child: FlatButton(
                        onPressed: loading == false ? _submitLogin : null,
                        child: loading == false
                            ? Text('Login',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ))
                            : SizedBox(
                                child: CircularProgressIndicator(),
                                height: 20.0,
                                width: 20.0,
                              ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
