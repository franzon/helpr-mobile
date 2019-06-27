import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:mobile/utils/constants.dart';
import 'package:geocoder/geocoder.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/io.dart';

class ConfirmServicePage extends StatefulWidget {
  ConfirmServicePage({Key key, this.user, this.location, this.channel, this.service })
      : super(key: key);

  final user;
  final location;
  final channel;
  final service;

  _ConfirmServicePageState createState() => _ConfirmServicePageState(
      user: user, location: location, channel: channel, service: service);
}

class _ConfirmServicePageState extends State<ConfirmServicePage> {
  _ConfirmServicePageState(
      {Key key, this.user, this.service, this.location, this.channel});

  var location;

  WebSocketChannel channel;
  StreamBuilder stream;

  bool added = false;

  bool loaded = false;
  var curLocation;

  var latitude;
  var longitude;

  var clientAddress = "";
  bool addr = false;

  MapController controller;


  var user;

  String service;
  String clientName;

  Size screenSize;

  @override
  void initState() {
    super.initState();

    latitude = location["latitude"];
    longitude = location["longitude"];

    clientName = user["userName"];


    print(latitude);

    try {
      // Geocoder.local
      //     .findAddressesFromCoordinates(Coordinates(latitude, longitude))
      //     .then((address) {
      //   setState(() {
      //     addr = true;
      //     clientAddress = address.first.addressLine;
      //   });
      // });
    } catch (err) {
      clientAddress = "Não foi possivel definir o endereço do cliente";
    }

    controller = MapController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  void respondService(String method) {
    channel.sink.add(jsonEncode({
      "action": method,
      "user": user,
    }));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      screenSize = MediaQuery.of(context).size;
    });
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Color(0x77ffffff),
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: colors["backgroundColor"],
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    );
    return Center(
      child: Stack(
        children: <Widget>[
          buildFlutterMap(),
          Align(
            alignment: Alignment.bottomCenter,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              child: Container(
                height: screenSize.height / 2.6,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: colors["backgroundColor"],
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                ),
                child: Column(
                  children: <Widget>[
                    Spacer(),
                    Container(
                      padding: EdgeInsets.only(top: 10),
                      height: screenSize.height / 10.3,
                      width: screenSize.height / 10.3,
                      decoration: BoxDecoration(
                        color: colors['accentColor'],
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Image.asset('assets/perfil.png'),
                    ),
                    Expanded(
                      flex: 3,
                      child: Container(
                        child: Column(
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                clientName,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Montserrat Bold',
                                  fontWeight: FontWeight.w700,
                                  fontSize: screenSize.width /
                                      (clientName.length / 0.6),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                child: Text(
                                  clientAddress,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Montserrat'),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        service,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Montserrat Bold',
                          fontSize: 30,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: Row(
                        children: <Widget>[
                          Spacer(),
                          Expanded(
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    width: 60,
                                    height: 60,
                                    decoration: BoxDecoration(
                                      color: Colors.red[400],
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    child: FlatButton(
                                      onPressed: () => respondService("denyService"),
                                      child: Icon(Icons.close),
                                    ),
                                  ),
                                ),
                                Text(
                                  "Recusar",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Montserrat',
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    width: 60,
                                    height: 60,
                                    decoration: BoxDecoration(
                                      color: Colors.green[400],
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    child: FlatButton(
                                      onPressed: () => respondService("acceptService"),
                                      child: Icon(Icons.check),
                                    ),
                                  ),
                                ),
                                Text(
                                  "Aceitar",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Montserrat',
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Spacer(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  FlutterMap buildFlutterMap() {
    return FlutterMap(
      options: MapOptions(
        center: LatLng(latitude - (screenSize.height / 180000), longitude),
        zoom: 16.0,
      ),
      layers: [
        TileLayerOptions(
          urlTemplate: 'http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
          subdomains: ['a', 'b', 'c'],
        ),
        MarkerLayerOptions(
          markers: [
            Marker(
              point: LatLng(latitude, longitude),
              builder: (ctx) {
                return Container(
                  child: Icon(
                    Icons.person_pin,
                    color: colors['backgroungColor'],
                    size: 40,
                    textDirection: TextDirection.rtl,
                  ),
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}
