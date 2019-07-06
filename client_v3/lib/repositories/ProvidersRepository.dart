import 'dart:convert';

import 'package:client_v3/constants/apiUrl.dart';
import 'package:flutter_keychain/flutter_keychain.dart';
import 'package:meta/meta.dart';
import 'package:client_v3/models/Category.dart';
import 'package:client_v3/models/Provider.dart';

import 'package:http/http.dart' as http;

class ProvidersRepository {
  Future<List<Provider>> getNearbyProviders(
      {@required Category category,
      @required double latitude,
      @required double longitude,
      @required int maxDistance}) async {
    final token = await FlutterKeychain.get(key: "token");

    final response = await http.get(apiUrl + "provider/category",
        headers: {"token": token}).then((res) => json.decode(res.body));

    return List.from(response["data"])
        .map((provider) => Provider(
            category: Category(id: "plumber", name: "Encanador"),
            comments: [],
            id: provider["_id"],
            serviceDescription: provider["serviceDescription"],
            minServicePrice: provider["minServicePrice"],
            maxServicePrice: provider["maxServicePrice"],
            profilePictureUrl: provider["profilePictureUrl"],
            isOnline: true,
            name: provider["name"],
            reputation: 0,
            serviceCount: 0))
        .toList();

    // return [
    //   Provider(
    //       id: "1",
    //       name: "Pedro",
    //       reputation: 500,
    //       serviceCount: 45,
    //       comments: [
    //         ProviderComment(clientName: "Jorge", text: "Bom e barato!")
    //       ],
    //       isOnline: true,
    //       profilePictureUrl: "https://randomuser.me/api/portraits/men/89.jpg",
    //       category: Category(id: "builder", name: "Pedreiro"),
    //       serviceDescription:
    //           "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
    //       minServicePrice: 1,
    //       maxServicePrice: 10),
    //   Provider(
    //       id: "1",
    //       name: "João",
    //       reputation: 400,
    //       serviceCount: 23,
    //       comments: [],
    //       isOnline: true,
    //       profilePictureUrl: "https://randomuser.me/api/portraits/men/34.jpg",
    //       category: Category(id: "builder", name: "Pedreiro"),
    //       serviceDescription:
    //           "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
    //       minServicePrice: 10,
    //       maxServicePrice: 20),
    //   Provider(
    //       id: "1",
    //       name: "Carlos",
    //       reputation: 300,
    //       serviceCount: 12,
    //       comments: [],
    //       isOnline: true,
    //       profilePictureUrl: "https://randomuser.me/api/portraits/men/49.jpg",
    //       category: Category(id: "builder", name: "Pedreiro"),
    //       serviceDescription:
    //           "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
    //       minServicePrice: 1,
    //       maxServicePrice: 10),
    //   Provider(
    //       id: "2",
    //       name: "John",
    //       reputation: 140,
    //       serviceCount: 5,
    //       comments: [ProviderComment(clientName: "Jorge", text: "Muito bom!")],
    //       isOnline: false,
    //       profilePictureUrl: "https://randomuser.me/api/portraits/men/0.jpg",
    //       category: Category(id: "builder", name: "Pedreiro"),
    //       serviceDescription:
    //           "There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn't anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem Ipsum which looks reasonable. The generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc.",
    //       minServicePrice: 1,
    //       maxServicePrice: 10)
    // ];
  }
}
