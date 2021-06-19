class Users {
  Users({
    this.date,
    this.workingHrs,
    this.absentIn,
    this.absentOut,
    this.status,
    this.username,
    this.id,
    this.formatAbsentIn,
    this.formatAbsentOut,
  });

  String date;
  String workingHrs;
  String absentIn;
  String absentOut;
  String status;
  String username;
  String id;
  String formatAbsentIn;
  String formatAbsentOut;

  factory Users.fromJson(Map<dynamic, dynamic> json) => Users(
        date: json["date"],
        workingHrs: json["workingHrs"],
        absentIn: json["absentIn"],
        absentOut: json["absentOut"],
        status: json["status"],
        username: json["username"],
        id: json["id"],
        formatAbsentIn: json["formatAbsentIn"],
        formatAbsentOut: json["formatAbsentOut"],
      );

  Map<dynamic, dynamic> toJson() => {
        "date": date,
        "workingHrs": workingHrs,
        "absentIn": absentIn,
        "absentOut": absentOut,
        "status": status,
        "username": username,
        "id": id,
        "formatAbsentIn": formatAbsentIn,
        "formatAbsentOut": formatAbsentOut,
      };
}
