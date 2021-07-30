import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../apiconstants.dart';

class MarksProvider {
  Future getSession(token, studentId) async {
    try {
      var body = {'student_id': studentId};
      var header = {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };
      final response = await http.post(Uri.parse("${ApiConstants.GET_SESSION}"),
          headers: header, body: jsonEncode(body));
      print(response.body);
      var decodedResponse = json.decode(response.body);
      if (response.statusCode == 200) {
        return decodedResponse["sessions"];
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

  Future getMarksForSession(token, sessionId, examId, studentId) async {
    try {
      var body = {
        'exam_id': examId,
        'student_id': studentId,
        'session_id': sessionId
      };
      var header = {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };
      final response = await http.post(
          Uri.parse("${ApiConstants.GET_STUDENT_MARKS}"),
          headers: header,
          body: jsonEncode(body));
      print(response.body);
      var decodedResponse = json.decode(response.body);
      if (response.statusCode == 200) {
        return decodedResponse;
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
