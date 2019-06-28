import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_keychain/flutter_keychain.dart';
import 'package:client_v3/constants/apiUrl.dart';
import 'package:client_v3/models/Category.dart';

import 'package:http/http.dart' as http;

class CategoriesRepository {
  Future<List<Category>> getCategories() async {
    try {
      final token = await FlutterKeychain.get(key: "token");
      final response = await http.get(apiUrl + "categories/getCategories",
          headers: {"token": token}).then((res) => json.decode(res.body));

      return List<Category>.from(response["data"].map((category) =>
          Category(id: category["identifier"], name: category["title"])));
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
    // just to show the loading spinner
    // await Future.delayed(const Duration(seconds: 1));
    // return [
    //   Category(id: "builder", name: "Pedreiro"),
    //   Category(id: "plumber", name: "Encanador")
    // ];
  }
}
