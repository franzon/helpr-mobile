import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/utils/constants.dart';

class AuthApi {
  static Future<Map> getUser(String email) async {
    final response = await http.get("$apiUrl/user/getUserNameByEmail/$email");
    final responseJson = json.decode(response.body);

    if (response.statusCode == 200) {
      if (responseJson["data"] == null) {
        return {"name": null};
      }
      return {"name": responseJson["data"]["name"]};
    } else {
      return null;
    }
  }

  static Future<Map> signIn(String email, String password) async {
    return await http
        .post("$apiUrl/authentication/login/user",
            body: {"email": email, "password": password})
        .then(
            (response) => response.statusCode == 200 ? response : throw Error())
        .then((response) => json.decode(response.body))
        .catchError((onError) => null);
  }

  static Future<Map> signUp(String name, String email, String password) async {
    return await http
        .post("$apiUrl/user/createUser",
            body: {"name": name, "email": email, "password": password})
        .then(
            (response) => response.statusCode == 200 ? response : throw Error())
        .then((response) => json.decode(response.body))
        .catchError((onError) => null);
  }
}
