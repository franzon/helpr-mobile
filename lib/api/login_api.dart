import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mobile/utils/constants.dart';

class UserApi {
  static Future<Map> getUser(String email) async {
     await new Future.delayed(const Duration(seconds: 2)); //recommend

    final response = await http.get("$apiUrl/auth/get-user/$email");
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
}
