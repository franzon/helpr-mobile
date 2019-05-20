import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mobile/utils/constants.dart';

class ActivityApi {
  static Future<List> sendActivities(String email, List activities) async {


    String activitiesJson = json.encode([
      {
        "category": "N",
        "title": "Azulejista 2",
        "description": "Arrumo azulejo 2",
        "price": "12345"
      }
    ]);


    print(activitiesJson);

    Map body = {
      "email": "carlos@sumare.com",
      "activities": activities,
    };

    final response = await http.post("$apiUrl/provider/category",
    headers: {
      "Accept": "application/json"
    },
    body: body);

    print(response.statusCode);
    return null;
  }
}
