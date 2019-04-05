import 'package:flutter/material.dart';
import 'package:mobile/api/login_api.dart';
import 'package:mobile/widgets/helpr_button.dart';
import 'package:mobile/widgets/helpr_input.dart';
import 'package:rxdart/rxdart.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  String email = "";
  bool isLoading = false;
  bool showContinueButton = false;

  void continueButtonPressed() async {
    debugPrint("click");
    setState(() {
      isLoading = true;
    });
    final user = await UserApi.getUser(email);
    setState(() {
      isLoading = false;
    });

    if (user["name"] != null) {
      Navigator.pushNamed(context, "/login/password");
    } else {
      Navigator.pushNamed(context, "/login/new-user");
    }
  }

  void emailChanged(bool isValid, String email) async {
    this.email = email;
    if (isValid) {
      setState(() {
        isLoading = false;
        showContinueButton = true;
      });
    } else {
      setState(() {
        isLoading = false;
        showContinueButton = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Theme.of(context).backgroundColor,
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Olá.",
                      style: TextStyle(
                          color: Theme.of(context).accentColor,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Bem vindo ao ",
                          style: TextStyle(
                              color: Theme.of(context).accentColor,
                              fontSize: 24,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "helpr!",
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 24,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 40, right: 40),
                      child: HelprEmailInput(
                        callback: emailChanged,
                        // output: emailListener,
                      ),
                    )
                  ],
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
                            child: AnimatedOpacity(
                              opacity: showContinueButton ? 1.0 : 0.0,
                              duration: Duration(milliseconds: 150),
                              child: HelprButton(
                                  text: "CONTINUAR",
                                  isLoading: isLoading,
                                  callback: showContinueButton
                                      ? continueButtonPressed
                                      : null),
                            ))),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
