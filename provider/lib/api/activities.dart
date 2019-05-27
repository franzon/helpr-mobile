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
<<<<<<< HEAD
        headers: {"Content-Type": "application/json"}, body: json.encode(body));
=======
    body: body);
>>>>>>> d3e1d172c90f34b54fe4e256068f135c670b3bdc

    return response.statusCode;
  }
}
