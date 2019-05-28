import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:mobile/utils/constants.dart';
import 'package:mobile/utils/constants.dart' as prefix0;

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final PageController controller = PageController(initialPage: 0);

  final _formKey = GlobalKey<FormState>();

  void formSubmit() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      body: SafeArea(
        child: Center(
          child: PageView(
            controller: controller,
            scrollDirection: Axis.vertical,
            children: <Widget>[
              loginPage(context, _formKey, formSubmit),
              registerPage(),
            ],
          ),
        ),
      ),
    );
  }
}

Widget loginPage(BuildContext context, GlobalKey key, Function callback) {
  return Container(
    decoration: BoxDecoration(color: colors["backgroundColor"]),
    child: Column(
      children: <Widget>[
        Expanded(
          flex: 2,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Text(
                "Seja bem vindo ao ",
                style: TextStyle(
                    color: Colors.white54,
                    fontSize: 30,
                    fontFamily: fontFamily,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                "Helpr!",
                style: TextStyle(
                    color: colors["primaryColor"],
                    fontSize: 30,
                    fontFamily: fontFamily,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 10,
          child: Center(
            child: Card(
              borderOnForeground: false,
              color: colors["backgroundColor"],
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 50),
              elevation: 50,
              child: buildForm(context, key, callback),
            ),
          ),
        ),
        Expanded(
          child: FlareActor(
            "assets/flare/arrow_up.flr",
            color: Colors.white54,
            animation: "arrow_up",
          ),
        ),
        Expanded(
          child: Text(
            "Caso não possua uma conta, arraste para se cadastrar.",
            style: TextStyle(
                color: Colors.white54,
                fontFamily: fontFamily,
                fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          height: 15,
          decoration: BoxDecoration(
            boxShadow: [
              new BoxShadow(
                color: Colors.black,
                blurRadius: 20.0,
              ),
            ],
            color: colors["accentColor"],
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30)),
          ),
        ),
      ],
    ),
  );
}

Widget registerPage({email: "", password: ""}) {
  return Container(
    decoration: BoxDecoration(
      color: colors["accentColor"],
    ),
    child: Center(
      child: Column(
        children: <Widget>[
          Expanded(
            child: Text("data"),
          )
        ],
      ),
    ),
  );
}

Widget buildForm(BuildContext context, GlobalKey key, Function callback) {
  final regex = RegExp(
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$");

  String _email;
  String _password;

  FocusNode _emailFocus = FocusNode();
  FocusNode _passFocus = FocusNode();

  final TextEditingController emailController = TextEditingController(text: "");
  return Container(
    padding: EdgeInsets.all(30),
    child: Center(
      child: Form(
          key: key,
          child: Column(
            children: <Widget>[
              Expanded(
                child: TextFormField(
                  onSaved: (input) => _email = input,
                  validator: (input) =>
                      regex.hasMatch(_email) ? null : "Email inválido",
                  textInputAction: TextInputAction.continueAction,
                  focusNode: _emailFocus,
                  onFieldSubmitted: (input) {
                    _fieldFocusChange(context, _emailFocus, _passFocus);
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      errorText: !regex.hasMatch(emailController.text)
                          ? null
                          : "Email inválido",
                      hasFloatingPlaceholder: false,
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(12),
                          gapPadding: 1),
                      errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.redAccent)),
                      filled: true,
                      fillColor: colors["accentColor"],
                      prefixIcon: Icon(Icons.email),
                      labelText: "Email",
                      hintText: "exemplo@email.com",
                      hintStyle: TextStyle(
                        fontFamily: fontFamily,
                      ),
                      labelStyle: TextStyle(
                        fontSize: 15,
                        color: colors["backgroundColor"],
                        fontFamily: fontFamily,
                      )),
                ),
              ),
              Expanded(
                child: TextFormField(
                  obscureText: true,
                  onSaved: (input) => _password = input,
                  validator: (input) =>
                      _password.length > 6 ? null : "Senha inválida",
                  textInputAction: TextInputAction.send,
                  focusNode: _passFocus,
                  onFieldSubmitted: (input) {},
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      hasFloatingPlaceholder: false,
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(12),
                          gapPadding: 1),
                      errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.redAccent)),
                      filled: true,
                      fillColor: colors["accentColor"],
                      prefixIcon: Icon(Icons.lock),
                      labelText: "Senha",
                      hintText: "Senha",
                      hintStyle: TextStyle(
                        fontFamily: fontFamily,
                      ),
                      labelStyle: TextStyle(
                        fontSize: 15,
                        color: colors["backgroundColor"],
                        fontFamily: fontFamily,
                      )),
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RaisedButton(
                        onPressed: callback,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        elevation: 10,
                        child: Text(
                          "Entrar",
                          style: TextStyle(
                            fontFamily: fontFamily,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          )),
    ),
  );
}

_fieldFocusChange(
    BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
  currentFocus.unfocus();
  FocusScope.of(context).requestFocus(nextFocus);
}
