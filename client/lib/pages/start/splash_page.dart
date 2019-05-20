// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:flutter_keychain/flutter_keychain.dart';
// import 'package:mobile/pages/authentication/authentication_page.dart';
// import 'package:mobile/pages/home/client_home_page.dart';
// import 'package:mobile/utils/constants.dart';
// import 'package:splashscreen/splashscreen.dart';

// class Splash extends StatefulWidget {
//   @override
//   _SplashState createState() => new _SplashState();
// }

// class _SplashState extends State<Splash> {
//   String _token = 'Unknown';
//   @override
//   void initState() {
//     super.initState();
//     initPlatformState();
//   }

//   Future<Widget> initPlatformState() async {
//     try {
//       var token = await FlutterKeychain.get(key: "token");

//       setState(() {
//         if (null == token) {
//           _token = "Unknown";
//         } else {
//           _token = token;
//         }
//       });
//     } on Exception catch (err) {
//       print("Exception: " + err.toString());
//     }
//     return null;
//   }

//   Widget build(BuildContext context) {
//     return SplashScreen(
//         seconds: 2,
//         navigateAfterSeconds:
//             _token == 'Unknown' ? AuthenticationPage() : ClientHomePage(),
//         title: Text(
//           'helpr',
//           style: TextStyle(
//               fontWeight: FontWeight.w200,
//               fontSize: 55.0,
//               color: colors["primaryColor"],
//               fontFamily: 'Montserrat'),
//         ),
//         backgroundColor: colors["backgroundColor"],
//         styleTextUnderTheLoader: TextStyle(),
//         loaderColor: colors["primaryColor"]);
//   }
// }
