import 'package:flutter_keychain/flutter_keychain.dart';
import 'package:client_v3/models/Address.dart';
import 'package:client_v3/models/Client.dart';
import 'package:client_v3/repositories/AddressRepository.dart';
import 'package:client_v3/repositories/ClientRepository.dart';
import 'package:client_v3/setupSingletons.dart';
import 'package:rxdart/subjects.dart';

class ClientProvider {
  final clientRepository = getIt<ClientRepository>();
  final addressRepository = getIt<AddressRepository>();

  final _model = BehaviorSubject<Client>.seeded(null);
  Stream<Client> get client => _model.stream;

  Client get value => _model.value;

  Future<void> loadClient() async {
    final client = await clientRepository.getClient();
    _model.add(client);
  }

  void addAddress(Address address) async {
    final client = Client.clone(_model.value);
    client.addresses = [...client.addresses, address];
    _model.add(client);

    await addressRepository.addClientAddress(address: address);
    loadClient();
  }

  // void loadClientAddresses() async {
  //   final newClient = Client.clone(_model.value);
  //   newClient.addresses = await addressRepository.getClientAddresses();
  //   _model.add(newClient);
  // }
}
