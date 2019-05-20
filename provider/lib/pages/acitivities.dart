import "package:flutter/material.dart";
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:mobile/utils/constants.dart';
import 'package:mobile/widgets/helpr_button.dart';
import 'dart:convert';
import 'dart:io';
import 'package:mobile/api/category.dart';
import 'package:mobile/api/activities.dart';
import 'package:mobile/utils/files.dart';
import 'package:path_provider/path_provider.dart';

class ActivitiesPage extends StatefulWidget {
  ActivitiesPage({Key key}) : super(key: key);

  _ActivitiesPageState createState() => _ActivitiesPageState();
}

class _ActivitiesPageState extends State<ActivitiesPage> {
  final List<Map> categories = <Map>[
    {"_id": "asdasdasdasdaArq354", "title": "Pedreiro"},
    {"_id": "asdasdasdasdaAasdasd", "title": "Enfermeira"},
  ];

  final List<Map> entries = <Map>[];


  JSONStorage storage;

  bool isLoading = false;

  @override
  void initState() {

    CategoryApi.getCategory().then((categories) {
      setState(() {
        categories = categories;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void submitActivities () async {
    setState(() {
      isLoading = true;
    });
    Directory dir = await getApplicationDocumentsDirectory();
    storage = JSONStorage(localFiles["jsonProviderName"], dir.path);
    storage.appendMap({"email": "otavio@ogoes.dev"});
    String email = storage.getContent()["email"];

    await ActivityApi.sendActivities(email, entries);

    setState(() {
      isLoading = false;
    });

    Navigator.pop(context, null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: colors["backgroundColor"],
        ),
        child: SafeArea(
          child: Center(
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Container(
                    child: Center(
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(top: 18.0),
                            child: Text(
                              "Atividades",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 30),
                            ),
                          ),
                          Text(
                            "As mudanças serão persistidas somente após a confirmação",
                            style: TextStyle(color: Colors.white54),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 8,
                  child: Card(
                    elevation: 8.0,
                    margin:
                        EdgeInsets.symmetric(horizontal: 35.0, vertical: 20.0),
                    color: Colors.white70,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Container(
                      child: Center(
                        child: entries.length == 0? Text("Sem atividades"): ListView.separated(
                          padding: EdgeInsets.all(10.0),
                          itemCount: entries.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              height: 80,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: RaisedButton(
                                color: colors["accentColor"],
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                onPressed: () {
                                  print("view activity");
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Expanded(
                                      child: Container(
                                        height: 50,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          color: Colors.grey[200],
                                        ),
                                        child: Icon(
                                          Icons.build,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 5,
                                      child: Container(
                                        height: 50,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          color: Colors.grey[200],
                                        ),
                                        margin: EdgeInsets.only(left: 14),
                                        child: Container(
                                          child: Row(
                                            children: <Widget>[
                                              Expanded(
                                                flex: 3,
                                                child: Padding(
                                                  padding: const EdgeInsets.only(
                                                      left: 16.0),
                                                  child: Text(
                                                    "${entries[index]["title"]}",
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight: FontWeight.w500,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Text(
                                                    "R\$${entries[index]["price"]} ",
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight: FontWeight.w900,
                                                    )),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) =>
                              Divider(
                                height: 7,
                              ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(right: 40, left: 40, bottom: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Expanded(
                          flex: 2,
                          child: Container(
                            height: 70,
                            child: RaisedButton(
                              onPressed: () {
                                buildShowDialog(context);
                              },
                              color: colors["primaryColor"],
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40),
                              ),
                              child: Icon(
                                Icons.add,
                                color: colors["accentColor"],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 4),
                        ),
                        Expanded(
                          flex: 11,
                          child: HelprButton(
                            text: "SALVAR ATIVIDADES",
                            isDisabled: entries.length == 0,
                            isLoading: isLoading,
                            callback: () {
                              submitActivities();
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _createActivity(
      String title, String description, String price, String category) {
    setState(() {
      entries.add({
        "title": title,
        "description": description,
        "price": price,
        "category": category,
      });
    });
  }

  Future buildShowDialog(BuildContext context) {
    TextEditingController titleController = TextEditingController(text: "");
    TextEditingController descController = TextEditingController(text: "");
    MoneyMaskedTextController priceController = MoneyMaskedTextController(
        decimalSeparator: '.', thousandSeparator: ',');
    String category;

    FocusNode titleFocus = FocusNode();
    FocusNode descFocus = FocusNode();
    FocusNode priceFocus = FocusNode();

    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: colors["backgroundColor"],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Container(
            height: 400.0,
            width: 400.0,
            padding: EdgeInsets.symmetric(vertical: 40, horizontal: 10),
            child: Column(
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: TextField(
                    controller: titleController,
                    focusNode: titleFocus,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    onSubmitted: (text) {
                      _fieldFocusChange(context, titleFocus, descFocus);
                    },
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.title),
                      helperText: "Informe o título da atividade",
                      helperStyle: TextStyle(color: colors['accentColor']),
                      filled: true,
                      fillColor: colors['accentColor'],
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      hintText: "Título",
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: TextField(
                    controller: descController,
                    focusNode: descFocus,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    onSubmitted: (text) {
                      _fieldFocusChange(context, descFocus, priceFocus);
                    },
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.description),
                      helperText: "Informe a descrição da atividade",
                      helperStyle: TextStyle(color: colors['accentColor']),
                      filled: true,
                      fillColor: colors['accentColor'],
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      hintText: "Descrição",
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        flex: 3,
                        child: Container(
                          padding: EdgeInsets.only(right: 5),
                          height: 58,
                          child: RaisedButton(
                            color: Color(0xFDFFFFFF),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            onPressed: () {
                              showDialog(
                                context: context,
                                child: SimpleDialog(
                                  children: categories != null?
                                    categories.map((cat) {
                                    return SimpleDialogOption(
                                      onPressed: () {
                                        category = cat["title"];
                                        Navigator.pop(context, cat);
                                      },
                                      child: Text(cat["title"]),
                                    );
                                  }).toList() : null,
                                ),
                              );
                            },
                            child:
                                Text(category == null ? "Categoria" : category),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: TextField(
                          controller: priceController,
                          focusNode: priceFocus,
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.done,
                          onSubmitted: (text) {
                            // _fieldFocusChange(context, priceFocus, priceFocus);
                            // submit
                          },
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.attach_money),
                            helperText: "Informe o preço da atividade",
                            helperStyle:
                                TextStyle(color: colors['accentColor']),
                            filled: true,
                            fillColor: colors['accentColor'],
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            hintText: "Preço da atividade",
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                    flex: 1,
                    child: Center(
                      child: RaisedButton(
                        color: colors["primaryColor"],
                        disabledColor: Colors.grey,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        onPressed: category != null &&
                                titleController.text.length > 0 &&
                                descController.text.length > 0 &&
                                priceController.text.length >= 3
                            ? () {
                                _createActivity(
                                    titleController.text,
                                    descController.text,
                                    priceController.text,
                                    category);
                                Navigator.pop(context, null);
                              }
                            : null,
                        child: Icon(Icons.add),
                      ),
                    ))
              ],
            ),
          ),
        );
      },
    );
  }
}

_fieldFocusChange(
    BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
  currentFocus.unfocus();
  FocusScope.of(context).requestFocus(nextFocus);
}
