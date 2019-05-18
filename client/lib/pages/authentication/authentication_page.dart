import 'package:flutter/material.dart';
import 'package:mobile/pages/authentication/authentication_signin.dart';
import 'package:mobile/pages/authentication/authentication_signup.dart';
import 'package:mobile/utils/constants.dart';
import 'package:provider/provider.dart';

enum Tab { SignIn, SignUp }

class AuthenticationScreenModel with ChangeNotifier {
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
        Provider.of<AuthenticationScreenModel>(context).selectTab(this.tab);
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
    return ChangeNotifierProvider<AuthenticationScreenModel>(
        builder: (_) => AuthenticationScreenModel(),
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
      child: Provider.of<AuthenticationScreenModel>(context).selectedTab ==
              Tab.SignIn
          ? AuthenticationSignInForm()
          : AuthenticationSignUpForm(),
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
                Provider.of<AuthenticationScreenModel>(context).selectedTab ==
                    Tab.SignIn,
          ),
          AuthenticationTab(
            tab: Tab.SignUp,
            text: "Nova conta",
            selected:
                Provider.of<AuthenticationScreenModel>(context).selectedTab ==
                    Tab.SignUp,
          ),
        ],
      ),
    );
  }
}
