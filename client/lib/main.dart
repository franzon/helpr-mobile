import 'package:flutter/material.dart';
import 'package:mobile/pages/authentication/authentication_page.dart';
import 'package:mobile/pages/start/splash_page.dart';
import 'package:get_it/get_it.dart';
import 'package:mobile/providers/user_provider.dart';

GetIt getIt = new GetIt();

main() {
  getIt.registerLazySingleton<UserProvider>(() => UserProvider());
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AuthenticationPage(),
      theme: ThemeData(
          fontFamily: "Montserrat",
          textTheme: TextTheme(
            body1: TextStyle(color: Colors.white),
          ),
          iconTheme: IconThemeData(color: Colors.white)),
      debugShowCheckedModeBanner: false,
    );
  }
}
