import 'package:flutter/material.dart';
import 'package:mobile/pages/home/client_home_all_categories.dart';
import 'package:mobile/pages/home/client_home_drawer.dart';
import 'package:page_transition/page_transition.dart';

import 'package:mobile/utils/constants.dart';

class CategoryIcon extends StatelessWidget {
  final String iconPath;
  final String text;

  CategoryIcon({@required this.iconPath, @required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Image.asset(this.iconPath),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(
            this.text,
            style: TextStyle(color: Colors.white, fontFamily: "Montserrat"),
          ),
        )
      ],
    );
  }
}

class ClientHomePage extends StatelessWidget {
  const ClientHomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: ClientHomeDrawer(),
      body: Stack(
        children: <Widget>[ClientHomeHeader(), ClientHomeSearch()],
      ),
    );
  }
}

class ClientHomeHeader extends StatelessWidget {
  const ClientHomeHeader({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          flex: 2,
          child: Container(
            color: colors["backgroundColor2"],
            child: Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: Builder(
                      builder: (context) => GestureDetector(
                            child: Icon(Icons.menu, color: Colors.white),
                            onTap: () {
                              Scaffold.of(context).openDrawer();
                            },
                          ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Olá, ",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontFamily: "Montserrat"),
                      ),
                      Text("Jorge",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              fontFamily: "Montserrat"))
                    ],
                  ),
                  Container(
                    child: Builder(
                      builder: (context) => GestureDetector(
                            child: Icon(Icons.help, color: Colors.white),
                            onTap: () {},
                          ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        ClientHomeBody()
      ],
    );
  }
}

class ClientHomeBody extends StatelessWidget {
  const ClientHomeBody({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 8,
        child: Container(
          color: colors["backgroundColor"],
          child: Stack(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                    left: 20.0, right: 20.0, bottom: 30.0, top: 70.0),
                child: Column(
                  children: <Widget>[ClientHomeGrid(), ClientHomeFooter()],
                ),
              )
            ],
          ),
        ));
  }
}

class ClientHomeGrid extends StatelessWidget {
  const ClientHomeGrid({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Container(
        decoration: BoxDecoration(
            color: colors["backgroundColor2"],
            borderRadius: BorderRadius.circular(5)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Text(
                    "Do que precisa hoje?",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                ),
                SizedBox(
                  height: 190,
                  width: 300,
                  child: GridView.count(
                    shrinkWrap: true,
                    crossAxisCount: 3,
                    children: <Widget>[
                      CategoryIcon(
                        text: "Pedreiro",
                        iconPath: "assets/icons/worker.png",
                      ),
                      CategoryIcon(
                        text: "Pintor",
                        iconPath: "assets/icons/painter.png",
                      ),
                      CategoryIcon(
                        text: "Encanador",
                        iconPath: "assets/icons/gas-pipe.png",
                      ),
                      CategoryIcon(
                        text: "Informática",
                        iconPath: "assets/icons/laptop.png",
                      ),
                      CategoryIcon(
                        text: "Pintor",
                        iconPath: "assets/icons/painter.png",
                      ),
                      CategoryIcon(
                        text: "Pintor",
                        iconPath: "assets/icons/painter.png",
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType.scale,
                              alignment: Alignment.bottomCenter,
                              child: ClientHomeAllCategories()));
                    },
                    child: Text(
                      "Mais",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class ClientHomeFooter extends StatelessWidget {
  const ClientHomeFooter({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: Container(
                margin: EdgeInsets.only(right: 5),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(
                        "Reputação",
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image.asset("assets/icons/reputation.png"),
                          Padding(
                            padding: const EdgeInsets.only(left: 15.0),
                            child: Text(
                              "700",
                              style: TextStyle(
                                color: colors["primaryColor"],
                                fontWeight: FontWeight.bold,
                                fontFamily: "Montserrat",
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                decoration: BoxDecoration(
                    color: colors["backgroundColor2"],
                    borderRadius: BorderRadius.circular(5)),
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(right: 5),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(
                        "Créditos",
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image.asset("assets/icons/dollar.png"),
                          Padding(
                            padding: const EdgeInsets.only(left: 15.0),
                            child: Text(
                              "500",
                              style: TextStyle(
                                color: colors["primaryColor"],
                                fontWeight: FontWeight.bold,
                                fontFamily: "Montserrat",
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                decoration: BoxDecoration(
                    color: colors["backgroundColor2"],
                    borderRadius: BorderRadius.circular(5)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ClientHomeSearch extends StatelessWidget {
  const ClientHomeSearch({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20, top: 100),
      height: 60,
      child: TextField(
        style: TextStyle(color: Colors.white, fontFamily: "Montserrat"),
        decoration: InputDecoration(
            hintText: "Procurar por atividade, categoria, etc",
            hintMaxLines: 1,
            hintStyle: TextStyle(
              color: Colors.white,
              fontFamily: "Montserrat",
            ),
            filled: true,
            fillColor: colors["backgroundColor"],
            prefixIcon: Padding(
              padding: const EdgeInsets.only(left: 10, right: 5),
              child: Icon(Icons.search, color: Colors.white),
            ),
            border: OutlineInputBorder(
                borderSide: BorderSide(color: colors["primaryColor"]),
                borderRadius: BorderRadius.all(Radius.circular(5))),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: colors["primaryColor"]),
                borderRadius: BorderRadius.all(Radius.circular(5))),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: colors["primaryColor"]),
                borderRadius: BorderRadius.all(Radius.circular(5)))),
      ),
    );
  }
}
