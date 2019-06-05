import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mobile/models/Category.dart';
import 'package:mobile/pages/home/provider_results/provider_results_card.dart';
import 'package:mobile/utils/constants.dart';
import 'package:rxdart/subjects.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:flutter_fluid_slider/flutter_fluid_slider.dart';

class ProviderResultsPage extends StatefulWidget {
  final Category category;

  ProviderResultsPage({@required this.category});

  @override
  _ProviderResultsPageState createState() => _ProviderResultsPageState();
}

class _ProviderResultsPageState extends State<ProviderResultsPage>
    with TickerProviderStateMixin {
  bool showFilter = false;
  bool showOffline = false;
  double maxDistance = 5.0;

  AnimationController animationController;
  Animation<double> animation;
  double _height = 0.0;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    )..addListener(() => setState(() {}));
    animation = Tween(begin: 0.0, end: 0.25).animate(animationController);
  }

  @override
  void dispose() {
    animationController.dispose();
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
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.arrow_back),
                        Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Text("Voltar", style: TextStyle(fontSize: 18)),
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
                        value: showOffline,
                        onChanged: (bool value) {
                          setState(() {
                            showOffline = !showOffline;
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
                          value: maxDistance,
                          labelsTextStyle: TextStyle(fontSize: 14),
                          valueTextStyle: TextStyle(
                              fontSize: 12,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                          onChanged: (double value) {
                            setState(() {
                              maxDistance = value;
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
                child: ListView(
                  shrinkWrap: true,
                  padding: EdgeInsets.only(top: 40),
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 20.0,
                        right: 20.0,
                      ),
                      child: ProviderResultsCard(),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 20.0,
                        right: 20.0,
                      ),
                      child: ProviderResultsCard(),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 20.0,
                        right: 20.0,
                      ),
                      child: ProviderResultsCard(),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 20.0,
                        right: 20.0,
                      ),
                      child: ProviderResultsCard(),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
    // return SafeArea(
    //   child: Scaffold(
    //       backgroundColor: colors["backgroundColor"],
    //       body: Column(
    //         mainAxisSize: MainAxisSize.max,
    //         children: <Widget>[
    //           Container(
    //             height: 60,
    //             child: _buildHeader(context),
    //           ),
    //           // Container(
    //           //   child: AnimatedBuilder(
    //           //     animation: _animation,
    //           //     builder: (BuildContext context, _) => Container(
    //           //           height: _controller.value,
    //           //           child: _buildSubHeader(),
    //           //         ),
    //           //   ),
    //           // ),
    //           Flexible(
    //             child: Container(
    //               height: _height.value,
    //               child: _buildSubHeader(),
    //             ),
    //           ),
    //           Expanded(child: Container(child: _buildBody())),
    //         ],
    //       )),
    // );
  }

  // Container _buildBody() {
  //   return Container(
  //     child: ListView(
  //       padding: EdgeInsets.only(top: 40),
  //       children: <Widget>[
  //         Padding(
  //           padding: const EdgeInsets.only(
  //             left: 20.0,
  //             right: 20.0,
  //           ),
  //           child: _buildProviderCard(),
  //         ),
  //         Padding(
  //           padding: const EdgeInsets.only(
  //             left: 20.0,
  //             right: 20.0,
  //           ),
  //           child: _buildProviderCard(),
  //         ),
  //         Padding(
  //           padding: const EdgeInsets.only(
  //             left: 20.0,
  //             right: 20.0,
  //           ),
  //           child: _buildProviderCard(),
  //         ),
  //         Padding(
  //           padding: const EdgeInsets.only(
  //             left: 20.0,
  //             right: 20.0,
  //           ),
  //           child: _buildProviderCard(),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // Container _buildSubHeader() {
  //   return Container(
  //     decoration: BoxDecoration(
  //       borderRadius: BorderRadius.only(bottomRight: Radius.circular(100)),
  //       color: colors["backgroundColor2"],
  //     ),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: <Widget>[
  //         Column(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: <Widget>[
  //             Text(
  //               "Mostrando resultados para: ",
  //               style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
  //             ),
  //             Row(
  //               children: <Widget>[
  //                 Text(
  //                   widget.category.title,
  //                   style: TextStyle(
  //                       fontWeight: FontWeight.bold,
  //                       fontSize: 16,
  //                       color: colors["primaryColor"]),
  //                 ),
  //                 Text(
  //                   ", até 15 km",
  //                   style: TextStyle(
  //                     fontWeight: FontWeight.bold,
  //                     fontSize: 16,
  //                   ),
  //                 )
  //               ],
  //             ),
  //           ],
  //         )
  //       ],
  //     ),
  //   );
  // }

  // Widget _buildHeader(BuildContext context) {
  //   return Container(
  //     color: colors["primaryColor"],
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //       children: <Widget>[
  //         GestureDetector(
  //           onTap: () {
  //             Navigator.of(context).pop();
  //           },
  //           child: Row(
  //             children: <Widget>[
  //               Padding(
  //                 padding: const EdgeInsets.only(left: 20.0),
  //                 child: Icon(
  //                   Icons.arrow_back,
  //                   size: 32,
  //                 ),
  //               ),
  //               Padding(
  //                 padding: const EdgeInsets.only(left: 10.0),
  //                 child: Text(
  //                   "Voltar",
  //                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
  //                 ),
  //               )
  //             ],
  //           ),
  //         ),
  //         Expanded(child: Container()),
  //         GestureDetector(
  //           onTap: () {
  //             setState(() {
  //               debugPrint("Maaa");
  //               showFilter = !showFilter;

  //               if (showFilter)
  //                 _height = 120.0;
  //               else
  //                 _height = 0.0;
  //             });

  //             // _controller.forward();
  //           },
  //           child: Container(),
  //           // child: Padding(
  //           //   padding: const EdgeInsets.only(right: 20.0),
  //           //   child: RotationTransition(
  //           //       turns: _iconTurns, child: Icon(Icons.filter_list)),
  //           // ),
  //         )
  //       ],
  //     ),
  //   );
  // }

  // Container _buildProviderCard() {
  //   return Container(
  //     margin: EdgeInsets.only(bottom: 40),
  //     decoration: BoxDecoration(
  //       color: colors["backgroundColor2"],
  //       borderRadius: BorderRadius.only(
  //           bottomLeft: Radius.circular(5),
  //           topRight: Radius.circular(5),
  //           bottomRight: Radius.circular(10)),
  //       boxShadow: [
  //         new BoxShadow(
  //           color: Colors.black,
  //           offset: new Offset(0.0, 0.5),
  //           blurRadius: 0.5,
  //         )
  //       ],
  //     ),
  //     child: Stack(
  //       children: <Widget>[
  //         Padding(
  //           padding: const EdgeInsets.only(left: 50, right: 20, bottom: 20),
  //           child: Container(
  //             child: Column(
  //               mainAxisAlignment: MainAxisAlignment.spaceAround,
  //               children: <Widget>[
  //                 Row(
  //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                   children: <Widget>[
  //                     Text(
  //                       "Fulano de tal",
  //                       style: TextStyle(
  //                           color: colors["primaryColor"],
  //                           fontWeight: FontWeight.bold),
  //                     ),
  //                     Row(
  //                       children: <Widget>[
  //                         Padding(
  //                           padding: const EdgeInsets.only(right: 8.0),
  //                           child: Image.asset(
  //                             "assets/icons/reputation.png",
  //                             scale: 3,
  //                           ),
  //                         ),
  //                         Padding(
  //                           padding: const EdgeInsets.only(left: 4.0),
  //                           child: Text(
  //                             "3000",
  //                             style: TextStyle(
  //                                 color: Colors.yellow,
  //                                 fontWeight: FontWeight.bold),
  //                           ),
  //                         )
  //                       ],
  //                     )
  //                   ],
  //                 ),
  //                 Row(
  //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                   children: <Widget>[
  //                     Column(
  //                       children: <Widget>[
  //                         Text("Ciclano, há 3 dias"),
  //                         Text("Mucho bom...",
  //                             style: TextStyle(
  //                               fontSize: 12,
  //                               color: Colors.grey,
  //                             ))
  //                       ],
  //                     ),
  //                     Column(
  //                       crossAxisAlignment: CrossAxisAlignment.end,
  //                       children: <Widget>[
  //                         Text(
  //                           "75",
  //                           style: TextStyle(fontWeight: FontWeight.bold),
  //                         ),
  //                         Text("atendimentos")
  //                       ],
  //                     )
  //                   ],
  //                 )
  //               ],
  //             ),
  //             height: 100,
  //           ),
  //         ),
  //         Container(
  //           transform: Matrix4.translationValues(-10.0, -10.0, 0.0),
  //           decoration: new BoxDecoration(
  //               image: DecorationImage(
  //                   image: NetworkImage(
  //                       "https://randomuser.me/api/portraits/men/37.jpg")),
  //               shape: BoxShape.circle,
  //               border: Border.all(width: 1, color: Colors.yellow)),
  //           width: 50,
  //           height: 50,
  //         )
  //       ],
  //     ),
  //   );
  // }
}
