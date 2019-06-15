import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mobile/models/ProviderResult.dart';
import 'package:mobile/pages/home/provider_confirmation/provider_confirmation_page.dart';
import 'package:mobile/utils/constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:page_transition/page_transition.dart';

class ProviderResultsCard extends StatelessWidget {
  final ProviderResult provider;

  ProviderResultsCard({@required this.provider});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            PageTransition(
                type: PageTransitionType.fade,
                duration: Duration(milliseconds: 400),
                alignment: Alignment.center,
                child: ProviderConfirmationPage(
                  provider: provider,
                )));
      },
      child: Opacity(
        opacity: provider.isOnline ? 1.0 : 0.3,
        child: Container(
          margin: EdgeInsets.only(bottom: 40),
          decoration: BoxDecoration(
            color: colors["backgroundColor2"],
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(5),
                topRight: Radius.circular(5),
                bottomRight: Radius.circular(10)),
            boxShadow: [
              new BoxShadow(
                color: Colors.black,
                offset: new Offset(0.0, 0.5),
                blurRadius: 0.5,
              )
            ],
          ),
          child: Stack(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 50, right: 20, bottom: 20),
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            provider.name,
                            style: TextStyle(
                                color: colors["primaryColor"],
                                fontWeight: FontWeight.bold),
                          ),
                          Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Image.asset(
                                  provider.index == 0
                                      ? "assets/icons/reputation.png"
                                      : "assets/icons/reputation_gray.png",
                                  scale: 3,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 4.0),
                                child: Text(
                                  provider.reputation.toString(),
                                  style: TextStyle(
                                      color: provider.index == 0
                                          ? Colors.yellow
                                          : Colors.grey,
                                      fontWeight: FontWeight.bold),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          provider.comments.length > 0
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      provider.comments[0].name,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 4.0),
                                      child: Text(provider.comments[0].text,
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey,
                                          )),
                                    )
                                  ],
                                )
                              : Column(
                                  children: <Widget>[
                                    Text("Sem avaliações"),
                                  ],
                                ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Text(
                                provider.serviceCount.toString(),
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text("atendimentos")
                            ],
                          )
                        ],
                      ),
                      if (!provider.isOnline)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Container(
                                color: Colors.red,
                                padding: EdgeInsets.all(3),
                                child: Text("Offline"))
                          ],
                        )
                    ],
                  ),
                  height: 120,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(
                        width: 1,
                        color:
                            provider.index == 0 ? Colors.yellow : Colors.grey),
                    shape: BoxShape.circle),
                transform: Matrix4.translationValues(-10.0, -10.0, 0.0),
                child: ClipRRect(
                  borderRadius: new BorderRadius.circular(50.0),
                  child: CachedNetworkImage(
                    imageUrl: provider.profilePictureUrl,
                    placeholder: (context, url) => new SpinKitWave(
                          size: 18,
                          color: Colors.white,
                        ),
                    errorWidget: (context, url, error) => new Icon(Icons.error),
                  ),
                ),
                // decoration: new BoxDecoration(
                //     image: FadeInImage.memoryNetwork()

                //     DecorationImage(
                //         image:
                //          MemoryImage(
                //             Base64Decoder().convert(provider.profilePicture))),
                //     shape: BoxShape.circle,
                //     border: Border.all(width: 1, color: Colors.yellow)),
                width: 50,
                height: 50,
              )
            ],
          ),
        ),
      ),
    );
  }
}
