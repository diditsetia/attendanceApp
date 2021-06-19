import 'dart:convert';

import 'package:attendance/infrastructure/repositories/absent_repository.dart';
import 'package:attendance/model/users.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class AbsentRepositoryImpl extends AbsentRepository {
  @override
  Future absentIn(
    String username,
    String date,
    String absenIn,
    String absenOut,
    String workingHrs,
    String uId,
    String idAbsenString,
    String statusAbsent,
  ) async {
    final databaseReference = FirebaseDatabase.instance.reference();
    DateTime tempDate = new DateFormat("yyyy-MM-dd HH:mm:ss").parse(absenIn);
    String formatAbsentin = new DateFormat("HH:mm").format(tempDate);
    final res = await databaseReference
        .child('${uId}/' + '${username}${idAbsenString}')
        .set({
      'username': username,
      'date': date,
      'absentIn': absenIn,
      'absentOut': absenOut,
      'workingHrs': workingHrs,
      'status': statusAbsent,
      'id': '${username}${idAbsenString}',
      'formatAbsentIn': formatAbsentin,
      'formatAbsentOut': absenOut,
    });

    final dbRef = FirebaseDatabase.instance.reference().child("${uId}");
    final resdata =
        await dbRef.orderByChild("status").equalTo("absenin").once();
    List listdata = [];
    Map<dynamic, dynamic> values = resdata.value;
    values.forEach((key, values) {
      listdata.add(values);
    });

    final data = listdata;
    final resultdata = Users.fromJson(data[0]);
    return resultdata;

    // List data = [
    //   {
    //     'id': uId,
    //     'idAbsent': idAbsenString,
    //   }
    // ];

    // return data;
    // print(username);
    // print(date);
    // print(absenIn);
    // print(absenOut);
    // print(workingHrs);
  }

  Future getAbsent(String uId) async {
    String id = uId;
    final response = await http.get(
        "https://attendance-6220e-default-rtdb.firebaseio.com/${id}.json?");
    if (response.body == "null") {
      return null;
    } else {
      final extractedData = json.decode(response.body) as Map<String, dynamic>;

      List allData = [];
      Map<String, dynamic> values = extractedData;
      values.forEach((key, values) {
        allData.add(values);
      });
      final leghtdata = allData.length;
      return leghtdata;
    }
  }

  Future absentOut(
    String absenout,
    String workingHrs,
    String idUser,
    String status,
    String uId,
  ) async {
    final databaseReference = FirebaseDatabase.instance.reference();
    DateTime tempDate = new DateFormat("yyyy-MM-dd HH:mm:ss").parse(absenout);
    String formatAbsentOut = new DateFormat("HH:mm").format(tempDate);
    final resp = await databaseReference.child('${uId}/' + '${idUser}').update({
      'absentOut': absenout,
      'workingHrs': workingHrs,
      'status': status,
      'formatAbsentOut': formatAbsentOut,
    });

    final respData =
        await databaseReference.child('${uId}/' + '${idUser}').once();
    final resultdata = Users.fromJson(respData.value);
    return resultdata;
  }

  Future checkUserActive(String uId) async {
    final dbRef = FirebaseDatabase.instance.reference().child("${uId}");
    final resdata =
        await dbRef.orderByChild("status").equalTo("absenin").once();
    if (resdata.value == null) {
      return resdata.value;
    } else {
      List listdata = [];
      Map<dynamic, dynamic> values = resdata.value;
      values.forEach((key, values) {
        listdata.add(values);
      });

      final data = listdata;
      final resultdata = Users.fromJson(data[0]);
      return resultdata;
    }
  }

  Future getAllUserAbsent() async {
    List listdata = [];
    final databaseReference = FirebaseDatabase.instance.reference();
    await databaseReference.once().then((DataSnapshot snapshot) {
      var ab = snapshot;
      print(ab);
      if (snapshot.value != null) {
        Map<dynamic, dynamic> values = snapshot.value;
        values.forEach((key, data) {
          data.forEach((key, d) {
            listdata.add(d);
          });
        });
      } else {
        return null;
      }
    });

    if (listdata.length != 0) {
      List dataUsers = [];

      listdata.forEach((data) {
        final resultdata = Users.fromJson(data);
        dataUsers.add(resultdata);
      });

      return dataUsers;
    }
  }
}
