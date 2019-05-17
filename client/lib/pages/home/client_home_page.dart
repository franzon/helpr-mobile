import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mobile/api/categories_api.dart';
import 'package:mobile/blocs/user_bloc.dart';
import 'package:mobile/models/Category.dart';
import 'package:mobile/pages/home/client_home_all_categories.dart';
import 'package:mobile/pages/home/client_home_drawer.dart';
import 'package:page_transition/page_transition.dart';
import 'package:simple_animations/simple_animations.dart';

import 'package:mobile/utils/constants.dart';

class CategoryIcon extends StatelessWidget {
  final String id;
  final String name;

  CategoryIcon({@required this.id, @required this.name});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Image.asset("assets/icons/" + this.id + ".png"),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(
            this.name,
            style: TextStyle(color: Colors.white, fontFamily: "Montserrat"),
          ),
        )
      ],
    );
  }
}

class ClientHomePage extends StatefulWidget {
  const ClientHomePage({Key key}) : super(key: key);

  @override
  _ClientHomePageState createState() => _ClientHomePageState();
}

class _ClientHomePageState extends State<ClientHomePage> {
  @override
  Widget build(BuildContext context) {
    final UserBloc userBloc = BlocProvider.of<UserBloc>(context);

    userBloc.dispatch(LoadPage());
    userBloc.dispatch(LoadUser());

    return Scaffold(
      drawer: ClientHomeDrawer(),
      body: Stack(
        children: <Widget>[
          _ClientHomeHeader(
              /*  userBloc: this.userBloc */
              ),
          _ClientHomeSearch()
        ],
      ),
    );
  }
}

class _ClientHomeHeader extends StatelessWidget {
  const _ClientHomeHeader({Key key /* @required this.userBloc */})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UserBloc userBloc = BlocProvider.of<UserBloc>(context);

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
                      BlocBuilder(
                        bloc: userBloc,
                        builder: (BuildContext context, UserState state) {
                          if (state is UserLoading) {
                            return Text("...");
                          } else if (state is UserLoaded) {
                            return Text(state.user.name,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    fontFamily: "Montserrat"));
                          }
                        },
                      ),
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
        _ClientHomeBody()
      ],
    );
  }
}

class _ClientHomeBody extends StatelessWidget {
  const _ClientHomeBody({
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
                  children: <Widget>[_ClientHomeGrid(), _ClientHomeFooter()],
                ),
              )
            ],
          ),
        ));
  }
}

class _ClientHomeGrid extends StatelessWidget {
  const _ClientHomeGrid({
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
                  child: FutureBuilder(
                    future: CategoriesApi.getPopularCategories(5),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return SpinKitWave(
                          color: colors["primaryColor"],
                          size: 20,
                        );
                      } else if (snapshot.connectionState ==
                          ConnectionState.done) {
                        return GridView.count(
                          shrinkWrap: true,
                          crossAxisCount: 3,
                          children: <Widget>[
                            for (Category category in snapshot.data)
                              CategoryIcon(
                                  name: category.name, id: category.id),
                          ],
                        );
                      }
                    },
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

class _ClientHomeFooter extends StatelessWidget {
  const _ClientHomeFooter({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UserBloc userBloc = BlocProvider.of<UserBloc>(context);

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
                              child: BlocBuilder(
                                bloc: userBloc,
                                builder:
                                    (BuildContext context, UserState state) {
                                  if (state is UserLoading) {
                                    return Text("...");
                                  } else if (state is UserLoaded) {
                                    return Text(
                                      state.user.reputation.toString(),
                                      style: TextStyle(
                                        color: colors["primaryColor"],
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "Montserrat",
                                      ),
                                    );
                                  }
                                },
                              ))
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
                              child: BlocBuilder(
                                bloc: userBloc,
                                builder:
                                    (BuildContext context, UserState state) {
                                  if (state is UserLoading) {
                                    return Text("...");
                                  } else if (state is UserLoaded) {
                                    return Text(
                                      state.user.credits.toString(),
                                      style: TextStyle(
                                        color: colors["primaryColor"],
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "Montserrat",
                                      ),
                                    );
                                  }
                                },
                              ))
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

class _ClientHomeSearch extends StatelessWidget {
  const _ClientHomeSearch({
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
