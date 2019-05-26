import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mobile/utils/constants.dart';

class ActivityApi {
  static Future<int> sendActivities(String email, List activities) async {
    Map<String, dynamic> body = {
      "email": email,
      "activities": activities
    };

    final response = await http.post("$apiUrl/provider/category",
        headers: {"Content-Type": "application/json"}, body: json.encode(body));

    return response.statusCode;
  }
}
