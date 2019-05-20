import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mobile/api/categories_api.dart';
import 'package:mobile/blocs/categories_bloc.dart';
import 'package:mobile/models/Category.dart';
import 'package:mobile/pages/home/client_home_page.dart';
import 'package:mobile/utils/constants.dart';
import 'package:provider/provider.dart';

class _SearchModel with ChangeNotifier {
  final List<Category> allCategories;
  List<Category> _filteredCategories;
  String _searchString;

  _SearchModel(this.allCategories) {
    this._filteredCategories = allCategories;
  }

  getFilteredCategories() => _filteredCategories;
  setFilteredCategories(List<Category> filteredCategories) =>
      this._filteredCategories = filteredCategories;

  getSearchString() => _searchString;
  setSearchString(String searchString) => this._searchString = searchString;

  void filter(String searchString) {
    // debugPrint("filter" + searchString);
    this._filteredCategories = this.allCategories;
    this._filteredCategories = this._filteredCategories.where((category) {
      return searchString.length == 0 ||
          category.name.toLowerCase().contains(searchString.toLowerCase());
    }).toList();
    notifyListeners();
  }
}

class ClientHomeAllCategories extends StatefulWidget {
  @override
  _ClientHomeAllCategoriesState createState() =>
      _ClientHomeAllCategoriesState();
}

class _ClientHomeAllCategoriesState extends State<ClientHomeAllCategories> {
  @override
  Widget build(BuildContext context) {
    final CategoriesBloc categoriesBloc =
        BlocProvider.of<CategoriesBloc>(context);

    return BlocBuilder(
        bloc: categoriesBloc,
        builder: (BuildContext context, CategoriesState state) {
          if (state is CategoriesUninitialized || state is CategoriesLoading) {
            return Container();
          } else if (state is CategoriesLoaded) {
            return ChangeNotifierProvider<_SearchModel>(
              builder: (_) => _SearchModel(state.categories),
              child: Scaffold(
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
                  )),
            );
          }
        });
  }
}

class _ClientHomeAllCategoriesGrid extends StatelessWidget {
  const _ClientHomeAllCategoriesGrid({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CategoriesBloc categoriesBloc =
        BlocProvider.of<CategoriesBloc>(context);

    return BlocBuilder(
      bloc: categoriesBloc,
      builder: (BuildContext context, CategoriesState state) {
        if (state is CategoriesUninitialized || state is CategoriesLoading) {
          return SpinKitWave(
            color: colors["primaryColor"],
            size: 20,
          );
        } else if (state is CategoriesLoaded) {
          return Consumer<_SearchModel>(builder: (context, value, child) {
            debugPrint("hi");
            return GridView.count(
              shrinkWrap: true,
              crossAxisCount: 3,
              children: <Widget>[
                for (Category category in value.getFilteredCategories())
                  CategoryIcon(name: category.name, id: category.id),
              ],
            );
          });
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
    // final CategoriesBloc categoriesBloc =
    //     BlocProvider.of<CategoriesBloc>(context);

    final _SearchModel searchModel = Provider.of<_SearchModel>(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: 40.0),
      child: TextField(
        onChanged: (text) {
          searchModel.filter(text);
        },
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
