import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mobile/pages/start/splash_page.dart';
import 'package:mobile/providers/user_provider.dart';

GetIt getIt = new GetIt();

main() {
  getIt.registerLazySingleton<UserProvider>(() => UserProviderImplementation());
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashPage(),
      theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: "Montserrat",
          textTheme: TextTheme(
            body1: TextStyle(color: Colors.white),
          ),
          iconTheme: IconThemeData(color: Colors.white)),
      debugShowCheckedModeBanner: false,
    );
  }
}
