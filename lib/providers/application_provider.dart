import 'dart:convert';
import 'dart:io';

import 'package:guardiansapp/apiconstants.dart';
import 'package:http/http.dart' as http;

class ApplicationProvider {
  getApplication(token, studentId) async {
    try {
      var header = {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };
      var bodyVar = {
        'student_id': studentId,
      };
      final response = await http.post(Uri.parse(ApiConstants.GET_APPLICATON),
          headers: header, body: jsonEncode(bodyVar));
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

  getApplicationSubjects(token) async {
    try {
      var header = {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };

      final response = await http.post(
        Uri.parse(ApiConstants.GET_APPLICATION_SUBJECT),
        headers: header,
      );
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

  saveApplication(token, data) async {
    try {
      var header = {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };
      var body = {
        'data': data,
      };
      final response = await http.post(Uri.parse(ApiConstants.SAVE_APPLICATION),
          headers: header, body: jsonEncode(body));
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
