import "package:flutter/material.dart";
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:mobile/utils/constants.dart';
import 'package:mobile/widgets/helpr_button.dart';

class ActivitiesPage extends StatefulWidget {
  ActivitiesPage({Key key}) : super(key: key);

  _ActivitiesPageState createState() => _ActivitiesPageState();
}

class _ActivitiesPageState extends State<ActivitiesPage> {
  final List<Map> categories = <Map>[
    {"_id": "asdasdasdasdaArq354", "title": "Pedreiro"},
    {"_id": "asdasdasdasdaAasdasd", "title": "Enfermeira"},
  ];

  final List<Map> entries = <Map>[
    {
      "title": "Pedreiasdasdasdasdasdasdro",
      "description": "asdasdasdasdqqweqw",
      "price": "1400,91"
    },
  ];
  final List<int> colorCodes = <int>[600, 500, 100];

  TextEditingController titleController = TextEditingController(text: "");
  TextEditingController descController = TextEditingController(text: "");
  MoneyMaskedTextController priceController =
      MoneyMaskedTextController(decimalSeparator: '.', thousandSeparator: ',');
  String category;

  FocusNode titleFocus = FocusNode();
  FocusNode descFocus = FocusNode();
  FocusNode priceFocus = FocusNode();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    titleController.dispose();
    descController.dispose();
    priceController.dispose();
    super.dispose();
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
                      child: ListView.separated(
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
                                print("chupa meu pito");
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
                                  index != (entries.length - 1)
                                      ? Container(
                                          color: Colors.black,
                                          child: Icon(Icons.add),
                                        )
                                      : Container()
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
                            isDisabled: false,
                            isLoading: false,
                            callback: () {},
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

  Future buildShowDialog(BuildContext context) {
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
            height: 500.0,
            width: 400.0,
            padding: EdgeInsets.symmetric(vertical: 40, horizontal: 10),
            child: Column(
              children: <Widget>[
                Expanded(
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        flex: 2,
                        child: Container(
                          height: 60,
                          decoration: BoxDecoration(
                            color: colors["accentColor"],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: DropdownButton<Map>(
                            isDense: true,
                            items: this.categories.map((Map item) {
                              return DropdownMenuItem<Map>(
                                value: item,
                                child: Text(item["title"]),
                              );
                            }).toList(),
                            onChanged: (Map item) {
                              setState(() {
                                category = item["title"];
                              });
                            },
                            hint: Text("Informe a categoria"),
                          ),
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          controller: priceController,
                          focusNode: priceFocus,
                          keyboardType: TextInputType.text,
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
