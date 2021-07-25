import 'dart:io';
import 'package:guardiansapp/apiconstants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class EventProvider {
  Future fetchEvent(token, studentId) async {
    try {
      var body = {
        'student_id': studentId,
      };

      final response = await http.post(Uri.parse(ApiConstants.GUARDIANS_EVENTS),
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
            HttpHeaders.authorizationHeader: "Bearer $token",
            HttpHeaders.ACCEPT: "application/json",
          },
          body: jsonEncode(body));
      var decodedResponse = json.decode(response.body);
      if (response.statusCode == 200) {
        return decodedResponse["events"];
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
