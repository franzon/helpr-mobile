import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';

import 'package:mobile/api/socket.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  WSocket socket;
  String title = "Socket test";
  String name = "Everton";
  String id = "5ccc976647fe3a382f4d0f65";
  List<Map> providers;


  @override
  void initState() { 
    super.initState();
    initPlatformState();
    
    final String str = json.encode({
          "action": "add client",
          "user": {
            "userName": name,
            "userId": id,
          }
        });
      
    print(str);

    socket.send(str);
    providers = [
      {
        'userId': 'afgasga',
        'userName': 'Everton'
      },{
        'userId': 'afgasga',
        'userName': 'Everton'
      },{
        'userId': 'afgasga',
        'userName': 'Everton'
      }
    ];
  }

  Future<Widget> initPlatformState() async {
    try {
      socket = new WSocket();

      socket.connect();

      print("ola");
    } on Exception catch (err) {
      print("Exception" + err.toString());
    }
    return null;
  }

  Widget receiveProviders(String message) {
    Map<String, dynamic> data = json.decode(message);

    if (data['listener'] != 'providers') return Container();

    providers = [];
    List<dynamic> provids = data['providers'];
    provids.forEach((value) {
      providers.add(value);
    });
    return ListView.builder(
      shrinkWrap: true,
      itemCount: providers.length,
      itemBuilder: (BuildContext context, int index) {
        return Text(providers[index]['userName']);
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: StreamBuilder(
                stream: socket.channel.stream,
                builder: (BuildContext context, snapshot) {
                  if (snapshot.hasData) {
                    return receiveProviders(snapshot.data);
                  }
                  return Container();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }


  @override
  void dispose() {
    socket.reset();
    super.dispose();
  }
}
