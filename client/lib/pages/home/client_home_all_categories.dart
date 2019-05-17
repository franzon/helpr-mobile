import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mobile/api/categories_api.dart';
import 'package:mobile/models/Category.dart';
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
              _ClientHomeAllCategoriesHeader(),
              _ClientHomeAllCategoriesSearch(),
              _ClientHomeAllCategoriesGrid(),
            ],
          ),
        ));
  }
}

class _ClientHomeAllCategoriesGrid extends StatelessWidget {
  const _ClientHomeAllCategoriesGrid({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: CategoriesApi.getAllCategories(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SpinKitWave(
            color: colors["primaryColor"],
            size: 20,
          );
        } else if (snapshot.connectionState == ConnectionState.done) {
          return GridView.count(
            shrinkWrap: true,
            crossAxisCount: 3,
            children: <Widget>[
              for (Category category in snapshot.data)
                CategoryIcon(name: category.name, id: category.id),
            ],
          );
        }
      },
    );
  }
}

class _ClientHomeAllCategoriesSearch extends StatelessWidget {
  const _ClientHomeAllCategoriesSearch({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 40.0),
      child: TextField(
        style: TextStyle(color: Colors.white, fontFamily: "Montserrat"),
        decoration: InputDecoration(
            hintText: "Procurar",
            hintStyle: TextStyle(color: Colors.white, fontFamily: "Montserrat"),
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
    );
  }
}

class _ClientHomeAllCategoriesHeader extends StatelessWidget {
  const _ClientHomeAllCategoriesHeader({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 40.0),
      child: Text(
        "Todas as categorias",
        style: TextStyle(
            color: Colors.white,
            fontFamily: "Montserrat",
            fontWeight: FontWeight.bold,
            fontSize: 20),
      ),
    );
  }
}
