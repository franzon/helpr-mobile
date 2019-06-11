import "package:flutter/material.dart";
import 'package:mobile/utils/constants.dart';
import 'package:page_transition/page_transition.dart';
import 'package:mobile/pages/acitivities.dart';
import '../utils/constants.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Services> services = [
    Services("João", "1", "1"),
  ];

  AppBar _buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: colors["backgroundColor"],
      title: Center(
        child: Text(
          "Bem vindo",
          style: TextStyle(color: Colors.white, fontFamily: "Montserrat"),
        ),
      ),
    );
  }

  // Widget _buildInfosCardService(Services service) {

  // }

  Widget _buildServiceCard(Services service) {
    return Container(
      width: 120,
      height: 145,
      padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
      margin: EdgeInsets.only(left: 32, right: 32, top: 2, bottom: 2),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(16)),
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 1)]),
      // child: _buildInfosCardService(service),
    );
  }

  Widget _buildCardServices() {
    return ListView.builder(
        itemCount: services.length,
        itemBuilder: (BuildContext context, int index) {
          var service = services.elementAt(index);
          return _buildServiceCard(service);
        });
  }

  Widget _builderContainerServices(double height) {
    return Align(
      child: Stack(
        children: <Widget>[
          Container(
            height: height / 1.5,
            margin: EdgeInsets.fromLTRB(16, 0, 16, 0),
            decoration: BoxDecoration(
              color: Color(0xffe8eaf6),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
          ),
          Center(
            heightFactor: 2.0,
            child: Text(
              "Serviços",
              style: TextStyle(
                  fontSize: 22, color: Colors.black, fontFamily: "Montserrat"),
            ),
          ),
          // _buildCardServices(), 
        ],
      ),
    );
  }

  Widget _builderIconButtons() {
    return Container(
      decoration: BoxDecoration(color: colors["backgroundColor"]),
      child: Padding(
        padding: const EdgeInsets.all(38.0),
        child: Row(children: <Widget>[
          Column(children: <Widget>[
            IconButton(
                onPressed: () {},
                icon: Icon(Icons.attach_money, color: Colors.white)),
            Text("Ganhos",
                style: TextStyle(color: Colors.white, fontFamily: "Montserrat"))
          ]),
          Spacer(),
          Column(children: <Widget>[
            IconButton(
                onPressed: () {},
                icon: Icon(Icons.person, color: Colors.white)),
            Text("Perfil",
                style: TextStyle(color: Colors.white, fontFamily: "Montserrat"))
          ]),
          Spacer(),
          Column(children: <Widget>[
            IconButton(
                onPressed: () {
                  Navigator.push(context, PageTransition(
                    type: PageTransitionType.scale,
                    child: ActivitiesPage(),
                  ));
                },
                icon: Icon(Icons.settings, color: Colors.white)),
            Text("Atividades",
                style: TextStyle(color: Colors.white, fontFamily: "Montserrat"))
          ]),
          // IconButton(icon: Icon()),
        ]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
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
=======
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: colors["backgroundColor"],
      appBar: _buildAppBar(),
      body: SafeArea(
        child: Column(children: <Widget>[
          _builderIconButtons(),
          // _buildCardServices()
          _builderContainerServices(height),
        ]),
      ),
    );
>>>>>>> master
  }
}

class Services {
  final String clientName;
  final String socketId;
  final String clientId;

  Services(this.clientName, this.socketId, this.clientId);
}