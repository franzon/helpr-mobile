import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:flutter_keychain/flutter_keychain.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/models/Address.dart';
import 'package:mobile/utils/constants.dart';

class UserApi {
  static Future<Map> getUserInfo({@required String token}) async {
    return await http.get("$apiUrl/user/getUserInfo", headers: {
      "token": token,
    }).then((response) => json.decode(response.body));
  }

  static Future<Map> addUserAddress({@required Address address}) async {
    try {
      final token = await FlutterKeychain.get(key: "token");
      return await http.post(
        "$apiUrl/user/addresses",
        body: {
          "state": address.state,
          "city": address.city,
          "neighborhood": address.neighborhood,
          "street": address.street,
          "number": address.number,
          "complement": address.complement
        },
        headers: {
          "token": token,
        },
      ).then((response) => json.decode(response.body));
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  static Future<Map> getUserAddresses() async {
    try {
      final token = await FlutterKeychain.get(key: "token");
      return await http.get("$apiUrl/user/addresses", headers: {
        "token": token,
      }).then((response) => json.decode(response.body));
    } catch (e) {
      debugPrint(e.toString());
    }

    // return {
    //   "message": "success",
    //   "data": {
    //     "addresses": [
    //       {
    //         "_id": "a",
    //         "street": "Rua Carlos Sumaré",
    //         "neighborhood": "Centro",
    //         "number": "123"
    //       },
    //       {
    //         "_id": "b",
    //         "street": "Rua Daniel Ourivaldo",
    //         "neighborhood": "Cobra",
    //         "number": "321"
    //       }
    //     ]
    //   }
    // };
  }
}
