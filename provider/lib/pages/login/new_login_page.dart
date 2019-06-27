import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:mobile/utils/constants.dart';
import 'package:mobile/api/login_api.dart';
import 'package:mobile/utils/constants.dart' as prefix0;
import 'package:page_transition/page_transition.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final PageController controller = PageController(initialPage: 0);

  Color cor = Colors.transparent;

  bool _borderVisible = false;

  RegExp emailRegex;

  String _email, _password;

  FocusNode _emailFocus;
  FocusNode _passFocus;

  bool _obscuredPass = true;

  TextEditingController emailController;
  TextEditingController passController;

  bool _allowScrollPass = true;

  var _formKey;

  void formSubmit() async {
    if (_formKey.currentState.validate()) {
      print("validos");
      final user = await UserApi.getUser(emailController.text);
      if (user != null) {
        // Navigator.pushNamed(context, "/login/password");
        // Navigator.push(
        //     context,
        //     PageTransition(
        //         type: PageTransitionType.rightToLeft,
        //         child: LoginPasswordPage(
        //           email: email,
        //           name: user["name"],
        //         )));
      } else {
        // Navigator.push(
        //   context,
        //   PageTransition(
        //     type: PageTransitionType.rightToLeft,
        //     child: NamePage(),
        //   ),
        // );
      }
    }
  }

  @override
  void initState() {
    super.initState();

    _formKey = GlobalKey<FormState>();

    emailController = TextEditingController(text: "");
    passController = TextEditingController(text: "");

    _emailFocus = FocusNode();
    _passFocus = FocusNode();

    _passFocus.addListener(() {
      setState(() {
        _allowScrollPass = !_passFocus.hasFocus;
      });
    });
    _emailFocus.addListener(() {
      setState(() {
        _allowScrollPass = !_emailFocus.hasFocus;
      });
    });

    emailRegex = RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{2,61}[a-zA-Z0-9])?)+$");
  }

  @override
  void dispose() {
    super.dispose();

    emailController.dispose();
    passController.dispose();

    _emailFocus.dispose();
    _passFocus.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: colors["backgroundColor"],
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: colors["accentColor"],
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: SafeArea(
        child: Center(
          child: PageView(
            onPageChanged: (index) {
              setState(() {
                emailController.text = "";
                passController.text = "";
                _borderVisible = !_borderVisible;
              });
            },
            controller: controller,
            scrollDirection: Axis.vertical,
            children: <Widget>[
              loginPage(),
              registerPage(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildForm() {
    return Container(
      padding: EdgeInsets.all(30),
      child: Center(
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Expanded(
                child: TextFormField(
                  style: TextStyle(color: Colors.white),
                  controller: emailController,
                  onSaved: (input) => _email = input,
                  validator: (input) =>
                      emailRegex.hasMatch(input) ? null : "Email inválido",
                  focusNode: _emailFocus,
                  onFieldSubmitted: (input) {
                    _formKey.currentState.validate();
                    _fieldFocusChange(context, _emailFocus, _passFocus);
                  },
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hasFloatingPlaceholder: false,
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(12),
                        gapPadding: 1),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.redAccent),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                    fillColor: colors["backgroungColor"],
                    prefixIcon: Icon(
                      Icons.email,
                      color: Colors.white,
                    ),
                    labelText: "Email",
                    hintText: "exemplo@email.com",
                    hintStyle: TextStyle(
                      fontFamily: fontFamily,
                      color: Colors.grey,
                    ),
                    labelStyle: TextStyle(
                      fontSize: 15,
                      color: colors["accentColor"],
                      fontFamily: fontFamily,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: TextFormField(
                  style: TextStyle(color: Colors.white),
                  obscureText: _obscuredPass,
                  onEditingComplete: () =>
                      _formKey != null ? _formKey.currentState.validate : null,
                  controller: passController,
                  onSaved: (input) => _password = input,
                  validator: (input) =>
                      input.length > 6 ? null : "Senha inválida",
                  focusNode: _passFocus,
                  onFieldSubmitted: (input) {
                    formSubmit();
                    _passFocus.unfocus();
                  },
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hasFloatingPlaceholder: false,
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(12),
                        gapPadding: 1),
                    // enabledBorder: OutlineInputBorder(
                    //   borderSide: BorderSide(color: Colors.white),
                    //   borderRadius: BorderRadius.circular(12),
                    // ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    // errorBorder: OutlineInputBorder(
                    //   borderSide: BorderSide(color: Colors.redAccent),
                    //   borderRadius: BorderRadius.circular(12),
                    // ),
                    filled: true,
                    fillColor: colors["backgroungColor"],
                    prefixIcon: Icon(
                      Icons.vpn_key,
                      color: Colors.white,
                    ),
                    suffixIcon: Container(
                      width: MediaQuery.of(context).size.width / 8,
                      child: FlatButton(
                        child: Icon(
                          Icons.remove_red_eye,
                          color: _obscuredPass ? Colors.grey : Colors.white,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscuredPass = !_obscuredPass;
                          });
                        },
                      ),
                    ),
                    hintText: "Senha",
                    hintStyle: TextStyle(
                      fontFamily: fontFamily,
                      color: Colors.grey,
                    ),
                    labelStyle: TextStyle(
                      fontSize: 15,
                      color: Colors.grey,
                      fontFamily: fontFamily,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width / 3,
                      decoration: BoxDecoration(
                          color: colors["accentColor"],
                          borderRadius: BorderRadius.circular(10)),
                      child: FlatButton(
                        onPressed: formSubmit,
                        child: Text(
                          "Entrar",
                          style: TextStyle(
                              fontFamily: fontFamily,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget loginPage() {
    setState(() {
      cor = colors["backgroundColor"];
    });
    return Container(
      decoration: BoxDecoration(color: colors["backgroundColor"]),
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 15,
            child: Column(
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 30),
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
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Helpr!",
                          style: TextStyle(
                            color: colors["primaryColor"],
                            fontSize: 30,
                            fontFamily: fontFamily,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 6,
                  child: Center(
                    child: Container(
                      margin: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width / 20,
                        right: MediaQuery.of(context).size.width / 20,
                        bottom: MediaQuery.of(context).size.height / 4,
                      ),
                      child: Card(
                        // borderOnForeground: false,
                        // semanticContainer: true,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25)),
                        color: colors["backgroundColor"],

                        elevation: 10,
                        child: buildForm(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: AnimatedOpacity(
              opacity: _borderVisible ? 0 : 1,
              duration: Duration(seconds: 1),
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: FlareActor(
                      "assets/flare/arrow.flr",
                      color: Colors.white54,
                      animation: "arrow_up",
                    ),
                  ),
                  Text(
                    "Caso não possua uma conta, arraste para se cadastrar.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white54,
                      fontFamily: fontFamily,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          AnimatedOpacity(
            opacity: _borderVisible ? 0 : 1,
            duration: Duration(seconds: 1),
            child: Container(
              height: 10,
              decoration: BoxDecoration(
                boxShadow: [
                  new BoxShadow(
                    color: Colors.black,
                    blurRadius: 20.0,
                  ),
                ],
                color: colors["accentColor"],
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(30)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget registerPage() {
    return Container(
      decoration: BoxDecoration(
        color: colors["accentColor"],
      ),
      child: Column(
        children: <Widget>[
          AnimatedOpacity(
            opacity: _borderVisible ? 1 : 0,
            duration: Duration(seconds: 1),
            child: Container(
              height: 10,
              decoration: BoxDecoration(
                color: cor,
                boxShadow: [
                  new BoxShadow(
                    color: Colors.black,
                    blurRadius: 30.0,
                  ),
                ],
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50),
                    bottomRight: Radius.circular(30)),
              ),
            ),
          ),
          Expanded(
            child: AnimatedOpacity(
              opacity: _borderVisible ? 1 : 0,
              duration: Duration(seconds: 1),
              child: Column(
                children: <Widget>[
                  Text(
                    "Arraste para voltar.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black54,
                      fontFamily: fontFamily,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Expanded(
                    child: FlareActor(
                      "assets/flare/arrow.flr",
                      color: Colors.black54,
                      animation: "arrow_down",
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 15,
            child: Center(
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Cadastre-se, é",
                          style: TextStyle(
                              color: colors["backgroudColor"],
                              fontFamily: fontFamily,
                              fontWeight: FontWeight.w700,
                              fontSize: 40),
                        ),
                        Text(
                          " grátis",
                          style: TextStyle(
                            color: colors["primaryColor"],
                            fontFamily: fontFamily,
                            fontWeight: FontWeight.w700,
                            fontSize: 40,
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width / 25),
                      width: double.infinity,
                      child: Card(
                        semanticContainer: false,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25)),
                        color: colors["accentColor"],
                        elevation: 10,
                        child: Center(
                          child: Column(
                            children: <Widget>[
                              
                              Expanded(
                                child: TextField(
                                  style: TextStyle(color: Colors.white),
                                  obscureText: _obscuredPass,
                                  onEditingComplete: () => _formKey != null
                                      ? _formKey.currentState.validate
                                      : null,
                                  controller: passController,
                                  focusNode: _passFocus,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    hasFloatingPlaceholder: false,
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.circular(12),
                                        gapPadding: 1),
                                    // enabledBorder: OutlineInputBorder(
                                    //   borderSide: BorderSide(color: Colors.white),
                                    //   borderRadius: BorderRadius.circular(12),
                                    // ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    // errorBorder: OutlineInputBorder(
                                    //   borderSide: BorderSide(color: Colors.redAccent),
                                    //   borderRadius: BorderRadius.circular(12),
                                    // ),
                                    filled: true,
                                    fillColor: colors["backgroungColor"],
                                    prefixIcon: Icon(
                                      Icons.vpn_key,
                                      color: Colors.white,
                                    ),
                                    suffixIcon: Container(
                                      width:
                                          MediaQuery.of(context).size.width / 8,
                                      child: FlatButton(
                                        child: Icon(
                                          Icons.remove_red_eye,
                                          color: _obscuredPass
                                              ? Colors.grey
                                              : Colors.white,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            _obscuredPass = !_obscuredPass;
                                          });
                                        },
                                      ),
                                    ),
                                    hintText: "Senha",
                                    hintStyle: TextStyle(
                                      fontFamily: fontFamily,
                                      color: Colors.grey,
                                    ),
                                    labelStyle: TextStyle(
                                      fontSize: 15,
                                      color: Colors.grey,
                                      fontFamily: fontFamily,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: TextField(),
                              ),
                              Expanded(
                                child: TextField(),
                              ),
                              Expanded(
                                child: TextField(),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Spacer(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

_fieldFocusChange(
    BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
  currentFocus.unfocus();
  FocusScope.of(context).requestFocus(nextFocus);
}
