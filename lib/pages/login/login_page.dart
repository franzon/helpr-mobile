import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile/api/login_api.dart';
import 'package:mobile/pages/login/login.dart';
import 'package:mobile/utils/constants.dart';
import 'package:mobile/widgets/helpr_button.dart';
import 'package:mobile/widgets/helpr_email_input.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rxdart/rxdart.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter_sequence_animation/flutter_sequence_animation.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  String email = "";
  bool isLoading = false;
  bool isDisabled = true;

  AnimationController controller1;
  SequenceAnimation sequenceAnimation1;

  AnimationController controller2;
  SequenceAnimation sequenceAnimation2;

  AnimationController controller3;
  SequenceAnimation sequenceAnimation3;

  @override
  void initState() {
    super.initState();

    controller1 = AnimationController(vsync: this);
    sequenceAnimation1 = SequenceAnimationBuilder()
        .addAnimatable(
            animatable: Tween<double>(begin: 0.0, end: 1.0),
            from: const Duration(milliseconds: 200),
            to: const Duration(milliseconds: 1500),
            tag: 'opacity')
        .animate(controller1);

    controller2 = AnimationController(vsync: this);
    sequenceAnimation2 = SequenceAnimationBuilder()
        .addAnimatable(
            animatable: Tween<double>(begin: 0.0, end: 1.0),
            from: const Duration(milliseconds: 1000),
            to: const Duration(milliseconds: 1800),
            tag: 'opacity')
        .animate(controller2);

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
    setState(() {
      isLoading = true;
    });
    final user = await UserApi.getUser(email);
    setState(() {
      isLoading = false;
    });

    if (user["name"] != null) {
      // Navigator.pushNamed(context, "/login/password");
      Navigator.push(
          context,
          PageTransition(
              type: PageTransitionType.rightToLeft,
              child: LoginPasswordPage(
                email: email,
                name: user["name"],
              )));
    } else {
      Navigator.pushNamed(context, "/login/new-user");
    }
  }

  void emailChanged(bool isValid, String email) async {
    this.email = email;
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
    controller1.forward();
    controller2.forward();

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
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 40.0, bottom: 10.0),
                        child: AnimatedBuilder(
                          animation: controller1,
                          builder: (context, child) {
                            return Opacity(
                              child: child,
                              opacity: sequenceAnimation1["opacity"].value,
                            );
                          },
                          child: Text(
                            "Olá.",
                            style: TextStyle(
                                color: Theme.of(context).accentColor,
                                fontSize: 24,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      AnimatedBuilder(
                        animation: controller2,
                        builder: (context, child) {
                          return Opacity(
                            child: child,
                            opacity: sequenceAnimation2["opacity"].value,
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 40.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
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
                                    fontSize: 26,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
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
                          child: RotationTransition(
                            turns: Tween(begin: 0.0, end: 1.0)
                                .animate(controller3),
                            child: Container(
                                alignment: Alignment.centerLeft,
                                child: Icon(
                                  Icons.email,
                                  color: isDisabled
                                      ? Colors.white
                                      : Theme.of(context).primaryColor,
                                )),
                          )),

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
                          child: HelprEmailInput(
                            callback: emailChanged,
                            // output: emailListener,
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
      ),
    );
  }
}
