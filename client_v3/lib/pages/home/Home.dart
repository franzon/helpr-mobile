import 'dart:convert';

import 'package:client_v3/pages/authentication/EmailConfirmation.dart';
import 'package:client_v3/providers/SocketProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keychain/flutter_keychain.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:client_v3/constants/ui.dart';
import 'package:client_v3/models/Category.dart';
import 'package:client_v3/models/Client.dart';
import 'package:client_v3/pages/home/ProviderList.dart';
import 'package:client_v3/providers/CategoriesProvider.dart';
import 'package:client_v3/providers/ClientProvider.dart';
import 'package:client_v3/setupSingletons.dart';
import 'package:page_transition/page_transition.dart';
import 'package:client_v3/pages/home/customDrawer.dart';

class _SearchField extends StatefulWidget {
  @override
  __SearchFieldState createState() => __SearchFieldState();
}

class __SearchFieldState extends State<_SearchField> {
  final categoriesProvider = getIt<CategoriesProvider>();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Width(context, 0.7),
      child: TextField(
        onChanged: (text) {
          categoriesProvider.filterCategories(text);
        },
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
            hintText: "Procurar categoria",
            hintMaxLines: 1,
            filled: true,
            fillColor: colors["background"],
            hintStyle: TextStyle(
              color: Colors.white,
            ),
            prefixIcon: Padding(
              padding: const EdgeInsets.only(left: 10, right: 5),
              child: Icon(Icons.search, color: Colors.white),
            ),
            border: OutlineInputBorder(
                borderSide: BorderSide(color: colors["primary"]),
                borderRadius: BorderRadius.all(Radius.circular(5))),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: colors["primary"]),
                borderRadius: BorderRadius.all(Radius.circular(5))),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: colors["primary"]),
                borderRadius: BorderRadius.all(Radius.circular(5)))),
      ),
    );
  }
}

class _HomePageHeader extends StatelessWidget {
  final clientProvider = getIt<ClientProvider>();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: colors["background2"],
      height: Height(context, 0.25),
      child: Stack(
        children: <Widget>[
          Padding(
              padding: const EdgeInsets.only(bottom: 25.0, left: 40.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Icon(Icons.settings, color: Colors.white),
              )),
          Padding(
            padding: const EdgeInsets.only(bottom: 25.0),
            child: Align(
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Olá, ",
                    style: TextStyle(fontSize: 20),
                  ),
                  StreamBuilder<Client>(
                      stream: clientProvider.client,
                      builder: (context, snapshot) {
                        return snapshot.hasData
                            ? Text(
                                snapshot.data.name,
                                style: TextStyle(
                                    fontSize: 20, color: colors["primary"]),
                              )
                            : Text("");
                      }),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 25.0, right: 40.0),
            child: Align(
                alignment: Alignment.centerRight,
                child: Icon(
                  Icons.chat,
                  color: Colors.white,
                )),
          ),
          HelprFloatBottom(child: _SearchField())
        ],
      ),
    );
  }
}

class _CategoryIcon extends StatelessWidget {
  final Category category;

  const _CategoryIcon({this.category});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(PageTransition(
            child: ProviderListPage(
              category: category,
            ),
            type: PageTransitionType.downToUp));
      },
      child: Container(
        child: Column(
          children: <Widget>[
            Image.asset(
              "assets/icons/" + category.id + ".png",
              scale: 1.7,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                category.name,
                style: TextStyle(fontWeight: FontWeight.normal),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _CategoryGrid extends StatelessWidget {
  final categoriesProvider = getIt<CategoriesProvider>()..loadCategories();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: StreamBuilder<List<Category>>(
          stream: categoriesProvider.filteredCategories,
          builder: (context, snapshot) {
            return Container(
                child: snapshot.hasData
                    ? GridView.count(
                        crossAxisCount: 3,
                        children: <Widget>[
                          for (Category category in snapshot.data)
                            _CategoryIcon(
                              category: Category(
                                  id: category.id, name: category.name),
                            )
                        ],
                      )
                    : Center(
                        child: SpinKitWave(
                        color: colors["primary"],
                        size: 20,
                      )));
          }),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _clientProvider = getIt<ClientProvider>();
  final socketProvider = getIt<SocketProvider>();

  @override
  void initState() {
    _clientProvider.client.listen((client) {
      if (client == null) return;
      if (!client.isConfirmed) {
        Navigator.of(context).pushReplacement(PageTransition(
            child: EmailConfirmation(), type: PageTransitionType.downToUp));
      } else {
        if (!socketProvider.sentAdd) {
          socketProvider.channel.sink.add(json.encode({
            "action": "add",
            "user": {
              "userName": client.name,
              "type": "client",
              "dbId": client.dbId
            }
          }));
          socketProvider.sentAdd = true;
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return HelprBase(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _HomePageHeader(),
          Container(
            height: Height(context, 0.1),
          ),
          Container(
              height: Height(context, 0.4),
              child: HelprBody(child: _CategoryGrid())),
          Container(
              height: Height(context, 0.2),
              child: HelprBody(
                  child: Row(
                children: <Widget>[
                  _ReputationCard(),
                  Container(
                    width: 2,
                    color: colors["background"],
                  ),
                  _CreditsCard(),
                ],
              ))),
        ],
      ),
      drawer: CustomDrawer(),
    );
  }
}

class _ReputationCard extends StatelessWidget {
  final clientProvider = getIt<ClientProvider>();
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Reputação"),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: StreamBuilder<Client>(
                  stream: clientProvider.client,
                  builder: (context, snapshot) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset(
                          "assets/icons/reputation.png",
                          scale: 2.5,
                        ),
                        Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              snapshot.hasData
                                  ? snapshot.data.reputation.toString()
                                  : "",
                              style: TextStyle(color: colors["primary"]),
                            ))
                      ],
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}

class _CreditsCard extends StatelessWidget {
  final clientProvider = getIt<ClientProvider>();
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Créditos"),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: StreamBuilder<Client>(
                  stream: clientProvider.client,
                  builder: (context, snapshot) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset(
                          "assets/icons/coins.png",
                          scale: 2.5,
                        ),
                        Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              snapshot.hasData
                                  ? snapshot.data.credits.toString()
                                  : "",
                              style: TextStyle(color: colors["primary"]),
                            ))
                      ],
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
