import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:mobile/pages/splash.dart';
import 'package:mobile/pages/login/login_page.dart';
import 'package:mobile/utils/constants.dart';
// import 'package:mobile/pages/login/new_login_page.dart';
import 'package:mobile/pages/service.dart';

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
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: Colors.black,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    );
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
