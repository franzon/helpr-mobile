import 'package:flutter/widgets.dart';

class ProviderApi {
  // static Future<Map> getProviderDetails({@required String providerId}) async {
  //   // return await http
  //   //     .get(
  //   //       "$apiUrl/provider/details/" +
  //   //           providerId
  //   //               .toString(), /* headers: {
  //   //   "token": token,
  //   // } */
  //   //     )
  //   //     .then((response) => json.decode(response.body));

  //   return {
  //     "message": "success",
  //     "data": {
  //       "_id": "a",
  //       "name": "Jorel",

  //     }
  //   };
  // }

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
          "profilePictureUrl": "https://randomuser.me/api/portraits/men/61.jpg",
          "serviceDescription": "lorem isum blablabla",
          "minServicePrice": 50,
          "maxServicePrice": 2000,
          "categoryName": "Encanador"
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
          "profilePictureUrl": "https://randomuser.me/api/portraits/men/40.jpg",
          "serviceDescription": "lorem isum blablabla",
          "minServicePrice": 10,
          "maxServicePrice": 500,
          "categoryName": "Encanador"
        },
        {
          "_id": "c",
          "name": "Michael Jackson",
          "reputation": 1333,
          "isOnline": false,
          "serviceCount": 23,
          "comments": [],
          "profilePictureUrl": "https://randomuser.me/api/portraits/men/5.jpg",
          "serviceDescription": "lorem isum blablabla",
          "minServicePrice": 20,
          "maxServicePrice": 100,
          "categoryName": "Encanador"
        }
      ]
    };
  }
}
