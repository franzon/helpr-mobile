import 'package:flutter/material.dart';
import 'package:client_v3/constants/ui.dart';
import 'package:client_v3/pages/authentication/Signin.dart';
import 'package:client_v3/pages/authentication/Signup.dart';
import 'package:rxdart/rxdart.dart';

enum PageTabs { SignIn, SignUp }

class AuthenticationPage extends StatelessWidget {
  final BehaviorSubject selectedTab = BehaviorSubject.seeded(PageTabs.SignIn);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors["background"],
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView(
                children: <Widget>[
                  Container(height: 20),
                  _buildAuthenticationHeader(),
                  Container(
                    height: 20,
                  ),
                  Container(
                      height: 60, child: _buildAuthenticationTabs(context)),
                  Container(
                    height: 50,
                  ),
                  _buildAuthenticationForm(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAuthenticationHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(
            "helpr",
            style: TextStyle(
              color: colors["primary"],
              fontSize: 48,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAuthenticationTabs(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      decoration: BoxDecoration(
          color: colors["background2"], borderRadius: BorderRadius.circular(5)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _buildAuthenticationTab(
            context,
            tab: PageTabs.SignIn,
            text: "Entrar",
          ),
          _buildAuthenticationTab(
            context,
            tab: PageTabs.SignUp,
            text: "Nova conta",
          ),
        ],
      ),
    );
  }

  Widget _buildAuthenticationTab(BuildContext context,
      {PageTabs tab, String text}) {
    return GestureDetector(
      onTap: () {
        selectedTab.add(tab);
      },
      child: StreamBuilder(
          stream: selectedTab.stream,
          builder: (context, snapshot) {
            return Container(
              decoration: BoxDecoration(
                  color: snapshot.data == tab
                      ? colors["background"]
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(5)),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  text,
                  style: TextStyle(
                    color:
                        snapshot.data == tab ? colors["primary"] : Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          }),
    );
  }

  Widget _buildAuthenticationForm(BuildContext context) {
    return StreamBuilder(
      stream: selectedTab.stream,
      builder: (context, snapshot) {
        return snapshot.data == PageTabs.SignIn
            ? AuthenticationSignInForm()
            : AuthenticationSignUpForm();
      },
    );
  }
}
