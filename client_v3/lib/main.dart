import 'package:client_v3/pages/start/Splash.dart';
import 'package:client_v3/setupSingletons.dart';
import 'package:flutter/material.dart';

void main() {
  setupRepositories();
  setupProviders();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          fontFamily: "Montserrat",
          textTheme: TextTheme(
              body1: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16))),
      home: SplashPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
