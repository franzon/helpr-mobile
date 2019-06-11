import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/utils/constants.dart';

class AuthApi {
  static Future<Map> signIn(
      {@required String email, @required String password}) async {
    return await http.post("$apiUrl/authentication/login/user", body: {
      "email": email,
      "password": password
    }).then((response) => json.decode(response.body));
  }

  static Future<Map> signUp(
      {@required String name,
      @required String email,
      @required String password}) async {
    return await http.post("$apiUrl/user/createUser", body: {
      "name": name,
      "email": email,
      "password": password
    }).then((response) => json.decode(response.body));
  }
}
