import 'package:flutter/material.dart';
import 'package:mobile/pages/splash.dart';
// import 'package:mobile/pages/login/login_page.dart';
import 'package:mobile/utils/constants.dart';
import 'package:mobile/pages/login/new_login_page.dart';

main() {
  // Stetho.initialize();
  // SystemChrome.setEnabledSystemUIOverlays ([]);
  runApp(
    App(),
  );
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: LoginPage(),
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          backgroundColor: colors["backgroundColor"],
          accentColor: colors["accentColor"],
          primaryColor: colors["primaryColor"],
        ));
  }
}
