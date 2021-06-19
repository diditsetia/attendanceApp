abstract class AbsentRepository {
  Future absentIn(
    String username,
    String date,
    String absenIn,
    String absenOut,
    String workingHrs,
    String uId,
    String idAbsenString,
    String statusAbsent,
  );
  Future getAbsent(
    String uId,
  );

  Future absentOut(
    String absenOut,
    String workingHrs,
    String idUser,
    String status,
    String uId,
  );

  Future checkUserActive(
    String uId,
  );

  Future getAllUserAbsent();
}
