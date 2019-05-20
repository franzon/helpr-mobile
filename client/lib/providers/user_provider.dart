import 'package:flutter/widgets.dart';
import 'package:mobile/api/user_api.dart';
import 'package:mobile/models/User.dart';

enum UserStatus { Uninitialized, Loading, Loaded }

class UserProvider with ChangeNotifier {
  User _user;
  UserStatus _status;

  UserProvider() {
    this._user = null;
    this._status = UserStatus.Uninitialized;
  }

  User get user => this._user;
  UserStatus get status => this._status;

  Future<void> loadUser() async {
    this._status = UserStatus.Loading;
    notifyListeners();

    final User user = await UserApi.getUserInfo();
    this._user = user;
    this._status = UserStatus.Loaded;
    notifyListeners();
  }
}
