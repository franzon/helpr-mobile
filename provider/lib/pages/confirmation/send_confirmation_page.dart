import 'package:flutter/material.dart';
import 'package:mobile/widgets/helpr_back_button.dart';
import 'package:mobile/widgets/helpr_button.dart';
import 'package:mobile/utils/constants.dart';
import 'package:mobile/api/email_confirmation.dart';
import 'package:mobile/pages/login/login.dart';
import 'package:page_transition/page_transition.dart';
import 'package:mobile/pages/confirmation/confirm_code_page.dart';

class SendEmailConfirmationPage extends StatefulWidget {
  final String email;

  SendEmailConfirmationPage({this.email});

  @override
  _SendEmailConfirmationPageState createState() =>
      _SendEmailConfirmationPageState(email);
}

class _SendEmailConfirmationPageState extends State<SendEmailConfirmationPage>
    with TickerProviderStateMixin {
  String email;
  bool isLoading = false;

  _SendEmailConfirmationPageState(this.email);


  void backToLoginPage() {
    Navigator.push(
      context,
      PageTransition(
        type: PageTransitionType.leftToRight,
        child: LoginPage(),
      ),
    );
  }

  void continueButtonPressed() async {
    setState(() {
      isLoading = true;
    });
    var user = await UserApi.sendCode(email);

    if (user != null) {
      setState(() {
        isLoading = false;
      });

      Navigator.push(
        context,
        PageTransition(
          type: PageTransitionType.rightToLeft,
          child: ConfirmCodePage(email: email),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: [
              0.6,
              0.9
            ],
                colors: [
              Color(0xFF2B2E33),
              Colors.black,
            ])),
        // color: Theme.of(context).backgroundColor,
        child: SafeArea(
          child: Column(
            children: <Widget>[
              HelprBackButton(
                text: "Voltar",
                onPressed: backToLoginPage,
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 60),
              ),
              Expanded(
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Ooops!",
                          style: TextStyle(
                            fontSize: 30,
                            color: colors['primaryColor'],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 3),
                        ),
                        Text(
                          "Parece que você",
                          style: TextStyle(
                            fontSize: 30,
                            color: colors['accentColor'],
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "ainda não tem uma conta. \nQue tal criar uma agora? ",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 30,
                        color: colors['accentColor'],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Text(
                  "Precisamos enviar um email\n com um código de confirmação.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    color: colors['accentColor'],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  child: Row(
                    children: <Widget>[
                      Expanded(
                          child: Padding(
                        padding: EdgeInsets.only(left: 40, right: 40),
                        child: HelprButton(
                          text: "ENVIAR CÓDIGO",
                          isLoading: isLoading,
                          isDisabled: false,
                          callback: continueButtonPressed,
                        ),
                      )),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
