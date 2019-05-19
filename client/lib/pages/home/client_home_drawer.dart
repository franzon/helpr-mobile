import 'package:flutter/material.dart';
import 'package:flutter_keychain/flutter_keychain.dart';
import 'package:mobile/pages/authentication/authentication_page.dart';
import 'package:mobile/pages/home/client_home_all_categories.dart';
import 'package:page_transition/page_transition.dart';

import 'package:mobile/utils/constants.dart';

class ClientHomeDrawer extends StatelessWidget {
  const ClientHomeDrawer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: colors["backgroundColor"],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                    margin: EdgeInsets.only(left: 80, right: 80, bottom: 20),
                    height: 50,
                    decoration: BoxDecoration(
                        color: colors["primaryColor"],
                        borderRadius: BorderRadius.circular(5)),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          FlutterKeychain.remove(key: "token");

                          Navigator.pushReplacement(
                              context,
                              PageTransition(
                                  type: PageTransitionType.leftToRight,
                                  alignment: Alignment.bottomCenter,
                                  child: AuthenticationPage()));
                        },
                        child: Center(
                            child: Text(
                          "Sair",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        )),
                      ),
                    )))
          ],
        ),
      ),
    );
  }
}
