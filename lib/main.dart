import 'package:flutter/material.dart';
import 'package:flutter_stetho/flutter_stetho.dart';
import 'package:mobile/routes.dart';
import 'package:mobile/utils/constants.dart';

main() {
  // Stetho.initialize();
  runApp(
    App(),
  );
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        initialRoute: '/',
        routes: routes,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          backgroundColor: colors["backgroundColor"],
          accentColor: colors["accentColor"],
          primaryColor: colors["primaryColor"],
        ));
  }
}
