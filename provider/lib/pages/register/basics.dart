import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mobile/utils/files.dart';
import 'package:mobile/widgets/helpr_button.dart';
import 'package:mobile/utils/constants.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:cpf_cnpj_validator/cpf_validator.dart';
import 'package:mobile/pages/register/services.dart';
import 'package:path_provider/path_provider.dart';

class BasicInformationPage extends StatefulWidget {
  BasicInformationPage();

  @override
  _BasicInformationPageState createState() => _BasicInformationPageState();
}

class _BasicInformationPageState extends State<BasicInformationPage>
    with TickerProviderStateMixin {
  JSONStorage storage;

  var inputSelect = 0;

  String name;
  String email;

  bool isLoading = false;
  bool isDisabled = false;

  bool cpfValidate = true;
  bool passValidate = true;
  bool confirmValidate = true;
  bool phoneValidate = true;

  TextEditingController emailController;
  TextEditingController passwordController;
  TextEditingController passwordConfirmationController;
  MaskedTextController cpfController;
  MaskedTextController phoneController;

  FocusNode confirmFocus = FocusNode();
  FocusNode cpfFocus = FocusNode();
  FocusNode passFocus = FocusNode();
  FocusNode phoneFocus = FocusNode();

  Color cpfFill = colors['primaryColor'];

  @override
  void initState() {
    super.initState();

    setState(() {
      phoneController =
          MaskedTextController(text: "", mask: "(00) 0 0000-0000");
      cpfController = MaskedTextController(text: "", mask: '000.000.000-00');
      passwordConfirmationController = TextEditingController(text: "");
      passwordController = TextEditingController(text: "");
    });
  }

  void submitForm() async {
    if (passValidate && cpfValidate && confirmValidate) {
      Directory dir = await getApplicationDocumentsDirectory();
      this.storage = JSONStorage(localFiles['jsonProviderName'], dir.path);
      this.storage.appendMap({
        "cpf": cpfController.text,
        "password": this.passwordController.text,
        "phoneNumber": phoneController.text,
      });

      Navigator.push(
        context,
        PageTransition(
          type: PageTransitionType.rightToLeft,
          child: ServicesPage(),
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
            stops: [0.6, 0.9],
            colors: [
              Color(0xFF2B2E33),
              Colors.black,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Precisamos de mais algumas",
                      style: TextStyle(
                        fontSize: 30,
                        color: colors['accentColor'],
                      ),
                    ),
                    Text(
                      "informações",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 30,
                        color: colors['primaryColor'],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 4,
                child: ListView(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(bottom: 15),
                            child: TextField(
                              textInputAction: TextInputAction.next,
                              controller: cpfController,
                              keyboardType: TextInputType.number,
                              focusNode: cpfFocus,
                              onChanged: (cpf) {
                                if (cpf.length >= 9 &&
                                    CPFValidator.isValid(cpf)) {
                                  setState(() {
                                    cpfValidate = true;
                                  });
                                } else {
                                  setState(() {
                                    cpfValidate = false;
                                  });
                                }
                              },
                              onSubmitted: (text) {
                                _fieldFocusChange(context, cpfFocus, phoneFocus);
                              },
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.payment),
                                helperText: "Informe o CPF",
                                filled: true,
                                fillColor: colors['accentColor'],
                                errorText: cpfValidate ? null : "CPF inválido",
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                hintText: "CPF (Somente números)",
                              ),
                            ),
                          ),
                          TextField(
                            obscureText: true,
                            textInputAction: TextInputAction.next,
                            controller: phoneController,
                            onChanged: (phone) {
                              if (phone.length == 16) {
                                setState(() {
                                  phoneValidate = true;
                                });
                              } else {
                                setState(() {
                                  phoneValidate = false;
                                });
                              }
                            },
                            focusNode: passFocus,
                            onSubmitted: (text) {
                              _fieldFocusChange(
                                  context, phoneFocus, passFocus);
                            },
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.lock),
                              helperText: "Informe uma senha segura",
                              filled: true,
                              fillColor: colors['accentColor'],
                              errorText: passValidate
                                  ? null
                                  : "A senha deve conter pelo menos 8 dígitos",
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              hintText: "Senha (Mínimo 8 caracteres)",
                            ),
                          ),
                          TextField(
                            obscureText: true,
                            textInputAction: TextInputAction.next,
                            controller: passwordController,
                            onChanged: (password) {
                              if (password.length >= 8) {
                                setState(() {
                                  passValidate = true;
                                });
                              } else {
                                setState(() {
                                  passValidate = false;
                                });
                              }
                            },
                            focusNode: passFocus,
                            onSubmitted: (text) {
                              _fieldFocusChange(
                                  context, passFocus, confirmFocus);
                            },
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.lock),
                              helperText: "Informe uma senha segura",
                              filled: true,
                              fillColor: colors['accentColor'],
                              errorText: passValidate
                                  ? null
                                  : "A senha deve conter pelo menos 8 dígitos",
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              hintText: "Senha (Mínimo 8 caracteres)",
                            ),
                          ),
                          TextField(
                            obscureText: true,
                            controller: passwordConfirmationController,
                            onChanged: (password) {
                              if (password == passwordController.text) {
                                setState(() {
                                  confirmValidate = true;
                                });
                              } else {
                                setState(() {
                                  confirmValidate = false;
                                });
                              }
                            },
                            focusNode: confirmFocus,
                            onSubmitted: (text) {
                              submitForm();
                            },
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.lock),
                              helperText: "Confirme a senha",
                              filled: true,
                              fillColor: colors['accentColor'],
                              errorText: confirmValidate
                                  ? null
                                  : "A senhas devem ser iguais",
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              hintText: "Confirme a senha",
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
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
                            text: "CONFIRMAR INFORMAÇÕES",
                            isDisabled: !cpfValidate ||
                                !passValidate ||
                                !confirmValidate ||
                                !phoneValidate,
                            isLoading: isLoading,
                            callback: submitForm,
                          ),
                        ),
                      ),
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

_fieldFocusChange(
    BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
  currentFocus.unfocus();
  FocusScope.of(context).requestFocus(nextFocus);
}
