import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ListHistoryScreen extends StatefulWidget {
  final String name;
  final String date;
  final String absentin;
  final String absentout;
  final String workinghrs;
  const ListHistoryScreen({
    Key key,
    this.name,
    this.date,
    this.absentin,
    this.absentout,
    this.workinghrs,
  }) : super(key: key);
  @override
  _ListHistoryScreenState createState() => _ListHistoryScreenState();
}

class _ListHistoryScreenState extends State<ListHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    DateTime tempDate =
        new DateFormat("yyyy-MM-dd HH:mm:ss").parse(widget.date);
    String date = new DateFormat("dd MMM yyyy").format(tempDate);

    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 80,
            width: 80,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 55,
                    height: 70,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5.0),
                        topRight: Radius.circular(5.0),
                        bottomLeft: Radius.circular(5.0),
                        bottomRight: Radius.circular(5.0),
                      ),
                      color: Color(0xFF5BACFB),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 0,
                          blurRadius: 10,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            width: 40,
                            child: Text(
                              date,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          // Text(
                          //   'JUN',
                          //   style: TextStyle(
                          //     fontSize: 12,
                          //     height: 1.5,
                          //     fontWeight: FontWeight.bold,
                          //     color: Colors.white,
                          //   ),
                          // ),
                          // Text(
                          //   '2021',
                          //   style: TextStyle(
                          //     fontSize: 12,
                          //     height: 1.5,
                          //     fontWeight: FontWeight.bold,
                          //     color: Colors.white,
                          //   ),
                          // )
                        ]),
                  )
                ]),
          ),
          Container(
            width: 260,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.name,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 50,
                      width: 80,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 20,
                                  height: 20,
                                  color: Colors.greenAccent,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  widget.absentin,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            )
                          ]),
                    ),
                    Container(
                      height: 50,
                      width: 80,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 20,
                                  height: 20,
                                  color: Colors.red,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  widget.absentout.isEmpty
                                      ? '-'
                                      : widget.absentout,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            )
                          ]),
                    ),
                    Container(
                      height: 50,
                      width: 90,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 20,
                                  height: 20,
                                  color: Colors.orange,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  widget.workinghrs.isEmpty
                                      ? '-'
                                      : widget.workinghrs,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            )
                          ]),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
