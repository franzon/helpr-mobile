import 'package:meta/meta.dart';
import 'package:client_v3/models/Address.dart';

class Client {
  String email;
  String name;
  int credits;
  int reputation;
  List<Address> addresses;
  bool isConfirmed;

  Client(
      {@required this.email,
      @required this.name,
      @required this.credits,
      @required this.reputation,
      @required this.addresses,
      @required this.isConfirmed});

  factory Client.clone(Client client) {
    return Client(
        name: client.name,
        email: client.email,
        reputation: client.reputation,
        credits: client.credits,
        addresses: [...client.addresses],
        isConfirmed: client.isConfirmed);
  }
}
