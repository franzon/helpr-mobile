import 'package:flutter/material.dart';
import 'package:mobile/pages/home/client_home_page.dart';
import 'package:mobile/utils/constants.dart';

class ClientHomeAllCategories extends StatefulWidget {
  @override
  _ClientHomeAllCategoriesState createState() =>
      _ClientHomeAllCategoriesState();
}

class _ClientHomeAllCategoriesState extends State<ClientHomeAllCategories> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: colors["backgroundColor2"],
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 40.0),
                child: Text(
                  "Todas as categorias",
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 40.0),
                child: TextField(
                  style:
                      TextStyle(color: Colors.white, fontFamily: "Montserrat"),
                  decoration: InputDecoration(
                      hintText: "Procurar",
                      hintStyle: TextStyle(
                          color: Colors.white, fontFamily: "Montserrat"),
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
              ),
              GridView.count(
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
            ],
          ),
        ));
  }
}
