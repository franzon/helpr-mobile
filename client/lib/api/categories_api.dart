import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mobile/models/Activity.dart';
import 'package:mobile/models/Category.dart';
import 'package:mobile/utils/constants.dart';

class CategoriesApi {
  static Future<List<Category>> getPopularCategories(int count) async {
    //= await Future.delayed(Duration(seconds: 2));
    return [
      Category(id: "worker", name: "Pedreiro"),
      Category(id: "painter", name: "Pintor")
    ];
  }

  static Future<List<Category>> getAllCategories() async {
    // await Future.delayed(Duration(seconds: 2));
    return [
      Category(id: "worker", name: "Pedreiro", activities: [
        Activity(
          id: "worker-floor",
          name: "Piso",
        ),
        Activity(id: "worker-wall", name: "Paredes")
      ]),
      Category(id: "painter", name: "Pintor", activities: []),
      Category(id: "ti", name: "Informática", activities: [
        Activity(id: "ti-format", name: "Formatação"),
        Activity(id: "ti-maintenance", name: "Manutenção")
      ]),
      Category(id: "gas-pipe", name: "Encanador", activities: []),
    ];
  }
}
