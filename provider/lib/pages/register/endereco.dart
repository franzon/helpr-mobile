import 'package:flutter/material.dart';
import 'package:mobile/widgets/helpr_button.dart';
import 'package:mobile/utils/constants.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'dart:io';
import 'package:page_transition/page_transition.dart';
import 'package:mobile/utils/files.dart';
import 'package:path_provider/path_provider.dart';
import 'package:mobile/utils/cep.dart';
import 'package:mobile/pages/home.dart';
import 'package:mobile/api/register.dart';

class AddressPage extends StatefulWidget {
  AddressPage({Key key}) : super(key: key);

  _AddressPageState createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  JSONStorage storage;
  String _fileName = localFiles["jsonProviderName"];

  String cep = "", bairro = "", street = "", number = "";

  String cepError = "", numberError = "";

  MaskedTextController cepController;
  TextEditingController bairroController;
  TextEditingController streetController;
  TextEditingController numberController;

  FocusNode cepFocus = FocusNode();
  FocusNode bairroFocus = FocusNode();
  FocusNode streetFocus = FocusNode();
  FocusNode numberFocus = FocusNode();

  bool cepValidate = false;
  bool numberValidate = false;
  bool streetValidate = false;
  bool bairroValidate = false;

  bool isLoading = false;
  bool isDisabled = true;

  bool checking = true;

  @override
  void initState() {
    super.initState();
    cepController = MaskedTextController(text: "", mask: "00000-000");
    bairroController = TextEditingController(text: "");
    streetController = TextEditingController(text: "");
    numberController = TextEditingController(text: "");
  }

  @override
  void dispose() {
    cepController.dispose();
    bairroController.dispose();
    streetController.dispose();
    numberController.dispose();
    super.dispose();
  }

  void submitForm() async {
    setState(() {
      isLoading = true;
    });
    Directory dir = await getApplicationDocumentsDirectory();

    this.storage = JSONStorage(_fileName, dir.path);
    this.storage.appendMap({
      "cep": cepController.text,
      "neighborhood": bairroController.text,
      "address": streetController.text,
      "numberAddress": numberController.text,
    });
    setState(() {
      isLoading = false;
    }); 


    var response = await registration(this.storage.getContent());

      print(response);
    if (response != null) {
      Navigator.push(
        context,
        PageTransition(
          type: PageTransitionType.rightToLeft,
          child: HomePage(),
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
                      "Agora, informações sobre o",
                      style: TextStyle(
                        fontSize: 30,
                        color: colors['accentColor'],
                      ),
                    ),
                    Text(
                      "seu endereço.",
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
                            padding: EdgeInsets.only(bottom: 10),
                            child: TextField(
                              textInputAction: TextInputAction.next,
                              controller: cepController,
                              keyboardType: TextInputType.number,
                              focusNode: cepFocus,
                              onChanged: (cepChanged) async {
                                if (cepChanged.length == 9) {
                                  ResultadoCEP cepInfos =
                                      await consultCEP(cep: cepChanged);

                                  if (cepInfos != null) {
                                    setState(() {
                                      bairroController.text =
                                          cepInfos.neighborhood;
                                      streetController.text = cepInfos.street;
                                      cepValidate = false;
                                    });
                                  } else {
                                    setState(() {
                                      cepError = "CEP inválido";
                                      cepValidate = true;
                                    });
                                  }
                                }
                              },
                              onSubmitted: (text) {
                                if (!cepValidate) {
                                  _fieldFocusChange(
                                      context, cepFocus, bairroFocus);
                                }
                              },
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.location_city),
                                helperText: "Informe o CEP",
                                helperStyle:
                                    TextStyle(color: colors['accentColor']),
                                filled: true,
                                fillColor: colors['accentColor'],
                                errorText: !cepValidate ? null : cepError,
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
                                hintText: "CEP (Somente números)",
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 10),
                            child: Row(
                              children: <Widget>[
                                Flexible(
                                  flex: 9,
                                  fit: FlexFit.tight,
                                  child: TextField(
                                    textInputAction: TextInputAction.next,
                                    controller: bairroController,
                                    focusNode: bairroFocus,
                                    onSubmitted: (text) {
                                      if (bairroController.text.length > 0) {
                                        setState(() {
                                          bairroValidate = true;
                                        });
                                        _fieldFocusChange(
                                            context, bairroFocus, numberFocus);
                                      }
                                    },
                                    decoration: InputDecoration(
                                      prefixIcon: Icon(Icons.group),
                                      helperText: "Bairro",
                                      helperStyle: TextStyle(
                                          color: colors['accentColor']),
                                      filled: true,
                                      fillColor: colors['accentColor'],
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.transparent),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.transparent),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                      ),
                                      hintText: "Ex: Centro",
                                    ),
                                  ),
                                ),
                                Spacer(flex: 1),
                                Flexible(
                                  flex: 7,
                                  child: TextField(
                                    textInputAction: TextInputAction.next,
                                    controller: numberController,
                                    keyboardType: TextInputType.number,
                                    onChanged: (number) {
                                      if (int.parse(number) > 0) {
                                        setState(() {
                                          numberValidate = false;
                                        });
                                      } else {
                                        setState(() {
                                          numberError = "Número negativo";
                                          numberValidate = true;
                                        });
                                      }
                                    },
                                    focusNode: numberFocus,
                                    onSubmitted: (text) {
                                      if (!numberValidate) {
                                        _fieldFocusChange(
                                            context, numberFocus, streetFocus);
                                      }
                                    },
                                    decoration: InputDecoration(
                                      prefixIcon: Icon(Icons.plus_one),
                                      helperText: "Informe o número do local",
                                      helperStyle: TextStyle(
                                          color: colors['accentColor']),
                                      filled: true,
                                      fillColor: colors['accentColor'],
                                      errorText:
                                          !numberValidate ? null : numberError,
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.transparent),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.transparent),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                      ),
                                      hintText: "Ex: 999",
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          TextField(
                            textInputAction: TextInputAction.done,
                            controller: streetController,
                            focusNode: streetFocus,
                            onSubmitted: (text) {
                              if (streetController.text.length > 0) {
                                setState(() {
                                  streetValidate = true;
                                });
                                submitForm();
                              }
                            },
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.location_on),
                              helperText: "Informe a rua/avenida",
                              helperStyle:
                                  TextStyle(color: colors['accentColor']),
                              filled: true,
                              fillColor: colors['accentColor'],
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
                              hintText: "Ex: Av. Capitão Índio Bandeira",
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
                            text: "CONFIRMAR CADASTRO",
                            isDisabled: cepValidate ||
                                numberValidate ||
                                !(streetController.text.length > 0) ||
                                !(bairroController.text.length > 0),
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
