import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mobile/utils/constants.dart';

Future<Map> registration(Map infos) async {
  var email;
  var password;
  var name;
  var cpf;
  var cep;
  var address;
  var numberAddress;
  var neighborhood;
  var phoneNumber;
  
  return await http
      .post("$apiUrl/provider/", body: {
        email: infos["email"],
        password: infos["password"],
        name: infos["name"],
        cpf: infos["cpf"],
        cep: infos["cep"],
        address: infos["address"],
        numberAddress: infos["numberAddress"],
        phoneNumber: infos["phoneNumber"],
        neighborhood: infos["neighborhood"],
      })
      .then((response) => response.statusCode == 200 ? response : throw Error())
      .then((response) => json.decode(response.body))
      .catchError((onError) => null);
}
