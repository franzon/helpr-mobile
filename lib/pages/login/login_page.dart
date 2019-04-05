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
  final emailListener = BehaviorSubject<TextOutput>();
  final clickListener =
      BehaviorSubject<ButtonStatus>.seeded(ButtonStatus.initial);

  bool showButton = false;

  void continueButtonPressed() async {
    // Useless befause button only appears when email is valid.
    if (this.emailListener.hasValue && this.emailListener.value.valid) {
      final user = await UserApi.getUser(this.emailListener.value.value);

      this.clickListener.add(ButtonStatus.completed);

      if (user["name"] != null) {
        Navigator.pushNamed(context, "/login/password");
      } else {
        Navigator.pushNamed(context, "/login/new-user");
      }
    }
  }

  @override
  void initState() {
    super.initState();
    emailListener.listen((data) {
      setState(() {
        showButton = data.valid;
      });
    });

    clickListener.where((item) => item == ButtonStatus.loading).listen((x) {
      debugPrint('clicked');
      this.continueButtonPressed();
    });
  }

  @override
  void dispose() {
    super.dispose();
    emailListener.close();
    clickListener.close();
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
                        output: emailListener,
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
                      child: showButton
                          ? Padding(
                              padding: EdgeInsets.only(left: 40, right: 40),
                              child: HelprButton(
                                text: "CONTINUAR",
                                clickListener: clickListener,
                              ))
                          : Container(),
                    ),
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
