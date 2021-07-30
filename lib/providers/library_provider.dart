import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../apiconstants.dart';

class BookProvider {
  Future getBooks(token, studentId, dataType) async {
    try {
      var body = {'student_id': studentId, 'data_type': dataType};
      var header = {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };
      final response = await http.post(
          Uri.parse("${ApiConstants.GET_LIBRARY_INFO}"),
          headers: header,
          body: jsonEncode(body));
      print(response.body);
      var decodedResponse = json.decode(response.body);
      if (response.statusCode == 200) {
        return decodedResponse["books"];
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
