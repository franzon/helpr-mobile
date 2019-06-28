import 'package:flutter/material.dart';
import 'package:client_v3/constants/ui.dart';
import 'package:client_v3/models/Address.dart';
import 'package:client_v3/providers/ClientProvider.dart';
import 'package:client_v3/setupSingletons.dart';

class NewAddressPage extends StatelessWidget {
  final clientProvider = getIt<ClientProvider>();
  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    final _cityFocusNode = FocusNode();
    final _neighborhoodFocusNode = FocusNode();
    final _streetFocusNode = FocusNode();
    final _numberFocusNode = FocusNode();
    final _complementFocusNode = FocusNode();

    final _stateController = TextEditingController(text: "");
    final _cityController = TextEditingController(text: "");
    final _neighborhoodController = TextEditingController(text: "");
    final _streetController = TextEditingController(text: "");
    final _numberController = TextEditingController(text: "");
    final _complementController = TextEditingController(text: "");

    return HelprBaseScroll(
        child: HelprBody(
            child: Stack(
              children: <Widget>[
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: Text("Cadastrando novo endereço"),
                        ),
                      ),
                      Form(
                        key: _formKey,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: Column(
                            children: <Widget>[
                              HelprTextFormField(
                                  context: context,
                                  hintText: "Estado",
                                  controller: _stateController,
                                  nextFocusNode: _cityFocusNode,
                                  validator: (text) => text.length == 0
                                      ? "Preencha o estado"
                                      : null),
                              HelprTextFormField(
                                  context: context,
                                  hintText: "Cidade",
                                  controller: _cityController,
                                  focusNode: _cityFocusNode,
                                  nextFocusNode: _neighborhoodFocusNode,
                                  validator: (text) => text.length == 0
                                      ? "Preencha a cidade"
                                      : null),
                              HelprTextFormField(
                                  context: context,
                                  hintText: "Bairro",
                                  controller: _neighborhoodController,
                                  focusNode: _neighborhoodFocusNode,
                                  nextFocusNode: _streetFocusNode,
                                  validator: (text) => text.length == 0
                                      ? "Preencha o bairro"
                                      : null),
                              HelprTextFormField(
                                  context: context,
                                  hintText: "Rua",
                                  controller: _streetController,
                                  focusNode: _streetFocusNode,
                                  nextFocusNode: _numberFocusNode,
                                  validator: (text) => text.length == 0
                                      ? "Preencha a rua"
                                      : null),
                              HelprTextFormField(
                                  context: context,
                                  hintText: "Número",
                                  controller: _numberController,
                                  focusNode: _numberFocusNode,
                                  nextFocusNode: _complementFocusNode,
                                  validator: (text) => text.length == 0
                                      ? "Preencha o número"
                                      : null),
                              HelprTextFormField(
                                context: context,
                                hintText: "Complemento",
                                controller: _complementController,
                                focusNode: _complementFocusNode,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                HelprFloatBottom(
                    child: HelprButton(
                        text: "Adicionar",
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            final state = _stateController.value.text;
                            final city = _cityController.value.text;
                            final neighborhood =
                                _neighborhoodController.value.text;
                            final street = _streetController.value.text;
                            final number = _numberController.value.text;
                            final complement = _complementController.value.text;

                            final newAddress = Address(
                                state: state,
                                city: city,
                                neighborhood: neighborhood,
                                street: street,
                                number: number,
                                complement: complement);

                            clientProvider.addAddress(newAddress);
                            Navigator.of(context).pop();
                          }
                        })),
              ],
            ),
            margin: EdgeInsets.symmetric(vertical: 60.0, horizontal: 15.0)));
  }
}
