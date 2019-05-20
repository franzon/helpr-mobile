import 'package:flutter/material.dart';
// import 'package:mobile/api/auth_api.dart';
// import 'package:mobile/pages/authentication/authentication_confirmation.dart';
// import 'package:mobile/pages/authentication/authentication_page.dart';
// import 'package:mobile/pages/home/client_home_page.dart';
// import 'package:mobile/utils/constants.dart';
// import 'package:page_transition/page_transition.dart';
// import 'package:provider/provider.dart';

class AuthenticationSignUpForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

// class AuthenticationSignUpForm extends StatelessWidget {
//   const AuthenticationSignUpForm({
//     Key key,
//   }) : super(key: key);

//   Future<void> showErrorSnack(BuildContext context, String error) {
//     Scaffold.of(context).showSnackBar(new SnackBar(
//       backgroundColor: Colors.red,
//       content: Text(error),
//     ));
//   }

//   void signUp(
//       BuildContext context, String name, String email, String password) async {
//     final Map response = await AuthApi.signUp(name, email, password);
//     debugPrint(response.toString());
//     if (response != null) {
//       if (response["message"] == "user created") {
//         Navigator.pushReplacement(
//             context,
//             PageTransition(
//                 type: PageTransitionType.leftToRight,
//                 alignment: Alignment.bottomCenter,
//                 child: AuthenticationConfirmationPage()));
//       } else if (response["message"] == "user already exists") {
//         this.showErrorSnack(context, "Email já está sendo utilizado.");
//       } else {
//         this.showErrorSnack(
//             context, "Erro ao criar usuário. Verifique os campos.");
//       }
//     } else {}
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
//                     .signUpFormKey,
//                 child: Padding(
//                   padding: const EdgeInsets.only(
//                       left: 30.0, right: 30, bottom: 30.0),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: <Widget>[
//                       TextFormField(
//                         controller:
//                             Provider.of<AuthenticationScreenModel>(context)
//                                 .signUpNameController,
//                         validator: (value) {
//                           if (value.isEmpty) {
//                             return "Digite um nome";
//                           }
//                         },
//                         style: TextStyle(
//                             color: Colors.white,
//                             fontFamily: "Montserrat",
//                             fontWeight: FontWeight.bold,
//                             fontSize: 12),
//                         decoration: InputDecoration(
//                             hintText: "Nome",
//                             hintStyle: TextStyle(
//                                 color: Colors.white,
//                                 fontFamily: "Montserrat",
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 12),
//                             prefixIcon: Icon(
//                               Icons.people,
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
//                                 .signUpEmailController,
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
//                                 .signUpPasswordController,
//                         obscureText: true,
//                         validator: (value) {
//                           if (value.isEmpty || value.length < 8) {
//                             return "Mínimo de 8 digitos";
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
//                         .signUpFormKey
//                         .currentState
//                         .validate()) {
//                       final String name =
//                           Provider.of<AuthenticationScreenModel>(context)
//                               .signUpNameController
//                               .text;

//                       final String email =
//                           Provider.of<AuthenticationScreenModel>(context)
//                               .signUpEmailController
//                               .text;
//                       final String password =
//                           Provider.of<AuthenticationScreenModel>(context)
//                               .signUpPasswordController
//                               .text;

//                       this.signUp(context, name, email, password);
//                     }
//                   },
//                   child: Center(
//                       child: Text(
//                     "Criar conta",
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
