import 'package:flutter/material.dart';
import 'package:mobile/pages/authentication/authentication_signin.dart';
import 'package:mobile/pages/authentication/authentication_signup.dart';
import 'package:mobile/pages/home/client_home_page.dart';
import 'package:mobile/utils/constants.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

enum Tab { SignIn, SignUp }

class AuthenticationConfirmationScreenModel with ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  final codeController = TextEditingController();
}

class AuthenticationConfirmationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AuthenticationConfirmationScreenModel>(
        builder: (_) => AuthenticationConfirmationScreenModel(),
        child: _AuthenticationConfirmationPage());
  }
}

class _AuthenticationConfirmationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: colors["backgroundColor"],
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              flex: 3,
              child: AuthenticationHeader(),
            ),
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Enviamos um código para seu email",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(),
            ),
            Expanded(flex: 7, child: AuthenticationConfirmationForm()),
          ],
        ));
  }
}

class AuthenticationHeader extends StatelessWidget {
  const AuthenticationHeader({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(
            "helpr",
            style: TextStyle(
                color: colors["primaryColor"],
                fontSize: 48,
                fontWeight: FontWeight.bold,
                fontFamily: "Montserrat"),
          ),
        ),
      ],
    );
  }
}

class AuthenticationConfirmationForm extends StatelessWidget {
  const AuthenticationConfirmationForm({
    Key key,
  }) : super(key: key);

  void confirmCode(BuildContext context, String code) async {
    Navigator.pushReplacement(
        context,
        PageTransition(
            type: PageTransitionType.leftToRight,
            alignment: Alignment.bottomCenter,
            child: ClientHomePage()));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(left: 20, right: 20),
        decoration: BoxDecoration(
            color: colors["backgroundColor2"],
            borderRadius: BorderRadius.circular(5)),
        child: Stack(
          children: [
            Column(
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: Form(
                    key: Provider.of<AuthenticationConfirmationScreenModel>(
                            context)
                        .formKey,
                    child: Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          TextFormField(
                            controller: Provider.of<
                                        AuthenticationConfirmationScreenModel>(
                                    context)
                                .codeController,
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Digite o código";
                              }
                            },
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: "Montserrat",
                                fontWeight: FontWeight.bold,
                                fontSize: 12),
                            decoration: InputDecoration(
                                hintText: "Código",
                                hintStyle: TextStyle(
                                    color: Colors.white,
                                    fontFamily: "Montserrat",
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12),
                                prefixIcon: Icon(
                                  Icons.code,
                                  color: colors["primaryColor"],
                                ),
                                border: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: colors["primaryColor"])),
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: colors["primaryColor"])),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: colors["primaryColor"]))),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    color: colors["backgroundColor"],
                  ),
                )
              ],
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                  margin: EdgeInsets.only(left: 80, right: 80, top: 200),
                  height: 60,
                  decoration: BoxDecoration(
                      color: colors["primaryColor"],
                      borderRadius: BorderRadius.circular(5)),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        if (Provider.of<AuthenticationConfirmationScreenModel>(
                                context)
                            .formKey
                            .currentState
                            .validate()) {
                          final String code = Provider.of<
                                      AuthenticationConfirmationScreenModel>(
                                  context)
                              .codeController
                              .text;

                          this.confirmCode(context, code);
                        }
                      },
                      child: Center(
                          child: Text(
                        "Confirmar",
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      )),
                    ),
                  )),
            )
          ],
        ));
  }
}
