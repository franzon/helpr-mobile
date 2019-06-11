import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mobile/utils/constants.dart';

Future<Map> registration(Map infos) async {

  print(json.encode(infos));

  final response = await http.post("$apiUrl/provider/", body: {
    "email": infos["email"],
    "password": infos["password"],
    "name": infos["name"],
    "cpf": infos["cpf"],
    "cep": infos["cep"],
    "address": infos["address"],
    "numberAddress": infos["numberAddress"],
    "phoneNumber": "(44)99999-1234",
    "neighborhood": infos["neighborhood"],
  });

  if (response.statusCode == 200) {
    return json.decode(response.body);
  } 

  return null;
}
