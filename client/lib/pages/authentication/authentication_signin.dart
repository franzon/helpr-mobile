import 'package:flutter/material.dart';
// import 'package:flutter_keychain/flutter_keychain.dart';
// import 'package:mobile/api/auth_api.dart';
// import 'package:mobile/pages/authentication/authentication_page.dart';
// import 'package:mobile/pages/home/client_home_page.dart';
// import 'package:mobile/utils/constants.dart';
// import 'package:page_transition/page_transition.dart';
// import 'package:provider/provider.dart';

class AuthenticationSignInForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("a"),
    );
  }
}

// class AuthenticationSignInForm extends StatelessWidget {
//   const AuthenticationSignInForm({
//     Key key,
//   }) : super(key: key);

//   Future<void> showErrorSnack(BuildContext context, String error) {
//     Scaffold.of(context).showSnackBar(new SnackBar(
//       backgroundColor: Colors.red,
//       content: Text(error),
//     ));
//   }

//   void signIn(BuildContext context, String email, String password) async {
//     final Map response = await AuthApi.signIn(email, password);
//     if (response != null) {
//       debugPrint(response.toString());
//       // FlutterKeychain.put(key: "token", value: response["data"]["token"]);
//       if (response["message"] == "success") {
//         Navigator.pushReplacement(
//             context,
//             PageTransition(
//                 type: PageTransitionType.leftToRight,
//                 alignment: Alignment.bottomCenter,
//                 child: ClientHomePage()));
//       } else if (response["message"] == "invalid password") {
//         this.showErrorSnack(context, "Senha incorreta");
//       }
//     } else {
//       // todo: show alert
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final RegExp emailRegex = new RegExp(
//         r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

//     return Stack(
//       children: [
//         Column(
//           children: <Widget>[
//             Expanded(
//               flex: 3,
//               child: Form(
//                 key: Provider.of<AuthenticationScreenModel>(context)
//                     .signInFormKey,
//                 child: Padding(
//                   padding: const EdgeInsets.all(30.0),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: <Widget>[
//                       TextFormField(
//                         controller:
//                             Provider.of<AuthenticationScreenModel>(context)
//                                 .signInEmailController,
//                         keyboardType: TextInputType.emailAddress,
//                         validator: (value) {
//                           if (value.isEmpty || !emailRegex.hasMatch(value)) {
//                             return "Email inválido";
//                           }
//                         },
//                         style: TextStyle(
//                             color: Colors.white,
//                             fontFamily: "Montserrat",
//                             fontWeight: FontWeight.bold,
//                             fontSize: 12),
//                         decoration: InputDecoration(
//                             hintText: "Email",
//                             hintStyle: TextStyle(
//                                 color: Colors.white,
//                                 fontFamily: "Montserrat",
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 12),
//                             prefixIcon: Icon(
//                               Icons.email,
//                               color: colors["primaryColor"],
//                             ),
//                             border: UnderlineInputBorder(
//                                 borderSide:
//                                     BorderSide(color: colors["primaryColor"])),
//                             enabledBorder: UnderlineInputBorder(
//                                 borderSide:
//                                     BorderSide(color: colors["primaryColor"])),
//                             focusedBorder: UnderlineInputBorder(
//                                 borderSide:
//                                     BorderSide(color: colors["primaryColor"]))),
//                       ),
//                       TextFormField(
//                         controller:
//                             Provider.of<AuthenticationScreenModel>(context)
//                                 .signInPasswordController,
//                         obscureText: true,
//                         validator: (value) {
//                           if (value.isEmpty) {
//                             return "Digite a senha";
//                           }
//                         },
//                         style: TextStyle(
//                             color: Colors.white,
//                             fontFamily: "Montserrat",
//                             fontWeight: FontWeight.bold,
//                             fontSize: 12),
//                         decoration: InputDecoration(
//                             hintText: "Senha",
//                             hintStyle: TextStyle(
//                                 color: Colors.white,
//                                 fontFamily: "Montserrat",
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 12),
//                             prefixIcon: Icon(
//                               Icons.lock,
//                               color: colors["primaryColor"],
//                             ),
//                             border: UnderlineInputBorder(
//                                 borderSide:
//                                     BorderSide(color: colors["primaryColor"])),
//                             enabledBorder: UnderlineInputBorder(
//                                 borderSide:
//                                     BorderSide(color: colors["primaryColor"])),
//                             focusedBorder: UnderlineInputBorder(
//                                 borderSide:
//                                     BorderSide(color: colors["primaryColor"]))),
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             Expanded(
//               flex: 1,
//               child: Container(
//                 color: colors["backgroundColor"],
//               ),
//             )
//           ],
//         ),
//         Align(
//           alignment: Alignment.center,
//           child: Container(
//               margin: EdgeInsets.only(left: 80, right: 80, top: 200),
//               height: 60,
//               decoration: BoxDecoration(
//                   color: colors["primaryColor"],
//                   borderRadius: BorderRadius.circular(5)),
//               child: Material(
//                 color: Colors.transparent,
//                 child: InkWell(
//                   onTap: () {
//                     if (Provider.of<AuthenticationScreenModel>(context)
//                         .signInFormKey
//                         .currentState
//                         .validate()) {
//                       final String email =
//                           Provider.of<AuthenticationScreenModel>(context)
//                               .signInEmailController
//                               .text;
//                       final String password =
//                           Provider.of<AuthenticationScreenModel>(context)
//                               .signInPasswordController
//                               .text;

//                       this.signIn(context, email, password);
//                     }
//                   },
//                   child: Center(
//                       child: Text(
//                     "Entrar",
//                     style: TextStyle(
//                         color: Colors.white,
//                         fontFamily: "Montserrat",
//                         fontWeight: FontWeight.bold,
//                         fontSize: 16),
//                   )),
//                 ),
//               )),
//         )
//       ],
//     );
//   }
// }
