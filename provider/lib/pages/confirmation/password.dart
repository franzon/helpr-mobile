import 'package:flutter/material.dart';
import 'package:mobile/widgets/helpr_back_button.dart';
import 'package:mobile/widgets/helpr_button.dart';
import 'package:page_transition/page_transition.dart';

class PasswordPage extends StatefulWidget {
  const PasswordPage({Key key}) : super(key: key);

  @override
  _PasswordPageState createState() => _PasswordPageState();
}

class _PasswordPageState extends State<PasswordPage> {
  String password = "";

  bool isLoading = false;
  bool isDisabled = true;

  void continueButtonPressed() async {
    // todo: chamar api
  }

  void passwordChanged(String password) async {
    this.password = password;
    if (password.length > 0) {
      setState(() {
        isLoading = false;
        isDisabled = false;
      });
    } else {
      setState(() {
        isLoading = false;
        isDisabled = true;
      });
    }
    // this.email = email;
    // if (isValid) {
    //   controller3.forward();
    //   setState(() {
    //     isLoading = false;
    //     isDisabled = false;
    //   });
    // } else {
    //   controller3.reset();
    //   setState(() {
    //     isLoading = false;
    //     isDisabled = true;
    //   });
    // }
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
            Expanded(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    HelprBackButton(
                      text: "Voltar",
                      onPressed: null,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 40.0, bottom: 10.0),
                      child: Text(
                        "Escolha uma senha forte.",
                        style: TextStyle(
                            color: Theme.of(context).accentColor,
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
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
                    Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: Container(
                            alignment: Alignment.centerLeft,
                            child: Icon(
                              Icons.lock,
                              color:
                                  isDisabled ? Colors.white : Colors.lightBlue,
                            ))),

                    // child: AnimatedBuilder(
                    //   animation: controller,
                    //   builder: (BuildContext context, Widget child) {
                    //     return Container(
                    //         child: Icon(
                    //       Icons.email,
                    //       color: Colors.white,
                    //     ));
                    //   },
                    // ),

                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 30),
                        child: TextField(
                          obscureText: true,
                          onChanged: (text) => this.passwordChanged(text),
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Theme.of(context).accentColor,
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              hintText: "Digite uma senha"),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // child: Column(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: <Widget>[
              //     Padding(
              //       padding: const EdgeInsets.only(left: 40, right: 60),
              //       child: HelprEmailInput(
              //         callback: emailChanged,
              //         // output: emailListener,
              //       ),
              //     ),
              //     Text("a")
              //   ],
              // ),
            ),
            Expanded(
              child: Container(
                child: Row(
                  children: <Widget>[
                    Expanded(
                        child: Padding(
                      padding: EdgeInsets.only(left: 40, right: 40),
                      child: HelprButton(
                          text: "CONTINUAR",
                          isLoading: isLoading,
                          isDisabled: isDisabled,
                          callback: continueButtonPressed),
                    )),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
