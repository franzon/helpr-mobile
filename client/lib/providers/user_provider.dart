import 'package:mobile/models/User.dart';
import 'package:rxdart/rxdart.dart';

class UserProvider {
  BehaviorSubject _user = BehaviorSubject.seeded(null);
  Observable get stream$ => _user.stream;

  User get user => _user.value;

  void dispose() => _user.close();
}
