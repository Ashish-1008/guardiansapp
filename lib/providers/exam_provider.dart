import 'dart:convert';

import 'dart:io';
import 'package:http/http.dart' as http;

import '../apiconstants.dart';

class ExamProvider {
  Future getExamForSession(token, sessionId) async {
    try {
      var body = {'session_id': sessionId};
      var header = {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };
      final response = await http.post(
          Uri.parse("${ApiConstants.GET_EXAM_FOR_SESSION}"),
          headers: header,
          body: jsonEncode(body));
      print(response.body);
      var decodedResponse = json.decode(response.body);
      if (response.statusCode == 200) {
        return decodedResponse["exams"];
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
