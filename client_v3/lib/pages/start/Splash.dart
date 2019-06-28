import 'package:flutter/material.dart';
import 'package:flutter_keychain/flutter_keychain.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:client_v3/constants/ui.dart';
import 'package:client_v3/pages/authentication/Authentication.dart';
import 'package:client_v3/pages/home/Home.dart';
import 'package:client_v3/providers/ClientProvider.dart';
import 'package:client_v3/setupSingletons.dart';
import 'package:page_transition/page_transition.dart';

class SplashPage extends StatelessWidget {
  final clientProvider = getIt.get<ClientProvider>();

  @override
  Widget build(BuildContext context) {
    new Future.delayed(const Duration(seconds: 2), () async {
      try {
        final token = await FlutterKeychain.get(key: "token");
        if (token != null) {
          await clientProvider.loadClient();

          Navigator.pushReplacement(
              context,
              PageTransition(
                  duration: const Duration(milliseconds: 500),
                  type: PageTransitionType.fade,
                  child: HomePage()));
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
      backgroundColor: colors["background"],
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
                    color: colors["primary"],
                    fontSize: 55),
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: Center(
              child: SpinKitWave(
                color: colors["primary"],
                size: 28,
              ),
            ),
          )
        ],
      ),
    );
  }
}
