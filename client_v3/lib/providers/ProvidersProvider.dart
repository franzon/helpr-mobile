import 'package:meta/meta.dart';
import 'package:client_v3/models/Category.dart';
import 'package:client_v3/models/Provider.dart';
import 'package:client_v3/repositories/ProvidersRepository.dart';
import 'package:client_v3/setupSingletons.dart';
import 'package:rxdart/subjects.dart';

class ProvidersProvider {
  final providersRepository = getIt<ProvidersRepository>();

  final _model = BehaviorSubject<List<Provider>>.seeded(null);
  Stream<List<Provider>> get providers => _model.stream;

  void loadNearbyProviders(
      {@required Category category,
      @required double latitude,
      @required double longitude,
      @required int maxDistance}) async {
    final nearbyProviders = await providersRepository.getNearbyProviders(
        category: category,
        latitude: latitude,
        longitude: longitude,
        maxDistance: maxDistance);

    _model.add(nearbyProviders);
  }
}
