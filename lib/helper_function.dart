import 'dart:convert';

import 'package:get/get.dart';
import 'package:guardiansapp/screens/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

saveToSharedPreferences(String key, value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var store = prefs.setString(key, json.encode(value));
  print(store);
  return store;
}

getFromSharedPreferences(String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var fetchedData = prefs.getString(key) ?? "_";
  if (key == "response" && fetchedData == "_") {
    Get.off(LoginPage());
  }
  // print("fetched data from shared preference is : $fetchedData");
  return fetchedData;
}

deleteFromSharedPreferences(key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.clear();
}
