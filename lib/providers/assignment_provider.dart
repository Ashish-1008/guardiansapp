import 'dart:convert';
import 'dart:io';

import 'package:guardiansapp/apiconstants.dart';
import 'package:http/http.dart' as http;

class AssignmentProvider {
  getAssignment(token, studentId) async {
    try {
      var header = {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };
      var bodyVar = {
        'student_id': studentId,
      };
      final response = await http.post(
          Uri.parse(ApiConstants.GET_STUDENT_ASSIGNMENTS),
          headers: header,
          body: jsonEncode(bodyVar));
      print(response.body);
      var decodedResponse = json.decode(response.body);
      if (response.statusCode == 200) {
        return decodedResponse;
      } else {
        var error = {
          "success": 0,
          'message': 'Unable to load data',
        };
        return error;
      }
    } catch (e) {
      if (e is SocketException) {
        throw SocketException("$e");
      }
      throw Exception(e);
    }
  }
}
