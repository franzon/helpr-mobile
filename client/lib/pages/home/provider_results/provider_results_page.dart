import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_fluid_slider/flutter_fluid_slider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:location/location.dart';
import 'package:mobile/api/provider_api.dart';
import 'package:mobile/models/Category.dart';
import 'package:mobile/models/ProviderResult.dart';
import 'package:mobile/pages/home/provider_results/provider_results_card.dart';
import 'package:mobile/providers/user_provider.dart';
import 'package:mobile/utils/constants.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';
import 'package:simple_animations/simple_animations.dart';

import '../../../main.dart';

class _ProviderResultsFilter {
  final int maxDistance;
  final bool showOffline;

  _ProviderResultsFilter(
      {@required this.maxDistance, @required this.showOffline});
}

class ProviderResultsPage extends StatefulWidget {
  final Category category;

  ProviderResultsPage({@required this.category});

  @override
  _ProviderResultsPageState createState() =>
      _ProviderResultsPageState(category: category);
}

class _ProviderResultsPageState extends State<ProviderResultsPage>
    with TickerProviderStateMixin {
  bool showFilter = false;

  final BehaviorSubject<int> _maxDistance$ = BehaviorSubject.seeded(5);
  final BehaviorSubject<bool> _showOffline$ = BehaviorSubject.seeded(false);

  AnimationController animationController;
  Animation<double> animation;
  double _height = 0.0;

  final Category category;
  final userProvider = getIt.get<UserProvider>();

  final BehaviorSubject<List<ProviderResult>> _providers$ =
      BehaviorSubject.seeded(null);
  final locationGetter = Location();

  _ProviderResultsPageState({@required this.category});

  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    )..addListener(() => setState(() {}));
    animation = Tween(begin: 0.0, end: 0.25).animate(animationController);

    userProvider.stream$.listen((user) async {
      if (user.mainAddress == null) {
        // Navigator.pushReplacement(
        //     context,
        //     PageTransition(
        //         duration: const Duration(milliseconds: 500),
        //         type: PageTransitionType.fade,
        //         child: AddressPage()));
      }
    });

    try {
      Observable.combineLatest2(
          _maxDistance$.debounceTime(const Duration(milliseconds: 300)),
          _showOffline$, (int maxDistance, bool showOffline) {
        return _ProviderResultsFilter(
            maxDistance: maxDistance, showOffline: showOffline);
      }).listen((_ProviderResultsFilter filters) async {
        final currentLocation = await locationGetter.getLocation();

        final result = await ProviderApi.getNearbyProviders(
            category: category.id,
            maxDistance: filters.maxDistance,
            clientLatitude: currentLocation["latitude"],
            clientLongitude: currentLocation["longitude"]);

        debugPrint(result["data"].toString());
        switch (result["message"]) {
          case "success":
            final data = (result["data"] as List)
                .asMap()
                .map((i, el) {
                  final pr = ProviderResult.fromJson(el);
                  debugPrint(i.toString());
                  pr.index = i;
                  return MapEntry(i, pr);
                })
                .values
                .where((i) => filters.showOffline || i.isOnline)
                .toList();
            _providers$.add(data);
            break;
          default:
        }
      });
    } catch (e) {
      debugPrint(e.toString());
    }

    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    _providers$.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors["backgroundColor"],
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
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
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(),
                  ),
                  GestureDetector(
                    child: RotationTransition(
                        turns: animation, child: Icon(Icons.filter_list)),
                    onTap: () {
                      setState(() {
                        showFilter = !showFilter;

                        if (showFilter) {
                          animationController.forward();
                          _height = MediaQuery.of(context).size.height * 0.3;
                        } else {
                          _height = 0.0;
                          animationController.reverse();
                        }
                      });
                    },
                  )
                ],
              ),
            ),
            AnimatedSize(
              curve: Curves.easeInOutSine,
              child: Container(
                height: _height,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(100),
                      bottomRight: Radius.circular(100)),
                  color: colors["backgroundColor2"],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("Mostrar "),
                          Text("encanadores"),
                          Text(" offline?")
                        ],
                      ),
                      Switch(
                        activeColor: colors["primaryColor"],
                        value: _showOffline$.value,
                        onChanged: (bool value) {
                          setState(() {
                            _showOffline$.add(!_showOffline$.value);
                          });
                        },
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("Distância máxima"),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 25),
                        padding: EdgeInsets.only(top: 15.0),
                        child: FluidSlider(
                          min: 5.0,
                          max: 25.0,
                          height: 30.0,
                          sliderColor: colors["primaryColor"],
                          value: _maxDistance$.value.toDouble(),
                          labelsTextStyle: TextStyle(fontSize: 14),
                          valueTextStyle: TextStyle(
                              fontSize: 12,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                          onChanged: (double value) {
                            setState(() {
                              _maxDistance$.add(value.toInt());
                            });
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
              duration: Duration(milliseconds: 400),
              vsync: this,
            ),
            Flexible(
              child: Container(
                child: StreamBuilder<List<ProviderResult>>(
                  stream: _providers$,
                  builder: (BuildContext context,
                      AsyncSnapshot<List<ProviderResult>> snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        padding: EdgeInsets.only(top: 40),
                        shrinkWrap: true,
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.only(
                              left: 20.0,
                              right: 20.0,
                            ),
                            child: ProviderResultsCard(
                              provider: snapshot.data[index],
                            ),
                          );
                        },
                      );
                      // return GridView.count(
                      //   shrinkWrap: true,
                      //   crossAxisCount: 3,
                      //   children: <Widget>[
                      //     for (Category category in snapshot.data)
                      //       _buildCategoryIcon(context, category: category),
                      //   ],
                      // );
                    } else
                      return SpinKitWave(
                        color: colors["primaryColor"],
                        size: 30,
                      );
                  },
                ),
                // child: ListView.builder(
                //   itemBuilder: ,
                // )
                // child: ListView(
                //   shrinkWrap: true,
                //   padding: EdgeInsets.only(top: 40),
                //   children: <Widget>[
                //     Padding(
                //       padding: const EdgeInsets.only(
                //         left: 20.0,
                //         right: 20.0,
                //       ),
                //       child: ProviderResultsCard(),
                //     ),
                //     Padding(
                //       padding: const EdgeInsets.only(
                //         left: 20.0,
                //         right: 20.0,
                //       ),
                //       child: ProviderResultsCard(),
                //     ),
                //     Padding(
                //       padding: const EdgeInsets.only(
                //         left: 20.0,
                //         right: 20.0,
                //       ),
                //       child: ProviderResultsCard(),
                //     ),
                //     Padding(
                //       padding: const EdgeInsets.only(
                //         left: 20.0,
                //         right: 20.0,
                //       ),
                //       child: ProviderResultsCard(),
                //     ),
                //   ],
                // ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
