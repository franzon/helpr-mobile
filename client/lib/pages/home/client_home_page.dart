import 'package:flutter/material.dart';
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
      body: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                  color: colors["backgroundColor2"],
                  child: Padding(
                    padding: const EdgeInsets.only(top: 30.0),
                    child: Row(
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
                  ),
                ),
              ),
              Expanded(
                  flex: 8,
                  child: Container(
                    color: colors["backgroundColor"],
                    child: Stack(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20.0, right: 20.0, bottom: 30.0, top: 70.0),
                          child: Column(
                            children: <Widget>[
                              Expanded(
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
                                              "Principais categorias",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontFamily: "Montserrat",
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 190,
                                            width: 250,
                                            child: GridView.count(
                                              shrinkWrap: true,
                                              crossAxisCount: 3,
                                              children: <Widget>[
                                                CategoryIcon(
                                                  text: "Pedreiro",
                                                  iconPath:
                                                      "assets/icons/worker.png",
                                                ),
                                                CategoryIcon(
                                                  text: "Pintor",
                                                  iconPath:
                                                      "assets/icons/painter.png",
                                                ),
                                                CategoryIcon(
                                                  text: "Encanador",
                                                  iconPath:
                                                      "assets/icons/gas-pipe.png",
                                                ),
                                                CategoryIcon(
                                                  text: "Informática",
                                                  iconPath:
                                                      "assets/icons/laptop.png",
                                                ),
                                                CategoryIcon(
                                                  text: "Informática",
                                                  iconPath:
                                                      "assets/icons/laptop.png",
                                                ),
                                                CategoryIcon(
                                                  text: "Informática",
                                                  iconPath:
                                                      "assets/icons/laptop.png",
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(15),
                                            child: Text(
                                              "Mais",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontFamily: "Montserrat",
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                // child: Container(
                                //   decoration: BoxDecoration(
                                //       color: colors["backgroundColor2"],
                                //       borderRadius: BorderRadius.circular(5)),
                                //   child: Container(
                                //     margin: EdgeInsets.all(30),
                                //     child: GridView.count(
                                //       mainAxisSpacing: 0,
                                //       crossAxisCount: 2,
                                //       children: <Widget>[
                                //         CategoryIcon(
                                //           text: "Pedreiro",
                                //           iconPath: "assets/icons/worker.png",
                                //         ),
                                //         CategoryIcon(
                                //           text: "Pintor",
                                //           iconPath: "assets/icons/painter.png",
                                //         ),
                                //         CategoryIcon(
                                //           text: "Encanador",
                                //           iconPath: "assets/icons/gas-pipe.png",
                                //         ),
                                //         CategoryIcon(
                                //           text: "Informática",
                                //           iconPath: "assets/icons/laptop.png",
                                //         ),
                                //         CategoryIcon(
                                //           text: "Encanador",
                                //           iconPath: "assets/icons/gas-pipe.png",
                                //         ),
                                //         CategoryIcon(
                                //           text: "Informática",
                                //           iconPath: "assets/icons/laptop.png",
                                //         ),
                                //       ],
                                //     ),
                                //   ),
                                // ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 20.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: <Widget>[
                                      Expanded(
                                        child: Container(
                                          margin: EdgeInsets.only(right: 5),
                                          child: Text("a"),
                                          decoration: BoxDecoration(
                                              color: colors["backgroundColor2"],
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          margin: EdgeInsets.only(right: 5),
                                          child: Text("b"),
                                          decoration: BoxDecoration(
                                              color: colors["backgroundColor2"],
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ))
            ],
          ),
          Container(
            margin: EdgeInsets.only(left: 50, right: 50, top: 100),
            height: 60,
            child: TextField(
              style: TextStyle(color: Colors.white, fontFamily: "Montserrat"),
              decoration: InputDecoration(
                  hintText: "Procurar",
                  hintStyle:
                      TextStyle(color: Colors.white, fontFamily: "Montserrat"),
                  filled: true,
                  fillColor: colors["backgroundColor"],
                  prefixIcon: Padding(
                    padding: const EdgeInsets.only(left: 25, right: 10),
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
          )
        ],
      ),
    );
  }
}
