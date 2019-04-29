import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mobile/utils/constants.dart';

class UserApi {
  static Future<Map> sendCode(String email) async {
    return await http
        .post("$apiUrl/authentication/email/sendConfirmationCode",
            body: {email: email})
        .then(
            (response) => response.statusCode == 200 ? response : throw Error())
        .then((response) => json.decode(response.body))
        .catchError((onError) => null);
  }

  static Future<Map> confirmCode(String email, String confirmationCode) async {
    return await http
        .post("$apiUrl/authentication/email/confirmEmail",
            body: {email: email, confirmationCode: confirmationCode})
        .then(
            (response) => response.statusCode == 200 ? response : throw Error())
        .then((response) => json.decode(response.body))
        .catchError((onError) => null);
  }
}
