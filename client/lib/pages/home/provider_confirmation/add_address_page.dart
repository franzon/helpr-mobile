import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mobile/api/user_api.dart';
import 'package:mobile/models/Address.dart';
import 'package:mobile/utils/constants.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rxdart/rxdart.dart';

class AddAddressPage extends StatelessWidget {
  final BehaviorSubject<AddressesApiResult> addresses$;

  final GlobalKey<FormState> _form = GlobalKey<FormState>();

  final _cityFocusNode = FocusNode();
  final _neighborhoodFocusNode = FocusNode();
  final _streetFocusNode = FocusNode();
  final _numberFocusNode = FocusNode();
  final _complementFocusNode = FocusNode();

  final _stateController = TextEditingController(text: "PR");
  final _cityController = TextEditingController(text: "cm");
  final _neighborhoodController = TextEditingController(text: "c");
  final _streetController = TextEditingController(text: "t");
  final _numberController = TextEditingController(text: "4");
  final _complementController = TextEditingController(text: "");

  AddAddressPage({@required this.addresses$});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors["backgroundColor"],
      body: SafeArea(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _buildHeader(context),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 60),
                  color: colors["backgroundColor"],
                  child: Container(
                    decoration: BoxDecoration(
                      color: colors["backgroundColor2"],
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Stack(
                      children: <Widget>[
                        SingleChildScrollView(
                          child: Container(
                            padding: EdgeInsets.only(top: 20),
                            child: Column(
                              children: <Widget>[
                                Center(
                                    child: Text("Adicionando novo endereço",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold))),
                                _buildForm(context)
                              ],
                            ),
                          ),
                        ),
                        Transform.translate(
                          offset: Offset(0, 30),
                          child: Align(
                              alignment: Alignment.bottomCenter,
                              child: _buildButton(context)),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Container _buildButton(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: colors["primaryColor"]),
      child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () async {
              if (_form.currentState.validate()) {
                final state = _stateController.value.text;
                final city = _cityController.value.text;
                final neighborhood = _neighborhoodController.value.text;
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

                try {
                  final res = await UserApi.addUserAddress(address: newAddress);
                  Navigator.of(context).pop();
                  addresses$.add(AddressesApiResult.fromJson(res["data"]));
                } catch (e) {}
              }
              // _submitForm();
              // Navigator.push(
              //     context,
              //     PageTransition(
              //         type: PageTransitionType.rightToLeft,
              //         duration: Duration(milliseconds: 200),
              //         alignment: Alignment.center,
              //         child: AddressSelectionPage()));
            },
            child: Container(
                width: 200,
                height: 60,
                child: Center(
                    child: Text(
                  "Adicionar",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ))),
          )),
    );
  }

  Container _buildHeader(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      height: MediaQuery.of(context).size.height * 0.09,
      color: colors["primaryColor"],
      child: Row(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Row(
              children: <Widget>[
                Icon(Icons.arrow_back),
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text("Voltar",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                )
              ],
            ),
          ),
          Expanded(
            child: Container(),
          ),
        ],
      ),
    );
  }

  Padding _buildForm(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 50, right: 50, bottom: 50, top: 50),
      child: Form(
        key: _form,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _buildStateTextField(context),
            _buildCityField(context),
            _buildNeighborhoodField(context),
            _buildStreetField(context),
            _buildNumberField(context),
            _buildComplementField(context)
          ],
        ),
      ),
    );
  }

  TextFormField _buildStateTextField(BuildContext context) {
    return TextFormField(
        validator: (value) {
          if (value.isEmpty) {
            return "Digite um estado";
          }
        },
        textInputAction: TextInputAction.next,
        onFieldSubmitted: (_) {
          FocusScope.of(context).requestFocus(_cityFocusNode);
        },
        controller: _stateController,
        style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 20.0),
            hintText: "Estado",
            hintStyle: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
            border: UnderlineInputBorder(
                borderSide: BorderSide(color: colors["primaryColor"])),
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: colors["primaryColor"])),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: colors["primaryColor"]))));
  }

  TextFormField _buildCityField(BuildContext context) {
    return TextFormField(
        validator: (value) {
          if (value.isEmpty) {
            return "Digite uma cidade";
          }
        },
        textInputAction: TextInputAction.next,
        onFieldSubmitted: (_) {
          FocusScope.of(context).requestFocus(_neighborhoodFocusNode);
        },
        controller: _cityController,
        focusNode: _cityFocusNode,
        style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 20.0),
            hintText: "Cidade",
            hintStyle: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
            border: UnderlineInputBorder(
                borderSide: BorderSide(color: colors["primaryColor"])),
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: colors["primaryColor"])),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: colors["primaryColor"]))));
  }

  TextFormField _buildNeighborhoodField(BuildContext context) {
    return TextFormField(
        validator: (value) {
          if (value.isEmpty) {
            return "Digite um bairro";
          }
        },
        textInputAction: TextInputAction.next,
        focusNode: _neighborhoodFocusNode,
        onFieldSubmitted: (_) {
          FocusScope.of(context).requestFocus(_streetFocusNode);
        },
        controller: _neighborhoodController,
        style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 20.0),
            hintText: "Bairro",
            hintStyle: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
            border: UnderlineInputBorder(
                borderSide: BorderSide(color: colors["primaryColor"])),
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: colors["primaryColor"])),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: colors["primaryColor"]))));
  }

  TextFormField _buildStreetField(BuildContext context) {
    return TextFormField(
        validator: (value) {
          if (value.isEmpty) {
            return "Digite uma rua";
          }
        },
        textInputAction: TextInputAction.next,
        focusNode: _streetFocusNode,
        onFieldSubmitted: (_) {
          FocusScope.of(context).requestFocus(_numberFocusNode);
        },
        controller: _streetController,
        style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 20.0),
            hintText: "Rua",
            hintStyle: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
            border: UnderlineInputBorder(
                borderSide: BorderSide(color: colors["primaryColor"])),
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: colors["primaryColor"])),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: colors["primaryColor"]))));
  }

  TextFormField _buildNumberField(BuildContext context) {
    return TextFormField(
        validator: (value) {
          if (value.isEmpty) {
            return "Digite um número";
          }
        },
        focusNode: _numberFocusNode,
        textInputAction: TextInputAction.next,
        onFieldSubmitted: (_) {
          FocusScope.of(context).requestFocus(_complementFocusNode);
        },
        keyboardType: TextInputType.number,
        controller: _numberController,
        style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 20.0),
            hintText: "Número",
            hintStyle: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
            border: UnderlineInputBorder(
                borderSide: BorderSide(color: colors["primaryColor"])),
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: colors["primaryColor"])),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: colors["primaryColor"]))));
  }

  TextFormField _buildComplementField(BuildContext context) {
    return TextFormField(
        textInputAction: TextInputAction.next,
        controller: _complementController,
        focusNode: _complementFocusNode,
        style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 20.0),
            hintText: "Complemento",
            hintStyle: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
            border: UnderlineInputBorder(
                borderSide: BorderSide(color: colors["primaryColor"])),
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: colors["primaryColor"])),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: colors["primaryColor"]))));
  }
}
