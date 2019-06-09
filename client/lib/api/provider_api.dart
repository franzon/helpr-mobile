import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/utils/constants.dart';

class ProviderApi {
  static Future<Map> getNearbyProviders(
      {@required String category,
      @required double clientLatitude,
      @required double clientLongitude,
      @required int maxDistance}) async {
    // return await http.post("$apiUrl/provider/nearby", body: {
    //   "category": category,
    //   "clientLatitude": clientLatitude,
    //   "clientLongitude": clientLongitude,
    //   "maxDistance": maxDistance
    // }).then((response) => json.decode(response.body));

    return {
      "message": "success",
      "data": [
        {
          "_id": "a",
          "name": "Carlos Sumaré",
          "reputation": 3000,
          "serviceCount": 75,
          "comments": [
            {"name": "Oia pão", "text": "Ave o pão"}
          ],
          "isOnline": true,
          "profilePicture": "https://randomuser.me/api/portraits/men/61.jpg",
        },
        {
          "_id": "b",
          "name": "Jorel",
          "reputation": 2000,
          "serviceCount": 45,
          "isOnline": true,
          "comments": [
            {"name": "jorel", "text": "Mucho very well"}
          ],
          "profilePicture": "https://randomuser.me/api/portraits/men/40.jpg",
        },
        {
          "_id": "c",
          "name": "Michael Jackson",
          "reputation": 1333,
          "isOnline": false,
          "serviceCount": 23,
          "comments": [],
          "profilePicture": "https://randomuser.me/api/portraits/men/5.jpg",
        }
      ]
    };
  }
}
