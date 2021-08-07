import 'package:flutter/cupertino.dart';
import 'package:guardiansapp/providers/attendance_provider.dart';
import 'package:guardiansapp/providers/event_provider.dart';

class AttendanceRepository {
  AttendanceProvider attendanceProvider = new AttendanceProvider();
  Future getAttendance(
      {@required token,
      @required studentId,
      @required startDate,
      @required endDate}) async {
    var response = await attendanceProvider.getAttendance(
        token, studentId, startDate, endDate);
    return response;
  }
}
