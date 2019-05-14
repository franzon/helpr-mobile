import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mobile/utils/constants.dart';

class UserApi {
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
        .post("$apiUrl/autheentication/signin", body: {email: email, password: password})
        .then(
            (response) => response.statusCode == 200 ? response : throw Error())
        .then((response) => json.decode(response.body))
        .catchError((onError) => null);
  }
}
