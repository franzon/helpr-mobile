import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mobile/utils/constants.dart';

class ActivityApi {
  static Future<List> sendActivities(String email, List activities) async {
    print(email);
    print(activities);
    final response = await http.post("$apiUrl/provider/category", body: {
      "email": email,
      "activities": json.encode(activities),
    });
    final responseJson = json.decode(response.body);

    if (response.statusCode == 200) {
      if (responseJson["data"] == null) {
        return null;
      }
      return responseJson["data"];
    } else {
      return null;
    }
  }
}
