import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:client_v3/constants/ui.dart';
import 'package:client_v3/models/Address.dart';
import 'package:client_v3/models/Provider.dart';
import 'package:client_v3/providers/ClientProvider.dart';
import 'package:client_v3/providers/SocketProvider.dart';
import 'package:client_v3/setupSingletons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:location/location.dart';
import 'package:page_transition/page_transition.dart';

import '../Home.dart';

enum ServiceStatus { IDLE, WAITING, CONFIRMED, CANCELED }

class ServiceConfirmationPage extends StatefulWidget {
  final Address address;
  final Provider provider;

  ServiceConfirmationPage({@required this.address, @required this.provider});

  @override
  _ServiceConfirmationPageState createState() =>
      _ServiceConfirmationPageState(address: address, provider: provider);
}

class _ServiceConfirmationPageState extends State<ServiceConfirmationPage> {
  final socketProvider = getIt<SocketProvider>();
  final clientProvider = getIt<ClientProvider>();

  final Address address;
  final Provider provider;

  ServiceStatus serviceStatus = ServiceStatus.IDLE;

  Location location;

  _ServiceConfirmationPageState(
      {@required this.address, @required this.provider});

  @override
  void initState() {
    location = Location();

    socketProvider.data.listen((data) {
      final parsed = json.decode(data);
      if (parsed["listener"] == "acceptService") {
        setState(() {
          serviceStatus = ServiceStatus.CONFIRMED;
        });
      } else if (parsed["listener"] == "denyService") {
        setState(() {
          serviceStatus = ServiceStatus.CANCELED;
        });
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return HelprBase(
        child: HelprBody(
            child: Stack(
              children: <Widget>[
                HelprFloatTop(
                  offset: const Offset(0.0, -40.0),
                  child: SizedBox(
                    height: 100,
                    child: ClipRRect(
                      borderRadius: new BorderRadius.circular(150.0),
                      child: CachedNetworkImage(
                        imageUrl: widget.provider.profilePictureUrl,
                        placeholder: (context, url) => SpinKitWave(
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
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Center(
                          child: Text(
                        widget.provider.name,
                        style:
                            TextStyle(color: colors["primary"], fontSize: 20.0),
                      )),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                            child: Text(widget.provider.category.name,
                                style:
                                    TextStyle(fontWeight: FontWeight.normal))),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              margin: const EdgeInsets.all(15.0),
                              padding: const EdgeInsets.all(15.0),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: colors["background"], width: 2),
                                  borderRadius: BorderRadius.circular(10.0)),
                              child: Row(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(right: 15.0),
                                    child: Icon(
                                      Icons.map,
                                      color: colors["primary"],
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      widget.address.street +
                                          ", " +
                                          widget.address.neighborhood +
                                          ", número " +
                                          widget.address.number +
                                          " - " +
                                          widget.address.city,
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 14.0),
                                      maxLines: 2,
                                      softWrap: true,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (serviceStatus == ServiceStatus.WAITING)
                              Column(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(top: 50.0),
                                    child: SpinKitWave(
                                      color: colors["primary"],
                                      size: 25,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Text("Aguardando confirmação"),
                                  )
                                ],
                              )
                            else
                              if (serviceStatus == ServiceStatus.CONFIRMED)
                                Column(
                                  children: <Widget>[
                                    Padding(
                                        padding:
                                            const EdgeInsets.only(top: 50.0),
                                        child: Icon(
                                          Icons.check,
                                          size: 48,
                                          color: colors["primary"],
                                        )),
                                    Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Text("Confirmado"),
                                    )
                                  ],
                                )
                              else
                                if (serviceStatus == ServiceStatus.CANCELED)
                                  Column(
                                    children: <Widget>[
                                      Padding(
                                          padding:
                                              const EdgeInsets.only(top: 50.0),
                                          child: Icon(
                                            Icons.cancel,
                                            size: 48,
                                            color: colors["primary"],
                                          )),
                                      Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: Text("Cancelado"),
                                      )
                                    ],
                                  )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                HelprFloatBottom(
                    offset: const Offset(0.0, 25.0),
                    child: serviceStatus == ServiceStatus.IDLE
                        ? HelprButton(
                            text: "Confirmar",
                            onPressed: () async {
                              setState(() {
                                serviceStatus = ServiceStatus.WAITING;
                              });

                              try {
                                final currentLocation =
                                    await location.getLocation();

                                clientProvider.client.take(1).listen((client) {
                                  socketProvider.channel.sink.add(json.encode({
                                    "action": "newService",
                                    "user": {
                                      "providerId": provider.id,
                                    },
                                    "userLocation": {
                                      "longitude": currentLocation["longitude"],
                                      "latitude": currentLocation["latitude"]
                                    }
                                  }));
                                });
                              } catch (e) {
                                debugPrint("Error getting user position");
                              }
                            })
                        : serviceStatus == ServiceStatus.WAITING
                            ? HelprButton(
                                text: "Cancelar",
                                onPressed: () {
                                  setState(() {
                                    serviceStatus = ServiceStatus.CANCELED;
                                  });

                                  clientProvider.client
                                      .take(1)
                                      .listen((client) {
                                    socketProvider.channel.sink
                                        .add(json.encode({
                                      "action": "cancelService",
                                      "user": {
                                        "providerId": provider.id,
                                      },
                                    }));
                                  });
                                })
                            : HelprButton(
                                text: "Voltar para a tela inicial",
                                onPressed: () {
                                  Navigator.of(context).pushReplacement(
                                      PageTransition(
                                          child: HomePage(),
                                          type: PageTransitionType.downToUp));
                                }))
              ],
            ),
            margin: EdgeInsets.symmetric(vertical: 80.0, horizontal: 15.0)));
  }
}
