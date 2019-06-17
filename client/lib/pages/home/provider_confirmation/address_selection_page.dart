import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mobile/api/user_api.dart';
import 'package:mobile/models/Address.dart';
import 'package:mobile/pages/home/provider_confirmation/add_address_page.dart';
import 'package:mobile/utils/constants.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rxdart/rxdart.dart';
import 'package:dotted_border/dotted_border.dart';

class AddressSelectionPage extends StatelessWidget {
  final BehaviorSubject _loading$ = BehaviorSubject.seeded(false);
  final BehaviorSubject<AddressesApiResult> _addresses$ =
      BehaviorSubject<AddressesApiResult>.seeded(null);

  void loadAddresses() async {
    try {
      final res = await UserApi.getUserAddresses();
      final obj = AddressesApiResult.fromJson(res["data"]);
      _addresses$.add(obj);
      debugPrint(_loading$.value.toString());
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    loadAddresses();

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
                                    child: Text("Escolha um endereço",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold))),
                              ),

                              SizedBox(
                                height: 200,
                                child: SingleChildScrollView(
                                  child: StreamBuilder<AddressesApiResult>(
                                      stream: _addresses$,
                                      builder: (context, snapshot) {
                                        return snapshot.hasData
                                            ? Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: snapshot
                                                    .data.addresses
                                                    .map((a) =>
                                                        _buildAddressItem(a))
                                                    .toList(),

                                                // _buildAddressItem(),
                                                // _buildAddressItem()
                                              )
                                            : Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  SpinKitWave(
                                                    color:
                                                        colors["primaryColor"],
                                                    size: 20,
                                                  )
                                                ],
                                              );
                                      }),
                                ),
                              ),

                              Padding(
                                  padding: EdgeInsets.only(top: 8),
                                  child: _buildAddAddressButton(context)),
                              Center(
                                child: Text("ou"),
                              ),
                              _buildCurrentLocationButton(context),

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

  Widget _buildAddressItem(Address address) {
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
                      address.street +
                          ", " +
                          address.neighborhood +
                          ", número " +
                          address.number.toString(),
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
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.rightToLeft,
                          duration: Duration(milliseconds: 200),
                          alignment: Alignment.center,
                          child: AddAddressPage()));

                  debugPrint("gi");
                },
                child: Container(
                    width: 200,
                    height: 40,
                    child: Center(
                        child: Text(
                      "Adicionar endereço",
                      style: TextStyle(),
                    ))),
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
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                        child: Row(
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
                    )),
                  )),
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
