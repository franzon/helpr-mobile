import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mobile/models/Category.dart';
import 'package:mobile/utils/constants.dart';

class CategoriesApi {
  static Future<List<Category>> getPopularCategories(int count) async {
    // await Future.delayed(Duration(seconds: 2));
    return [
      Category(id: "worker", name: "Pedreiro"),
      Category(id: "painter", name: "Pintor")
    ];
  }

  static Future<List<Category>> getAllCategories() async {
    // await Future.delayed(Duration(seconds: 2));
    return [
      Category(id: "worker", name: "Pedreiro"),
      Category(id: "painter", name: "Pintor"),
      Category(id: "painter", name: "Pintor"),
      Category(id: "painter", name: "Pintor"),
      Category(id: "painter", name: "Pintor"),
      Category(id: "painter", name: "Pintor"),
      Category(id: "painter", name: "Pintor"),
    ];
  }
}
