import 'package:flutter/material.dart';
import 'package:mobile/utils/constants.dart';

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
                              left: 30.0, right: 30.0, bottom: 30.0, top: 70.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                flex: 2,
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: colors["backgroundColor2"],
                                      borderRadius: BorderRadius.circular(5)),
                                  child: GridView.count(
                                    crossAxisCount: 2,
                                    children: <Widget>[
                                      Center(child: Text("A")),
                                      Center(child: Text("B")),
                                      Center(child: Text("C")),
                                      Center(child: Text("D"))
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 20.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: colors["backgroundColor2"],
                                        borderRadius: BorderRadius.circular(5)),
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
