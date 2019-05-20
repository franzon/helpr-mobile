import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mobile/utils/constants.dart';

class CategoryApi {
  static Future<List> getCategory() async {
    final response = await http.get("$apiUrl/categories/getCategories/");
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
