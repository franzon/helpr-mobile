import 'package:flutter/material.dart';
import 'package:flutter_keychain/flutter_keychain.dart';
import 'dart:async';
import 'package:splashscreen/splashscreen.dart';
import 'package:mobile/utils/constants.dart';
import 'package:mobile/pages/login/login_page.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => new _SplashState();
}

class _SplashState extends State<Splash> {
  String _token = 'Unknown';
  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<Widget> initPlatformState() async {
    try {
      var token = await FlutterKeychain.get(key: "token");

      setState(() {
        if (null == token) {
          _token = "Unknown";
        } else {
          _token = token;
        }
      });
    } on Exception catch (err) {
      print("Exception: " + err.toString());
    }
    return null;
  }

  Widget build(BuildContext context) {
    return SplashScreen(
        seconds: 3,
        navigateAfterSeconds: _token == 'Unknown' ? LoginPage() : null,
        title: Text(
          'helpr',
          style: TextStyle(
              fontWeight: FontWeight.w200,
              fontSize: 55.0,
              color: colors["accentColor"],
              fontFamily: 'Roboto-Regular'),
        ),
        backgroundColor: colors["backgroundColor"],
        styleTextUnderTheLoader: TextStyle(),
        loaderColor: colors["primaryColor"]);
  }
}
