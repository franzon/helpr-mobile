import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:client_v3/constants/ui.dart';
import 'package:client_v3/pages/authentication/Authentication.dart';

class CustomDrawer extends StatelessWidget {

  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        canvasColor: colors["background2"],
      ),
      child: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: colors["background"]),
              accountName: Text("Ashish Rawat"),
              accountEmail: Text("ashishrawat2911@gmail.com"),
              currentAccountPicture: CircleAvatar(
                backgroundColor: colors["background2"],
                child: Text("A",
                  style: TextStyle(fontSize: 40.0),
                ),
              )
            ),
            ListTile(
              trailing: IconButton(
                icon: Icon(
                  Icons.exit_to_app,
                  color: Colors.white,
                ),
                tooltip: 'Sign Out',
                onPressed: () => {
                  Navigator.of(context).pushReplacement(
                    PageTransition(
                      child: AuthenticationPage(),
                      type: PageTransitionType.downToUp,
                    ),
                  )
                }
              )
              
            ),
          ],
        )
      ),
    );
  }
}