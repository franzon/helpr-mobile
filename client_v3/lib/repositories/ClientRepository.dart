import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_keychain/flutter_keychain.dart';
import 'package:meta/meta.dart';
import 'package:client_v3/constants/apiUrl.dart';
import 'package:client_v3/models/Address.dart';
import 'package:client_v3/models/Client.dart';
import 'package:http/http.dart' as http;

class ClientRepository {
  Future<String> signIn(
      {@required String email, @required String password}) async {
    try {
      final response = await http.post(apiUrl + "authentication/login/user",
          body: {
            "email": email,
            "password": password
          }).then((res) => json.decode(res.body));

      return response["data"]["token"];
    } catch (e) {
      return null;
    }
  }

  Future<dynamic> signUp(
      {@required String email,
      @required String name,
      @required String password}) async {
    try {
      final response = await http.post(apiUrl + "user/createUser", body: {
        "email": email,
        "password": password,
        "name": name
      }).then((res) => json.decode(res.body));

      return response;
    } catch (e) {
      return null;
    }
  }

  Future<Client> getClient() async {
    try {
      final token = await FlutterKeychain.get(key: "token");
      final response = await http.get(apiUrl + "user/getUserInfo",
          headers: {"token": token}).then((res) => json.decode(res.body));

      return Client(
          name: response["data"]["name"],
          email: response["data"]["email"],
          reputation: response["data"]["reputation"],
          credits: response["data"]["credits"],
          addresses: List<Address>.from(response["data"]["addresses"].map(
              (addr) => Address(
                  state: addr["state"],
                  city: addr["city"],
                  neighborhood: addr["neighborhood"],
                  street: addr["street"],
                  number: addr["number"],
                  complement: addr["complement"]))));
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }

    // return Client(
    //     name: "Jorgdd",
    //     addresses: [
    //       Address(
    //           state: "Paraná",
    //           city: "Campo Mourão",
    //           neighborhood: "Centro",
    //           street: "Rua São José",
    //           number: "100"),
    //       Address(
    //           state: "Paraná",
    //           city: "Campo Mourão",
    //           neighborhood: "Centro",
    //           street: "Rua São José",
    //           number: "100")
    //     ],
    //     credits: 0,
    //     email: "a",
    //     reputation: 0);
  }
}
