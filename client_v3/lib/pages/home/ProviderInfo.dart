import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:client_v3/constants/ui.dart';
import 'package:client_v3/models/Provider.dart';
import 'package:client_v3/pages/home/address/AddressSelection.dart';
import 'package:page_transition/page_transition.dart';

class ProviderInfoPage extends StatelessWidget {
  final Provider provider;

  const ProviderInfoPage({this.provider});

  @override
  Widget build(BuildContext context) {
    return HelprBase(
        child: HelprBody(
            margin:
                const EdgeInsets.symmetric(vertical: 80.0, horizontal: 15.0),
            child: Stack(
              children: <Widget>[
                HelprFloatTop(
                  offset: const Offset(0.0, -40.0),
                  child: SizedBox(
                    height: 100,
                    child: ClipRRect(
                      borderRadius: new BorderRadius.circular(150.0),
                      child: CachedNetworkImage(
                        imageUrl: provider.profilePictureUrl,
                        placeholder: (context, url) => new SpinKitWave(
                              size: 18,
                              color: Colors.white,
                            ),
                        errorWidget: (context, url, error) =>
                            new Icon(Icons.error),
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: Height(context, 0.12)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Center(
                          child: Text(
                        provider.name,
                        style:
                            TextStyle(color: colors["primary"], fontSize: 20.0),
                      )),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                            child: Text(provider.category.name,
                                style:
                                    TextStyle(fontWeight: FontWeight.normal))),
                      ),
                      _Line(),
                      Container(
                        height: Height(context, 0.25),
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: SingleChildScrollView(
                          child: Text(
                            provider.serviceDescription,
                            style: TextStyle(
                                fontWeight: FontWeight.normal, fontSize: 14.0),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      _Line(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Faixa de preço",
                            style: TextStyle(fontSize: 14.0),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 5.0),
                            child: Image.asset(
                              "assets/icons/coins.png",
                              scale: 3.5,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text("Entre ",
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 14.0)),
                            Text(provider.minServicePrice.toString(),
                                style: TextStyle(
                                    color: colors["primary"],
                                    fontWeight: FontWeight.normal,
                                    fontSize: 14.0)),
                            Text(" e ",
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 14.0)),
                            Text(provider.maxServicePrice.toString(),
                                style: TextStyle(
                                    color: colors["primary"],
                                    fontWeight: FontWeight.normal,
                                    fontSize: 14.0)),
                            Text(" créditos",
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 14.0))
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                HelprFloatBottom(
                    offset: const Offset(0.0, 25.0),
                    child: HelprButton(
                        text: "Selecionar endereço",
                        onPressed: () {
                          Navigator.of(context).push(PageTransition(
                              child: AddressSelectionPage(
                                provider: provider,
                              ),
                              type: PageTransitionType.scale));
                        }))
              ],
            )));
  }
}

class _Line extends StatelessWidget {
  const _Line({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
      height: 2,
      color: colors["background"],
    );
  }
}
