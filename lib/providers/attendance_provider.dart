import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../apiconstants.dart';

class AttendanceProvider {
  Future getAttendance(token, studentId, startDate, endDate) async {
    try {
      var body = {
        'student_id': studentId,
        'start_date': startDate,
        'end_date': endDate
      };
      var header = {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };
      final response = await http.post(
          Uri.parse("${ApiConstants.GET_STUDENT_ATTENDANCE}"),
          headers: header,
          body: jsonEncode(body));
      print(response.body);
      var decodedResponse = json.decode(response.body);
      if (response.statusCode == 200) {
        return decodedResponse["data"];
      } else {
        throw Exception();
      }
    } catch (e) {
      if (e is SocketException) {
        throw SocketException("$e");
      }
      throw Exception(e);
    }
  }
}
