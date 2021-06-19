import 'package:attendance/application/bloc/auth_bloc.dart';
import 'package:attendance/screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController fullname = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool visibilityName = false;
  bool visibilityEmail = false;
  bool visibilityPassword = false;
  final _authBloc = AuthBloc();
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    _goToRegister() {
      if (fullname.text.isEmpty) {
        setState(() {
          visibilityName = true;
        });
      } else {
        setState(() {
          visibilityName = false;
        });
      }

      if (email.text.isEmpty) {
        setState(() {
          visibilityEmail = true;
        });
      } else {
        setState(() {
          visibilityEmail = false;
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

      if (visibilityName == false &&
          visibilityEmail == false &&
          visibilityPassword == false) {
        _authBloc.add(SignUp(
          email.text,
          password.text,
          fullname.text,
        ));
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF8ACAC0),
      ),
      body: BlocListener(
        cubit: _authBloc,
        listener: (context, state) {
          if (state is AuthLoading) {
            setState(() {
              loading = true;
            });
          }
          if (state is AuthError) {
            //masuk error
            setState(() {
              loading = false;
            });
          }
          if (state is AuthSuccess) {
            setState(() {
              loading = false;
            });
            Navigator.popUntil(context, (route) => route.isFirst);
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => LoginScreen()));
          }
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
                    Widget>[
              SizedBox(
                height: 80,
              ),
              Text(
                'Create',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 4,
              ),
              Text(
                'Account',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 50,
                    child: TextField(
                      controller: fullname,
                      cursorColor: Colors.black,
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey.withOpacity(0.1),
                        hintText: 'Full Name',
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
                    visible: visibilityName,
                    child: Column(
                      children: [
                        SizedBox(height: 12),
                        Text(
                          'Full Name is required',
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
                      controller: email,
                      cursorColor: Colors.black,
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey.withOpacity(0.1),
                        hintText: 'Email',
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
                    visible: visibilityEmail,
                    child: Column(
                      children: [
                        SizedBox(height: 12),
                        Text(
                          'Email is required',
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
                ],
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
                  onPressed: loading == false ? _goToRegister : null,
                  child: loading == false
                      ? Text('Register',
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
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
