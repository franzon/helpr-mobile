import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ResultadoCEP {
  String neighborhood;
  String town;
  String street;
  String state;
  String complement;
  String cep;

  ResultadoCEP(String json) {
    Map<String, dynamic> map = jsonDecode(json);
    this.cep = map["cep"];
    this.neighborhood = map["bairro"];
    this.town = map["localidade"];
    this.street = map["logradouro"];
    this.state = map["uf"];
    this.complement = map["complemento"];
  }
}




Future<ResultadoCEP> consultCEP({@required String cep}) async{
  try {
    final response = await http.get("https://viacep.com.br/ws/$cep/json/",
        headers: {"Content-Type": "text/json; charset=utf-8"});
    if (response.statusCode==200){
      return ResultadoCEP(response.body);
    }
    return null;
  } catch (e) {
    print(e);
    return null;
  }

}
