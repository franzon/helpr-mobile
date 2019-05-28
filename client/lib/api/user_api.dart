import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/utils/constants.dart';

class UserApi {
  static Future<Map> getUserInfo({@required String token}) async {
    return await http.get("$apiUrl/user/getUserInfo", headers: {
      "token": token,
    }).then((response) => json.decode(response.body));
  }
}
