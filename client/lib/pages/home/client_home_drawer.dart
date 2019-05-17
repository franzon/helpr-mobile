import 'package:flutter/material.dart';
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
        child: DrawerHeader(
          child: Text("Helpr"),
        ),
      ),
    );
  }
}
