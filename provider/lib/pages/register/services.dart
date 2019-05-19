import 'package:flutter/material.dart';
import 'package:mobile/widgets/helpr_button.dart';
import 'package:mobile/utils/constants.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

class ServicesPage extends StatefulWidget {
  final String email;
  final String name;
  final String cpf;
  final String password;

  ServicesPage({this.email, this.name, this.cpf, this.password});

  @override
  _ServicesPageState createState() =>
      _ServicesPageState(email, name, cpf, password);
}

class _ServicesPageState extends State<ServicesPage> {
  String email, name, cpf, password;

  _ServicesPageState(this.email, this.name, this.cpf, this.password);

  bool isDisabled = false, isLoading = false;

  TextEditingController categoryController;
  TextEditingController descriptionController;
  MoneyMaskedTextController priceController = MoneyMaskedTextController(
      decimalSeparator: ',', thousandSeparator: '.', leftSymbol: 'R\$ ');

  FocusNode categoryFocus = FocusNode(),
      descriptionFocus = FocusNode(),
      priceFocus = FocusNode();

  void submitForm() {}

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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Agora informações sobre",
                      style: TextStyle(
                        fontSize: 30,
                        color: colors['accentColor'],
                      ),
                    ),
                    Text(
                      "o seu serviço",
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
                          TextField(
                            textInputAction: TextInputAction.next,
                            controller: categoryController,
                            focusNode: categoryFocus,
                            onSubmitted: (text) {
                              _fieldFocusChange(
                                  context, categoryFocus, descriptionFocus);
                            },
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.category),
                              helperText: "Informe a categoria",
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
                              hintText: "Categoria",
                            ),
                          ),
                          TextField(
                            textInputAction: TextInputAction.next,
                            controller: descriptionController,
                            focusNode: descriptionFocus,
                            onSubmitted: (text) {
                              _fieldFocusChange(
                                  context, descriptionFocus, priceFocus);
                            },
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.list),
                              helperText: "Informe a descrição do serviço",
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
                              hintText: "Descrição",
                            ),
                          ),
                          TextField(
                            controller: priceController,
                            keyboardType: TextInputType.number,
                            focusNode: priceFocus,
                            onSubmitted: (text) {
                              submitForm();
                            },
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.monetization_on),
                              helperText: "Informe o preço do seu serviço",
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
                              hintText: "Preço",
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
                            text: "CONFIRMAR SERVIÇO",
                            isDisabled: isDisabled,
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
