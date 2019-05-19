import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/blocs/categories_bloc.dart';
import 'package:mobile/blocs/user_bloc.dart';
import 'package:mobile/pages/authentication/authentication_page.dart';
import 'package:mobile/pages/splash.dart';
import 'package:splashscreen/splashscreen.dart';

main() {
  // Stetho.initialize();
  // SystemChrome.setEnabledSystemUIOverlays ([]);

  final UserBloc userBloc = UserBloc();
  final CategoriesBloc categoriesBloc = CategoriesBloc();

  // runApp(BlocProvider(
  //   bloc: userBloc,
  //   child: BlocProvider(bloc: categoriesBloc, child: App()),
  // ));

  runApp(BlocProviderTree(
    blocProviders: [
      BlocProvider<UserBloc>(
        bloc: userBloc,
      ),
      BlocProvider<CategoriesBloc>(
        bloc: categoriesBloc,
      )
    ],
    // child: App(),
    child: App(),
  ));
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Splash(),
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
