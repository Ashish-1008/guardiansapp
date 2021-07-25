import 'dart:convert';

import 'package:guardiansapp/apiconstants.dart';
import 'package:http/http.dart' as http;

class AuthenticationProvider {
  authenticate(phone, password) async {
    try {
      var callUrl = ApiConstants.GUARDIANS_LOGIN;
      var bodyData = {
        "phone": phone,
        "password": password,
      };
      var response = await http.post(Uri.parse(callUrl), body: bodyData);
      var decoded = json.decode(response.body);

      if (response.statusCode == 200) {
        if (decoded["status"] == 1) {
          return decoded;
        } else {
          throw FormatException("${decoded['message']}");
        }
      } else {
        throw FormatException("${decoded['message']}");
      }
    } catch (e) {
      throw e;
    }
  }

  // logout(token) async {
  //   try {
  //     var callUrl = app_config["logout_url"];
  //     var header = {
  //       'Content-type': 'application/json',
  //       'Accept': 'application/json',
  //       'Authorization': 'Bearer $token',
  //     };
  //     var response = await http.post(Uri.parse(callUrl), headers: header);
  //     var decode = json.decode(response.body);
  //     if (response.statusCode == 200) {
  //       if (decode["success"]) {
  //         print(decode);
  //         return decode;
  //       } else {
  //         print("else  " + decode);
  //         throw FormatException("${decode['message']}");
  //       }
  //     } else {
  //       throw FormatException("${decode['message']}");
  //     }
  //   } catch (e) {
  //     throw e;
  //   }
  // }
}
