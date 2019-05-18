import 'package:flutter/material.dart';
import 'package:mobile/api/auth_api.dart';
import 'package:mobile/utils/constants.dart';
import 'package:provider/provider.dart';

enum Tab { SignIn, SignUp }

class _AuthenticationScreenModel with ChangeNotifier {
  Tab _selectedTab = Tab.SignIn;

  final signInFormKey = GlobalKey<FormState>();
  final signInEmailController = TextEditingController();
  final signInPasswordController = TextEditingController();

  final signUpFormKey = GlobalKey<FormState>();
  final signUpNameController = TextEditingController();

  final signUpEmailController = TextEditingController();
  final signUpPasswordController = TextEditingController();

  Tab get selectedTab => this._selectedTab;

  void selectTab(Tab tab) {
    this._selectedTab = tab;
    notifyListeners();
  }
}

class AuthenticationTab extends StatelessWidget {
  final Tab tab;
  final String text;
  final bool selected;

  AuthenticationTab(
      {@required this.tab, @required this.text, @required this.selected});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Provider.of<_AuthenticationScreenModel>(context).selectTab(this.tab);
      },
      child: Container(
        decoration: BoxDecoration(
            color:
                this.selected ? colors["backgroundColor"] : Colors.transparent,
            borderRadius: BorderRadius.circular(5)),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(
            this.text,
            style: TextStyle(
                color: this.selected ? colors["primaryColor"] : Colors.white,
                fontWeight: FontWeight.bold,
                fontFamily: "Montserrat"),
          ),
        ),
      ),
    );
  }
}

class AuthenticationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<_AuthenticationScreenModel>(
        builder: (_) => _AuthenticationScreenModel(),
        child: _AuthenticationPage());
  }
}

class _AuthenticationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: colors["backgroundColor"],
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              flex: 3,
              child: AuthenticationHeader(),
            ),
            Expanded(
              flex: 1,
              child: AuthenticationTabs(),
            ),
            Expanded(
              flex: 1,
              child: Container(),
            ),
            Expanded(flex: 7, child: AuthenticationForm()),
          ],
        ));
  }
}

class AuthenticationHeader extends StatelessWidget {
  const AuthenticationHeader({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(
            "helpr",
            style: TextStyle(
                color: colors["primaryColor"],
                fontSize: 48,
                fontWeight: FontWeight.bold,
                fontFamily: "Montserrat"),
          ),
        ),
      ],
    );
  }
}

class AuthenticationForm extends StatelessWidget {
  const AuthenticationForm({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      decoration: BoxDecoration(
          color: colors["backgroundColor2"],
          borderRadius: BorderRadius.circular(5)),
      child: Provider.of<_AuthenticationScreenModel>(context).selectedTab ==
              Tab.SignIn
          ? AuthenticationSignInForm()
          : AuthenticationSignUpForm(),
    );
  }
}

class AuthenticationSignUpForm extends StatelessWidget {
  const AuthenticationSignUpForm({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final RegExp emailRegex = new RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

    return Stack(
      children: [
        Column(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Form(
                key: Provider.of<_AuthenticationScreenModel>(context)
                    .signInFormKey,
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 30.0, right: 30, bottom: 30.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      TextFormField(
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Digite um nome";
                          }
                        },
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.bold,
                            fontSize: 12),
                        decoration: InputDecoration(
                            hintText: "Nome",
                            hintStyle: TextStyle(
                                color: Colors.white,
                                fontFamily: "Montserrat",
                                fontWeight: FontWeight.bold,
                                fontSize: 12),
                            prefixIcon: Icon(
                              Icons.people,
                              color: colors["primaryColor"],
                            ),
                            border: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: colors["primaryColor"])),
                            enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: colors["primaryColor"])),
                            focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: colors["primaryColor"]))),
                      ),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value.isEmpty || !emailRegex.hasMatch(value)) {
                            return "Email inválido";
                          }
                        },
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.bold,
                            fontSize: 12),
                        decoration: InputDecoration(
                            hintText: "Email",
                            hintStyle: TextStyle(
                                color: Colors.white,
                                fontFamily: "Montserrat",
                                fontWeight: FontWeight.bold,
                                fontSize: 12),
                            prefixIcon: Icon(
                              Icons.email,
                              color: colors["primaryColor"],
                            ),
                            border: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: colors["primaryColor"])),
                            enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: colors["primaryColor"])),
                            focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: colors["primaryColor"]))),
                      ),
                      TextFormField(
                        obscureText: true,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Digite a senha";
                          }
                        },
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.bold,
                            fontSize: 12),
                        decoration: InputDecoration(
                            hintText: "Senha",
                            hintStyle: TextStyle(
                                color: Colors.white,
                                fontFamily: "Montserrat",
                                fontWeight: FontWeight.bold,
                                fontSize: 12),
                            prefixIcon: Icon(
                              Icons.lock,
                              color: colors["primaryColor"],
                            ),
                            border: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: colors["primaryColor"])),
                            enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: colors["primaryColor"])),
                            focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: colors["primaryColor"]))),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                color: colors["backgroundColor"],
              ),
            )
          ],
        ),
        Align(
          alignment: Alignment.center,
          child: Container(
              margin: EdgeInsets.only(left: 80, right: 80, top: 200),
              height: 60,
              decoration: BoxDecoration(
                  color: colors["primaryColor"],
                  borderRadius: BorderRadius.circular(5)),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    if (Provider.of<_AuthenticationScreenModel>(context)
                        .signInFormKey
                        .currentState
                        .validate()) {
                      debugPrint("signIn");
                    }
                  },
                  child: Center(
                      child: Text(
                    "Criar conta",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  )),
                ),
              )),
        )
      ],
    );
  }
}

class AuthenticationSignInForm extends StatelessWidget {
  const AuthenticationSignInForm({
    Key key,
  }) : super(key: key);

  void signIn(String email, String password) async {
    final Map response = await AuthApi.signIn(email, password);
    debugPrint(response.toString());
  }

  @override
  Widget build(BuildContext context) {
    final RegExp emailRegex = new RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

    return Stack(
      children: [
        Column(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Form(
                key: Provider.of<_AuthenticationScreenModel>(context)
                    .signInFormKey,
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      TextFormField(
                        controller:
                            Provider.of<_AuthenticationScreenModel>(context)
                                .signInEmailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value.isEmpty || !emailRegex.hasMatch(value)) {
                            return "Email inválido";
                          }
                        },
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.bold,
                            fontSize: 12),
                        decoration: InputDecoration(
                            hintText: "Email",
                            hintStyle: TextStyle(
                                color: Colors.white,
                                fontFamily: "Montserrat",
                                fontWeight: FontWeight.bold,
                                fontSize: 12),
                            prefixIcon: Icon(
                              Icons.email,
                              color: colors["primaryColor"],
                            ),
                            border: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: colors["primaryColor"])),
                            enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: colors["primaryColor"])),
                            focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: colors["primaryColor"]))),
                      ),
                      TextFormField(
                        controller:
                            Provider.of<_AuthenticationScreenModel>(context)
                                .signInPasswordController,
                        obscureText: true,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Digite a senha";
                          }
                        },
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.bold,
                            fontSize: 12),
                        decoration: InputDecoration(
                            hintText: "Senha",
                            hintStyle: TextStyle(
                                color: Colors.white,
                                fontFamily: "Montserrat",
                                fontWeight: FontWeight.bold,
                                fontSize: 12),
                            prefixIcon: Icon(
                              Icons.lock,
                              color: colors["primaryColor"],
                            ),
                            border: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: colors["primaryColor"])),
                            enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: colors["primaryColor"])),
                            focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: colors["primaryColor"]))),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                color: colors["backgroundColor"],
              ),
            )
          ],
        ),
        Align(
          alignment: Alignment.center,
          child: Container(
              margin: EdgeInsets.only(left: 80, right: 80, top: 200),
              height: 60,
              decoration: BoxDecoration(
                  color: colors["primaryColor"],
                  borderRadius: BorderRadius.circular(5)),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    if (Provider.of<_AuthenticationScreenModel>(context)
                        .signInFormKey
                        .currentState
                        .validate()) {
                      final String email =
                          Provider.of<_AuthenticationScreenModel>(context)
                              .signInEmailController
                              .text;
                      final String password =
                          Provider.of<_AuthenticationScreenModel>(context)
                              .signInPasswordController
                              .text;

                      this.signIn(email, password);
                    }
                  },
                  child: Center(
                      child: Text(
                    "Entrar",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  )),
                ),
              )),
        )
      ],
    );
  }
}

class AuthenticationTabs extends StatelessWidget {
  const AuthenticationTabs({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      decoration: BoxDecoration(
          color: colors["backgroundColor2"],
          borderRadius: BorderRadius.circular(5)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          AuthenticationTab(
            tab: Tab.SignIn,
            text: "Entrar",
            selected:
                Provider.of<_AuthenticationScreenModel>(context).selectedTab ==
                    Tab.SignIn,
          ),
          AuthenticationTab(
            tab: Tab.SignUp,
            text: "Nova conta",
            selected:
                Provider.of<_AuthenticationScreenModel>(context).selectedTab ==
                    Tab.SignUp,
          ),
        ],
      ),
    );
  }
}
