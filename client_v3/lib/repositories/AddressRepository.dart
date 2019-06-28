import 'dart:convert';

import 'package:flutter_keychain/flutter_keychain.dart';
import 'package:meta/meta.dart';
import 'package:client_v3/constants/apiUrl.dart';
import 'package:client_v3/models/Address.dart';

import 'package:http/http.dart' as http;

class AddressRepository {
  Future<List<Address>> getClientAddresses() async {}

  Future<void> addClientAddress({@required Address address}) async {
    try {
      final token = await FlutterKeychain.get(key: "token");
      final response = await http.post(apiUrl + "user/addresses", body: {
        "state": address.state,
        "city": address.city,
        "neighborhood": address.neighborhood,
        "street": address.street,
        "number": address.number,
        "complement": address.complement
      }, headers: {
        "token": token
      }).then((res) => json.decode(res.body));

      return true;
    } catch (e) {
      return null;
    }
  }
}
