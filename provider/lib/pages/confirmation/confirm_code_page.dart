import 'package:flutter/material.dart';
import 'package:mobile/pages/confirmation/send_confirmation_page.dart';
import 'package:page_transition/page_transition.dart';

import 'package:mobile/widgets/helpr_back_button.dart';
import 'package:mobile/widgets/helpr_button.dart';
import 'package:mobile/utils/constants.dart';
import 'package:mobile/api/email_confirmation.dart';
import 'package:mobile/pages/confirmation/name.dart';
import 'package:mobile/utils/files.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class ConfirmCodePage extends StatefulWidget {
  final String email;

  ConfirmCodePage({Key key, this.email}) : super(key: key);

  _ConfirmCodePageState createState() => _ConfirmCodePageState(email);
}

class _ConfirmCodePageState extends State<ConfirmCodePage> {
  final String email;

  _ConfirmCodePageState(this.email);

  JSONStorage storage;

  final myController = TextEditingController();

  int _totalTime = 120;
  int _timeToResend = 120;
  String code = "";
  bool _allowResend = false;

  bool isLoading = false;

  Color inputFill = colors['accentColor'];

  void timerToSend() async {
    while (_timeToResend != 0 && !_allowResend) {
      await Future.delayed(Duration(seconds: 1), () {});
      setState(() {
        _timeToResend -= 1;
      });
    }
    setState(() {
      _allowResend = true;
      _timeToResend = _totalTime;
    });
  }

  Widget progressBarOrResendText() {
    return !_allowResend
        ? Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              LinearProgressIndicator(
                value: _timeToResend / _totalTime,
                backgroundColor: colors['primaryColor'],
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 5),
              ),
              Text(
                "Você poderá solicitar um novo código em $_timeToResend segundo${_timeToResend > 1 ? "s" : ""}",
                style: TextStyle(color: Colors.white),
              ),
            ],
          )
        : FlatButton(
            onPressed: () {
              setState(() {
                _allowResend = false;
              });
              timerToSend();
            },
            child: new Text(
              "Enviar um novo código",
              style: TextStyle(color: Colors.white),
            ),
          );
  }

  void backToLoginPage() {
    Navigator.push(
      context,
      PageTransition(
        type: PageTransitionType.leftToRight,
        child: SendEmailConfirmationPage(),
      ),
    );
  }

  void inputSubmit(String code) async {
    setState(() {
      isLoading = true;
    });
    var response = await UserApi.sendCode(code);

    if (response != null) {

      getApplicationDocumentsDirectory().then((Directory directory) {
        this.storage = JSONStorage(localFiles["jsonProviderName"], directory.path);
        this.storage.appendMap({email: this.email});
      });

      setState(() {
        isLoading = false;
      });

      Navigator.push(
        context,
        PageTransition(
          type: PageTransitionType.rightToLeft,
          child: NamePage(),
        ),
      );
    } else {
      setState(() {
        inputFill = Colors.red;
      });
    }
  }

  @override
  void initState() {
    super.initState();

    timerToSend();
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
                onPressed: timerToSend,
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
                          "Enviamos um ",
                          style: TextStyle(
                            fontSize: 30,
                            color: colors['accentColor'],
                          ),
                        ),
                        Text(
                          "código",
                          style: TextStyle(
                            fontSize: 30,
                            color: colors['primaryColor'],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 3),
                        ),
                        Text(
                          "para o seu email.",
                          style: TextStyle(
                            fontSize: 30,
                            color: colors['accentColor'],
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "Confirme-o abaixo ",
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
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: TextField(
                    onTap: () {
                      setState(() {
                        inputFill = colors['accentColor'];
                      });
                    },
                    controller: myController,
                    onSubmitted: inputSubmit,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: inputFill,
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      hintText: "Informe o código",
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: -1,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 40),
                  child: progressBarOrResendText(),
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
                          text: "CONFIRMAR CÓDIGO",
                          isLoading: isLoading,
                          isDisabled: false,
                          callback: () {
                            inputSubmit(myController.text);
                          },
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
