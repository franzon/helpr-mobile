import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:location/location.dart';
import 'package:mobile/api/categories_api.dart';
import 'package:mobile/main.dart';
import 'package:mobile/models/Category.dart';
import 'package:mobile/models/User.dart';
import 'package:mobile/pages/home/provider_results/provider_results_page.dart';
import 'package:mobile/providers/user_provider.dart';
import 'package:mobile/utils/constants.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rxdart/rxdart.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:mobile/blocs/categories_bloc.dart';
// import 'package:mobile/blocs/user_bloc.dart';
// import 'package:mobile/models/Category.dart';
// import 'package:mobile/pages/home/client_home_all_categories.dart';
// import 'package:mobile/pages/home/client_home_drawer.dart';
// import 'package:mobile/pages/home/provider_results/provider_results_page.dart';
// import 'package:mobile/utils/constants.dart';
// import 'package:page_transition/page_transition.dart';

class ClientHomePage extends StatelessWidget {
  final userProvider = getIt.get<UserProvider>();

  final BehaviorSubject<List<Category>> _popularCategories$ =
      BehaviorSubject.seeded(null);

  final locationGetter = Location();

  @override
  Widget build(BuildContext context) {
    userProvider.stream$.listen((user) async {
      try {
        // Just to ask permission
        locationGetter.getLocation();

        final result = await CategoriesApi.getPopularCategories();
        debugPrint(result.toString());
        switch (result["message"]) {
          case "success":

            // só na gambiarra
            final data = (result["data"] as List)
                .map((i) => Category(id: i["identifier"], title: i["title"]))
                .toList();
            debugPrint(data.toString());
            _popularCategories$.add(data);
            break;
          default:
        }
      } catch (e) {
        debugPrint(e.toString());
      }

      if (user.mainAddress == null) {
        // Navigator.pushReplacement(
        //     context,
        //     PageTransition(
        //         duration: const Duration(milliseconds: 500),
        //         type: PageTransitionType.fade,
        //         child: AddressPage()));
      }
    });

    return Scaffold(
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
      backgroundColor: colors["backgroundColor"],
      body: StreamBuilder<User>(
          stream: userProvider.stream$,
          builder: (context, snapshot) {
            return Column(
              children: <Widget>[
                Container(
                  height: 180,
                  color: colors["backgroundColor2"],
                  child: Stack(
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[_buildHeader(snapshot)],
                      ),
                      Transform.translate(
                        offset: Offset(0, 30),
                        child: _buildSearch(),
                      )
                    ],
                  ),
                ),
                Column(
                  children: <Widget>[
                    Container(
                      margin:
                          const EdgeInsets.only(top: 90, left: 20, right: 20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: colors["backgroundColor2"]),
                      height: 230,
                      child: StreamBuilder(
                        stream: _popularCategories$,
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.hasData) {
                            return GridView.count(
                              shrinkWrap: true,
                              crossAxisCount: 3,
                              children: <Widget>[
                                for (Category category in snapshot.data)
                                  _buildCategoryIcon(context,
                                      category: category),
                              ],
                            );
                          }
                          return SpinKitWave(
                            color: colors["primaryColor"],
                          );
                        },
                      ),
                    ),
                    Container(
                      child: Row(
                        children: <Widget>[
                          _buildReputationCard(snapshot),
                          _buildCreditsCard(snapshot)
                        ],
                      ),
                    )
                  ],
                )
              ],
            );
          }),
    );
  }

  Expanded _buildReputationCard(AsyncSnapshot<User> snapshot) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(top: 20, left: 20, right: 5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: colors["backgroundColor2"]),
        height: 120,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "Reputação",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: Image.asset(
                      "assets/icons/reputation.png",
                      scale: 2.5,
                    ),
                  ),
                  Text(
                    snapshot.hasData ? snapshot.data.reputation.toString() : "",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: colors["primaryColor"]),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Expanded _buildCreditsCard(AsyncSnapshot<User> snapshot) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(top: 20, right: 20, left: 5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: colors["backgroundColor2"]),
        height: 120,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "Créditos",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: Image.asset(
                      "assets/icons/coins.png",
                      scale: 2.5,
                    ),
                  ),
                  Text(
                    snapshot.hasData ? snapshot.data.credits.toString() : "",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: colors["primaryColor"]),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryIcon(BuildContext context, {Category category}) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            PageTransition(
                type: PageTransitionType.leftToRightWithFade,
                duration: Duration(milliseconds: 300),
                alignment: Alignment.center,
                child: ProviderResultsPage(
                  category: category,
                )));
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            "assets/icons/" + category.id + ".png",
            scale: 1.9,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              category.title,
              style: TextStyle(color: Colors.white, fontFamily: "Montserrat"),
            ),
          )
        ],
      ),
    );
  }

  Align _buildSearch() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 60,
        width: 250,
        child: TextField(
          style: TextStyle(color: Colors.white, fontFamily: "Montserrat"),
          decoration: InputDecoration(
              hintText: "Procurar categoria",
              hintMaxLines: 1,
              hintStyle: TextStyle(
                color: Colors.white,
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
      ),
    );
  }

  Center _buildHeader(AsyncSnapshot<User> snapshot) {
    return Center(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          "Olá, ",
          style: TextStyle(fontSize: 22),
        ),
        Text(
          snapshot.hasData ? snapshot.data.name : "",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        ),
      ],
    ));
  }
}
