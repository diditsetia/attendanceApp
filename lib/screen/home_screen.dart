import 'package:attendance/application/absent/absent_bloc.dart';
import 'package:attendance/application/bloc/auth_bloc.dart';

import 'package:attendance/screen/history_absent_screen.dart';
import 'package:attendance/screen/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  final String name;

  const HomeScreen({Key key, this.name}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _authBloc = AuthBloc();
  final _absentBloc = AbsentBloc();
  String fullName;

  @override
  void initState() {
    _cekUser();
    super.initState();
  }

  _cekUser() async {
    final resp = await FirebaseAuth.instance.currentUser();
    setState(() {
      fullName = resp.displayName;
    });
    String uId = resp.uid;
    _absentBloc.add(GetDataAbsent(uId));

    _absentBloc.add(CheckUserActive(uId));
  }

  @override
  void dispose() {
    super.dispose();
  }

  bool loading = false;
  int idAbsen = 1;
  int lengthData = 0;

  String absentIn;
  String absentOut;
  String date;
  String status;
  String username;
  String workingHrs;
  String id;
  String formatAbsenIn;
  String formatAbsenOut;

  @override
  Widget build(BuildContext context) {
    _absenIn() async {
      final resp = await FirebaseAuth.instance.currentUser();
      String uId = resp.uid;
      _absentBloc.add(GetDataAbsent(uId));

      String username = resp.displayName;
      DateTime now = DateTime.now();
      // String date = DateFormat('dd MMM yyyy').format(now);
      String date = DateFormat("yyyy-MM-dd HH:mm:ss").format(DateTime.now());
      // String absenIn = DateFormat('HH:mm').format(now);
      String absenIn = DateFormat("yyyy-MM-dd HH:mm:ss").format(DateTime.now());
      String absenOut = '';
      String workingHrs = '';
      String idAbsenString = idAbsen.toString();
      String statusAbsent = 'absenin';
      _absentBloc.add(AbsentIn(
        username,
        date,
        absenIn,
        absenOut,
        workingHrs,
        uId,
        idAbsenString,
        statusAbsent,
      ));
    }

    _absentOut() async {
      final resp = await FirebaseAuth.instance.currentUser();
      String uId = resp.uid;
      String aIn = absentIn;
      DateTime now = DateTime.now();
      DateTime tempDate = new DateFormat("yyyy-MM-dd HH:mm:ss").parse(aIn);
      String absentout =
          new DateFormat("yyyy-MM-dd HH:mm:ss").format(DateTime.now());
      String workiInMinutes = now.difference(tempDate).inMinutes.toString();
      String workInHours = now.difference(tempDate).inHours.toString();

      String wkHrs = '${workInHours}h ${workiInMinutes}m';
      String wkMinutes = '${workiInMinutes}m';
      String workinghrs = workInHours != '0' ? wkHrs : wkMinutes;
      String status = 'absentout';
      String idUser = id;

      _absentBloc.add(AbsentOut(
        absentout,
        workinghrs,
        idUser,
        status,
        uId,
      ));
      _absentBloc.add(GetDataAbsent(uId));
    }

    return Scaffold(
      appBar: null,
      body: MultiBlocListener(
        listeners: [
          BlocListener(
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
          ),
          BlocListener(
            cubit: _absentBloc,
            listener: (context, state) {
              if (state is AbsentLoading) {
                setState(() {
                  loading = true;
                });
              }
              if (state is AbsentError) {
                //masuk error
                setState(() {
                  loading = false;
                });
              }
              if (state is AbsentSuccess) {
                setState(() {
                  loading = false;
                });
                if (state.data == null) {
                  setState(() {
                    idAbsen = 1;
                  });
                } else {
                  int sumData = state.data;

                  int index = 1;

                  int updateId = index + sumData;
                  setState(() {
                    idAbsen = updateId;
                  });
                }
              }

              if (state is AbsentInSuccess) {
                setState(() {
                  loading = false;
                });
                var data = state.data;

                setState(() {
                  absentIn = data.absentIn;
                  absentOut = data.absentOut;
                  date = data.date;
                  status = data.status;
                  username = data.username;
                  workingHrs = data.workingHrs;
                  id = data.id;
                  formatAbsenIn = data.formatAbsentIn;
                  formatAbsenOut = data.formatAbsentOut;
                });
              }

              if (state is AbsentOutSuccess) {
                setState(() {
                  loading = false;
                });
                var data = state.data;
                setState(() {
                  absentOut = data.absentOut;
                  status = data.status;
                  workingHrs = data.workingHrs;
                  formatAbsenOut = data.formatAbsentOut;
                });
              }

              if (state is CheckUserActiveSuccess) {
                setState(() {
                  loading = false;
                });
                var data = state.data;
                if (data != null) {
                  absentIn = data.absentIn;
                  absentOut = data.absentOut;
                  date = data.date;
                  status = data.status;
                  username = data.username;
                  workingHrs = data.workingHrs;
                  id = data.id;
                  formatAbsenIn = data.formatAbsentIn;
                  formatAbsenOut = data.formatAbsentOut;
                }
              }
            },
          ),
        ],
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(50.0),
                              topRight: Radius.circular(50.0),
                              bottomLeft: Radius.circular(50.0),
                              bottomRight: Radius.circular(50.0),
                            ),
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Welcome',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Container(
                              width: 200,
                              child: Text(
                                '${fullName}',
                                style: TextStyle(
                                  fontSize: 18,
                                  height: 1.5,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    GestureDetector(
                        onTap: () {
                          _authBloc.add(SignOut());
                        },
                        child: Text(
                          'Logout',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                  ],
                ),
                SizedBox(
                  height: 50,
                ),
                SizedBox(
                  height: 4,
                ),
                SizedBox(
                  height: 22,
                ),
                GestureDetector(
                  onTap: loading == false
                      ? status != 'absenin'
                          ? _absenIn
                          : _absentOut
                      : null,
                  child: Container(
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(100.0),
                        topRight: Radius.circular(100.0),
                        bottomLeft: Radius.circular(100.0),
                        bottomRight: Radius.circular(100.0),
                      ),
                      color:
                          status != 'absenin' ? Colors.greenAccent : Colors.red,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 6,
                          blurRadius: 10,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        loading == false
                            ? status != 'absenin'
                                ? Text(
                                    'ABSENT IN',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  )
                                : Text(
                                    'ABSENT OUT',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  )
                            : SizedBox(
                                child: CircularProgressIndicator(),
                                height: 20.0,
                                width: 20.0,
                              ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 22,
                ),
                SizedBox(
                  height: 40,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 20,
                              height: 20,
                              color: Colors.greenAccent,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              formatAbsenIn == null || formatAbsenIn == ""
                                  ? '-'
                                  : formatAbsenIn,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Text(
                              'Absent In',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 100,
                        height: 100,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 20,
                              height: 20,
                              color: Colors.red,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              formatAbsenOut == null || formatAbsenOut == ""
                                  ? '-'
                                  : formatAbsenOut,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Text(
                              'Absent Out',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 100,
                        height: 100,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 20,
                              height: 20,
                              color: Colors.orange,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              workingHrs == null || workingHrs == ""
                                  ? '-'
                                  : workingHrs,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Text(
                              'Working Hrs',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      )
                    ]),
                Container(
                  margin: EdgeInsets.only(top: 49, bottom: 20),
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Color(0xFF8ACAC0),
                    // gradient: LinearGradient(
                    //   colors: [Color(0xFFFFAD01), Color(0xFFFF8F00)],
                    //   begin: FractionalOffset.topLeft,
                    //   end: FractionalOffset.bottomRight,
                    // ),
                  ),
                  child: FlatButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HistoryAbsentScreen()));
                    },
                    child: Text('All User Absent ',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        )),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
