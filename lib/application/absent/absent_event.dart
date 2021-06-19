part of 'absent_bloc.dart';

abstract class AbsentEvent extends Equatable {
  const AbsentEvent();
}

class AbsentIn extends AbsentEvent {
  String username;
  String date;
  String absenIn;
  String absenOut;
  String workingHrs;
  String uId;
  String idAbsenString;
  String statusAbsent;

  AbsentIn(
    this.username,
    this.date,
    this.absenIn,
    this.absenOut,
    this.workingHrs,
    this.uId,
    this.idAbsenString,
    this.statusAbsent,
  );

  @override
  List<Object> get props => [
        username,
        date,
        absenIn,
        absenOut,
        workingHrs,
        uId,
        idAbsenString,
        statusAbsent,
      ];
}

class AbsentOut extends AbsentEvent {
  String absenout;
  String workingHrs;
  String idUser;
  String status;
  String uId;

  AbsentOut(
    this.absenout,
    this.workingHrs,
    this.idUser,
    this.status,
    this.uId,
  );

  @override
  List<Object> get props => [
        absenout,
        workingHrs,
        idUser,
        status,
        uId,
      ];
}

class GetDataAbsent extends AbsentEvent {
  String uId;

  GetDataAbsent(this.uId);
  @override
  List<Object> get props => [uId];
}

class CheckUserActive extends AbsentEvent {
  String uId;

  CheckUserActive(this.uId);
  @override
  List<Object> get props => [uId];
}

class GetAllUserAbsent extends AbsentEvent {
  @override
  List<Object> get props => [];
}
