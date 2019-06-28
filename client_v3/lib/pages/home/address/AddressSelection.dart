import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:client_v3/constants/ui.dart';
import 'package:client_v3/models/Address.dart';
import 'package:client_v3/models/Client.dart';
import 'package:client_v3/models/Provider.dart';
import 'package:client_v3/pages/home/address/NewAddress.dart';
import 'package:client_v3/pages/home/confirmation/ServiceConfirmation.dart';
import 'package:client_v3/providers/ClientProvider.dart';
import 'package:client_v3/setupSingletons.dart';
import 'package:page_transition/page_transition.dart';

class _AddressCard extends StatelessWidget {
  final Provider provider;
  final Address address;

  _AddressCard({@required this.provider, @required this.address});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(PageTransition(
            child: ServiceConfirmationPage(
              provider: provider,
              address: address,
            ),
            type: PageTransitionType.scale));
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 15.0),
        padding: const EdgeInsets.all(15.0),
        decoration: BoxDecoration(
            border: Border.all(color: colors["background"], width: 2),
            borderRadius: BorderRadius.circular(10.0)),
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: Icon(
                Icons.map,
                color: colors["primary"],
              ),
            ),
            Expanded(
              child: Text(
                address.street +
                    ", " +
                    address.neighborhood +
                    ", número " +
                    address.number +
                    " - " +
                    address.city,
                style: TextStyle(fontWeight: FontWeight.normal, fontSize: 14.0),
                maxLines: 2,
                softWrap: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AddressSelectionPage extends StatelessWidget {
  final clientProvider = getIt<ClientProvider>();
  final Provider provider;

  AddressSelectionPage({@required this.provider});

  @override
  Widget build(BuildContext context) {
    return HelprBase(
        child: HelprBody(
            child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(30.0),
          child: Text("Escolha um endereço"),
        ),
        Expanded(
          child: Center(
            child: Container(
              padding: const EdgeInsets.all(15.0),
              child: StreamBuilder<Client>(
                  stream: clientProvider.client,
                  builder: (context, snapshot) {
                    return Container(
                      child: snapshot.hasData &&
                              snapshot.data.addresses.length > 0
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                for (Address address in snapshot.data.addresses)
                                  _AddressCard(
                                    address: address,
                                    provider: provider,
                                  )
                              ],
                            )
                          : Center(
                              child: Text("Ops, nenhum endereço cadastrado",
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal))),
                    );
                  }),
            ),
          ),
        ),
        Container(
            margin: const EdgeInsets.only(bottom: 20.0),
            child: HelprButton(
                onPressed: () {
                  Navigator.of(context).push(PageTransition(
                      child: NewAddressPage(),
                      type: PageTransitionType.downToUp));
                },
                text: "Adicionar novo endereço"))
      ],
    )));
  }
}
