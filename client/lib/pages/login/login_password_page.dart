import 'package:flutter/material.dart';
import 'package:flutter_keychain/flutter_keychain.dart';
import 'package:flutter_sequence_animation/flutter_sequence_animation.dart';
import 'package:mobile/api/auth_api.dart';
import 'package:mobile/widgets/helpr_button.dart';
import 'package:mobile/widgets/helpr_password_input.dart';

class LoginPasswordPage extends StatefulWidget {
  final String email;
  final String name;

  LoginPasswordPage({@required this.email, @required this.name});

  @override
  State<StatefulWidget> createState() {
    return _LoginPasswordPageState(email: email, name: name);
  }
}

class _LoginPasswordPageState extends State<LoginPasswordPage>
    with TickerProviderStateMixin {
  bool isLoading = false;
  bool isDisabled = true;
  final String email;
  final String name;
  String password = "";
  AnimationController controller3;
  SequenceAnimation sequenceAnimation3;

  _LoginPasswordPageState({@required this.name, @required this.email});

  @override
  void initState() {
    super.initState();

    controller3 = AnimationController(vsync: this);
    sequenceAnimation3 = SequenceAnimationBuilder()
        .addAnimatable(
            animatable: Tween<double>(begin: 0.0, end: 1.0),
            from: const Duration(milliseconds: 0),
            to: const Duration(milliseconds: 400),
            tag: 'rotation')
        .animate(controller3);
  }

  void continueButtonPressed() async {
    try {
      final result = await AuthApi.signIn(email, password);
      FlutterKeychain.put(key: "token", value: result["token"]);
    } catch (e) {}
  }

  void passwordChanged(bool isValid, String password) async {
    this.password = password;
    if (isValid) {
      controller3.forward();
      setState(() {
        isLoading = false;
        isDisabled = false;
      });
    } else {
      controller3.reset();
      setState(() {
        isLoading = false;
        isDisabled = true;
      });
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
              Expanded(
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(right: 40.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Text(
                              "Olá, ",
                              style: TextStyle(
                                  color: Theme.of(context).accentColor,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              name,
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            right: 40, bottom: 10.0, top: 10),
                        child: Text(
                          "Digite sua senha.",
                          textAlign: TextAlign.end,
                          style: TextStyle(
                              color: Theme.of(context).accentColor,
                              fontSize: 22,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  child: Row(
                    children: <Widget>[
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
                          padding: const EdgeInsets.all(30.0),
                          child: HelprPasswordInput(
                            callback: passwordChanged,
                            // output: emailListener,
                          ),
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(right: 30.0),
                          child: RotationTransition(
                            turns: Tween(begin: 0.0, end: 1.0)
                                .animate(controller3),
                            child: Container(
                                alignment: Alignment.centerLeft,
                                child: Icon(
                                  Icons.lock,
                                  color: isDisabled
                                      ? Colors.white
                                      : Theme.of(context).primaryColor,
                                )),
                          ))
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
      ),
    );
  }
}
