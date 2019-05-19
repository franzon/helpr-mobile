import 'package:flutter/material.dart';
import 'package:mobile/pages/splash_screen.dart';
// import 'package:mobile/pages/login/login_page.dart';
import 'package:mobile/utils/constants.dart';
import 'package:mobile/pages/confirmation/send_confirmation_page.dart';
import 'package:mobile/pages/register/endereco.dart';
import 'package:mobile/pages/acitivities.dart';

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
        home: ActivitiesPage(),
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          backgroundColor: colors["backgroundColor"],
          accentColor: colors["accentColor"],
          primaryColor: colors["primaryColor"],
        ));
  }
}
