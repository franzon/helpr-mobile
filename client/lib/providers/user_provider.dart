import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keychain/flutter_keychain.dart';
import 'package:meta/meta.dart';
import 'package:mobile/api/auth_api.dart';
import 'package:mobile/api/user_api.dart';
import 'package:mobile/models/User.dart';
import 'package:mobile/pages/home/client_home_page.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rxdart/rxdart.dart';

// enum UserProviderStatus {UNINITIALIZED, LOADING,/}

abstract class UserProvider {
  BehaviorSubject _user = BehaviorSubject.seeded(null);
  Observable get stream$ => _user.stream;

  void dispose() => _user.close();

  User get user;
  void setUser(User user);

  void signIn(BuildContext context,
      {@required String email, @required String password});
}

class UserProviderImplementation extends UserProvider {
  @override
  User get user => _user.value;

  @override
  void setUser(User user) {
    _user.add(user);
  }

  @override
  void signIn(BuildContext context,
      {@required String email, @required String password}) async {
    final result = await AuthApi.signIn(email: email, password: password);

    switch (result["message"]) {
      case "user/provider doesnt exists":
      case "invalid password":
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text(
            "Combinação de email/senha incorreta",
            textAlign: TextAlign.center,
          ),
        ));
        break;

      case "success":
        final token = result["data"]["token"];
        FlutterKeychain.put(key: "token", value: token);

        final userInfo = await UserApi.getUserInfo(token: token);
        final user = User(
            id: userInfo["data"]["_id"],
            name: userInfo["data"]["name"],
            credits: userInfo["data"]["credits"],
            reputation: userInfo["data"]["reputation"]);

        setUser(user);

        Navigator.pushReplacement(
            context,
            PageTransition(
                duration: const Duration(milliseconds: 500),
                type: PageTransitionType.fade,
                child: ClientHomePage()));

        break;
      default:
    }
  }
}
