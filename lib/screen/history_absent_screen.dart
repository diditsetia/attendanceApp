import 'package:attendance/application/absent/absent_bloc.dart';
import 'package:attendance/screen/widget/list_history_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HistoryAbsentScreen extends StatefulWidget {
  @override
  _HistoryAbsentScreenState createState() => _HistoryAbsentScreenState();
}

class _HistoryAbsentScreenState extends State<HistoryAbsentScreen> {
  final _absentBloc = AbsentBloc();
  bool loading;
  List data;
  @override
  void initState() {
    _getAllUsers();
    super.initState();
  }

  _getAllUsers() {
    _absentBloc.add(GetAllUserAbsent());
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF8ACAC0),
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener(
            cubit: _absentBloc,
            listener: (context, state) {
              if (state is AbsentLoading) {
                setState(() {
                  loading = true;
                });
              }

              if (state is GetAllUserSuccess) {
                setState(() {
                  data = state.data;
                });
                setState(() {
                  loading = false;
                });
              }
            },
          ),
        ],
        child: loading == true
            ? Container(
                color: Colors.white,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.red,
                      ),
                      height: 50.0,
                      width: 50.0,
                    ),
                  ],
                ),
              )
            : data == null
                ? Container()
                : Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: SingleChildScrollView(
                            child: Column(children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    height: 50,
                                    width: 80,
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Date',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          )
                                        ]),
                                  ),
                                  Container(
                                    height: 50,
                                    width: 80,
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Absen in',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          )
                                        ]),
                                  ),
                                  Container(
                                    height: 50,
                                    width: 80,
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Absen out',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          )
                                        ]),
                                  ),
                                  Container(
                                    height: 50,
                                    width: 90,
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Work Hrs',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          )
                                        ]),
                                  )
                                ],
                              ),
                              Container(
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: data.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      final dataUsers = data[index];
                                      return ListHistoryScreen(
                                        name: dataUsers.username,
                                        date: dataUsers.date,
                                        absentin: dataUsers.formatAbsentIn,
                                        absentout: dataUsers.formatAbsentOut,
                                        workinghrs: dataUsers.workingHrs,
                                      );
                                    }),
                              ),
                              SizedBox(
                                height: 40,
                              ),
                            ]),
                          ),
                        ),
                      ],
                    ),
                  ),
      ),
    );
  }
}
