import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/blocs/user_bloc.dart';
import 'package:mobile/pages/home/client_home_page.dart';
import 'package:mobile/pages/splash_screen.dart';
// import 'package:bloc/bloc.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import 'package:mobile/pages/login/login_page.dart';
import 'package:mobile/utils/constants.dart';

main() {
  // Stetho.initialize();
  // SystemChrome.setEnabledSystemUIOverlays ([]);

  final UserBloc userBloc = UserBloc();
  runApp(BlocProvider(
    bloc: userBloc,
    child: App(),
  ));
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ClientHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
