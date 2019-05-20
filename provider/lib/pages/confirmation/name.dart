import 'dart:io';

import 'package:mobile/utils/constants.dart';
import 'package:flutter/material.dart';
// import 'package:mobile/pages/confirmation/password.dart';
import 'package:mobile/widgets/helpr_button.dart';
import 'package:page_transition/page_transition.dart';
import 'package:path_provider/path_provider.dart';
import 'package:mobile/utils/files.dart';
import 'package:mobile/pages/confirmation/password.dart';
import 'package:mobile/pages/register/basics.dart';

class NamePage extends StatefulWidget {
  const NamePage({Key key}) : super(key: key);

  @override
  _NamePageState createState() => _NamePageState();
}

class _NamePageState extends State<NamePage> {
  String nome = "";

  JSONStorage storage;

  bool isLoading = false;
  bool isDisabled = true;

  void continueButtonPressed() async {
    Directory dir = await getApplicationDocumentsDirectory();
    this.storage = JSONStorage(localFiles['jsonProviderName'], dir.path);
    this.storage.appendMap({"name": this.nome});

    Navigator.push(
        context,
        PageTransition(
            type: PageTransitionType.rightToLeft, child: BasicInformationPage()));
  }

  void nameChanged(String nome) async {
    this.nome = nome;
    if (nome.length > 0) {
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
                    Padding(
                      padding: const EdgeInsets.only(left: 40.0, bottom: 10.0),
                      child: Text(
                        "Pronto...",
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 40.0),
                      child: Text(
                        "Por favor, digite seu primeiro nome.",
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
                              Icons.person,
                              color: isDisabled
                                  ? Colors.white
                                  : Colors.lightBlue,
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
                          onChanged: (text) => this.nameChanged(text),
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
                              hintText: "Digite seu nome"),
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
