import 'package:flutter/material.dart';
import 'package:flutter_keychain/flutter_keychain.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mobile/api/user_api.dart';
import 'package:mobile/main.dart';
import 'package:mobile/models/User.dart';
import 'package:mobile/pages/authentication/authentication_page.dart';
import 'package:mobile/pages/home/client_home_page.dart';
import 'package:mobile/providers/user_provider.dart';
import 'package:mobile/utils/constants.dart';
import 'package:page_transition/page_transition.dart';

class SplashPage extends StatelessWidget {
  final userProvider = getIt.get<UserProvider>();

  @override
  Widget build(BuildContext context) {
    new Future.delayed(const Duration(seconds: 2), () async {
      try {
        final token = await FlutterKeychain.get(key: "token");
        if (token != null) {
          final userInfo = await UserApi.getUserInfo(token: token);
          final user = User(
              id: userInfo["data"]["_id"],
              name: userInfo["data"]["name"],
              credits: userInfo["data"]["credits"],
              reputation: userInfo["data"]["reputation"]);

          userProvider.setUser(user);

          Navigator.pushReplacement(
              context,
              PageTransition(
                  duration: const Duration(milliseconds: 500),
                  type: PageTransitionType.fade,
                  child: ClientHomePage()));
        } else {
          Navigator.pushReplacement(
              context,
              PageTransition(
                  duration: const Duration(milliseconds: 500),
                  type: PageTransitionType.fade,
                  child: AuthenticationPage()));
        }
      } catch (e) {}
    });

    return Scaffold(
      resizeToAvoidBottomPadding: true,
      resizeToAvoidBottomInset: true,
      backgroundColor: colors["backgroundColor"],
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            flex: 10,
            child: Center(
              child: Text(
                "helpr",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: colors["primaryColor"],
                    fontSize: 55),
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: Center(
              child: SpinKitWave(
                color: colors["primaryColor"],
                size: 28,
              ),
            ),
          )
        ],
      ),
    );
  }
}
