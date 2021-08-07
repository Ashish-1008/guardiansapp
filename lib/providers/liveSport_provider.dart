import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../apiconstants.dart';

class LiveSportProvider {
  getLiveSports(token) async {
    try {
      var header = {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };

      final response = await http.post(
        Uri.parse(ApiConstants.GET_LIVE_SPORTS),
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
}
