import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mobile/utils/constants.dart';

class CategoriesApi {
  static Future<Map> getPopularCategories(/* int count */) async {
    return await http
        .get(
          "$apiUrl/categories/getCategories", /* headers: {
      "token": token,
    } */
        )
        .then((response) => json.decode(response.body));
  }

  static Future<Map> getAllCategories() async {}
}
