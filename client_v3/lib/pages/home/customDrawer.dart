import 'package:client_v3/models/Client.dart';
import 'package:client_v3/repositories/ClientRepository.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter_keychain/flutter_keychain.dart';
import 'package:client_v3/constants/ui.dart';
import 'package:client_v3/pages/authentication/Authentication.dart';

import '../../setupSingletons.dart';

class CustomDrawer extends StatefulWidget {
  @override
  _CustomDrawer createState() => _CustomDrawer();
}

class _CustomDrawer extends State<CustomDrawer> {
  final _clientRepository = getIt<ClientRepository>();

  @override
  void initState() {
  }

  Future<void> signOut (context) async {
    try{
      await FlutterKeychain.remove(key: 'token');

      Navigator.of(context).pushReplacement(
      PageTransition(
        child: AuthenticationPage(),
        type: PageTransitionType.downToUp,
      ),
    );
    }
    catch(e) {

    }
    
  }

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
              accountName: FutureBuilder<Client>(
                future: _clientRepository.getClient(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  return Text( snapshot.hasData ?snapshot.data.name : "User name");
                }
              ),
              accountEmail: FutureBuilder<Client>(
                future: _clientRepository.getClient(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  return Text( snapshot.hasData ? snapshot.data.email : "user@host.ccc");
                }
              ),
              currentAccountPicture: CircleAvatar(
                backgroundColor: colors["background2"],
                child: FutureBuilder<Client>(
                  future: _clientRepository.getClient(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    return Text(snapshot.hasData ? snapshot.data.name[0].toUpperCase() : "A",
                      style: TextStyle(fontSize: 40.0)
                    );
                  }
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
                  this.signOut(context)
                },
              ),
            ),
          ],
        )
      ),
    );
  }
}