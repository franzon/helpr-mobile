import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mobile/utils/constants.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rxdart/rxdart.dart';

class AddAddressPage extends StatelessWidget {
  final BehaviorSubject _loading$ = BehaviorSubject.seeded(false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors["backgroundColor"],
      body: SafeArea(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
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
                        // Transform.translate(
                        //   offset: Offset(0, 30),
                        //   child: Align(
                        //       alignment: Alignment.bottomCenter,
                        //       child: _buildButton(context)),
                        // ),
                        Container(
                          padding: EdgeInsets.only(top: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(bottom: 20.0),
                                child: Center(
                                    child: Text("Adicionando novo endereço",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold))),
                              ),

                              _buildForm()
                              // Row(
                              //   mainAxisSize: MainAxisSize.max,
                              //   mainAxisAlignment: MainAxisAlignment.center,
                              //   children: <Widget>[
                              //     Padding(
                              //       padding:
                              //           EdgeInsets.symmetric(horizontal: 20),
                              //       child: Container(
                              //         height: 5,
                              //         color: colors["backgroundColor"],
                              //       ),
                              //     )
                              //   ],
                              // ),
                            ],
                          ),
                        )
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

  Padding _buildForm() {
    return Padding(
      padding: const EdgeInsets.only(left: 50, right: 50, bottom: 50),
      child: Form(
        child: Column(
          children: <Widget>[_buildCepTextField()],
        ),
      ),
    );
  }

  Container _buildCitySelect() {}

  TextFormField _buildCepTextField() {
    return TextFormField(
        validator: (value) {
          // if (value.isEmpty || !_emailRegex.hasMatch(value)) {
          //   return "Email inválido";
          // }
        },
        textInputAction: TextInputAction.next,
        onFieldSubmitted: (_) {
          // FocusScope.of(context).requestFocus(_passwordFocusNode);
        },
        // controller: _emailController,
        style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 20.0),
            hintText: "Digite seu CEP",
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

  TextFormField _buildCityTextField() {
    return TextFormField(
        validator: (value) {
          // if (value.isEmpty || !_emailRegex.hasMatch(value)) {
          //   return "Email inválido";
          // }
        },
        textInputAction: TextInputAction.next,
        onFieldSubmitted: (_) {
          // FocusScope.of(context).requestFocus(_passwordFocusNode);
        },
        // controller: _emailController,
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

  Widget _buildAddressItem() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: colors["backgroundColor"]),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              // _submitForm();
            },
            child: Container(
              width: 250,
              height: 80,
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.home),
                  ),
                  Expanded(
                    child: Text(
                      "Rua Carlos Sumaré, Jardin Picerno, número 123",
                      maxLines: 2,
                    ),
                  )
                ],
              ),
              // child: StreamBuilder(
              //     stream: _loading$.stream,
              //     builder: (context, snapshot) {
              //       return Center(
              //           child: !snapshot
              //                       .hasData ||
              //                   !snapshot.data
              //               ? Text(
              //                   "Confirmar",
              //                   style: TextStyle(
              //                     fontWeight:
              //                         FontWeight
              //                             .bold,
              //                   ),
              //                 )
              //               : SpinKitWave(
              //                   color:
              //                       Colors.white,
              //                   size: 20,
              //                 ));
              //     }),
            ),
          ),
        ),
      ),
    );
  }

  Padding _buildAddAddressButton(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 10.0),
        child: GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.rightToLeft,
                    duration: Duration(milliseconds: 200),
                    alignment: Alignment.center,
                    child: AddAddressPage()));
          },
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: colors["backgroundColor"]),
            child: DottedBorder(
              gap: 3,
              color: colors["primaryColor"],
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    // _submitForm();
                  },
                  child: Container(
                    width: 200,
                    height: 40,
                    child: StreamBuilder(
                        stream: _loading$.stream,
                        builder: (context, snapshot) {
                          return Center(
                              child: !snapshot.hasData || !snapshot.data
                                  ? Text(
                                      "Adicionar endereço",
                                      style: TextStyle(),
                                    )
                                  : SpinKitWave(
                                      color: Colors.white,
                                      size: 20,
                                    ));
                        }),
                  ),
                ),
              ),
            ),
          ),
        ));
  }

  Padding _buildCurrentLocationButton(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 10.0),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: colors["backgroundColor"]),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                // _submitForm();
              },
              child: Container(
                width: 200,
                height: 55,
                child: StreamBuilder(
                    stream: _loading$.stream,
                    builder: (context, snapshot) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                            child: !snapshot.hasData || !snapshot.data
                                ? Row(
                                    // mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Icon(Icons.gps_fixed),
                                      ),
                                      Text(
                                        "Usar posição atual",
                                        style: TextStyle(),
                                      )
                                    ],
                                  )
                                : SpinKitWave(
                                    color: Colors.white,
                                    size: 20,
                                  )),
                      );
                    }),
              ),
            ),
          ),
        ));
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

  Container _buildButton(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: colors["primaryColor"]),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            // _submitForm();
          },
          child: Container(
            width: 200,
            height: 60,
            child: StreamBuilder(
                stream: _loading$.stream,
                builder: (context, snapshot) {
                  return Center(
                      child: !snapshot.hasData || !snapshot.data
                          ? Text(
                              "Confirmar",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          : SpinKitWave(
                              color: Colors.white,
                              size: 20,
                            ));
                }),
          ),
        ),
      ),
    );
  }
}
