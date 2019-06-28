import 'package:flutter/material.dart';
import 'package:client_v3/constants/ui.dart';
import 'package:client_v3/models/Category.dart';
import 'package:client_v3/models/Provider.dart';
import 'package:client_v3/pages/home/ProviderInfo.dart';
import 'package:client_v3/providers/ProvidersProvider.dart';
import 'package:client_v3/setupSingletons.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:page_transition/page_transition.dart';

class _NearbyProviderCard extends StatelessWidget {
  final Provider provider;
  final int index;

  const _NearbyProviderCard({this.provider, this.index});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(PageTransition(
            child: ProviderInfoPage(
              provider: provider,
            ),
            type: PageTransitionType.leftToRightWithFade));
      },
      child: Opacity(
        opacity: provider.isOnline ? 1.0 : 0.3,
        child: Container(
          margin: EdgeInsets.only(bottom: 40),
          decoration: BoxDecoration(
            color: colors["background2"],
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(5),
                topRight: Radius.circular(5),
                bottomRight: Radius.circular(10)),
            boxShadow: [
              new BoxShadow(
                color: Colors.black,
                offset: const Offset(0.0, 0.5),
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
                              color: colors["primary"],
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Image.asset(
                                  index == 0
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
                                      color: index == 0
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
                                      provider.comments[0].clientName,
                                      style: TextStyle(fontSize: 12),
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
                                    Text(
                                      "Sem avaliações",
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 12),
                                    ),
                                  ],
                                ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Text(
                                provider.serviceCount.toString(),
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text("atendimentos",
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 14))
                            ],
                          )
                        ],
                      ),
                      if (!provider.isOnline)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Container(
                                decoration: BoxDecoration(
                                    color: colors["primary"],
                                    borderRadius: BorderRadius.circular(5.0)),
                                padding: EdgeInsets.all(3),
                                child: Text("Offline",
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 14)))
                          ],
                        )
                    ],
                  ),
                  height: Height(context, 0.15),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(
                        width: 1,
                        color: index == 0 ? Colors.yellow : Colors.grey),
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

class ProviderListPage extends StatelessWidget {
  final providersProvider = getIt<ProvidersProvider>();
  final Category category;

  ProviderListPage({@required this.category}) {
    providersProvider.loadNearbyProviders(
        category: category, latitude: 40, longitude: 40, maxDistance: 5);
  }

  @override
  Widget build(BuildContext context) {
    return HelprBase(
        child: Column(
      children: <Widget>[
        HelprBackHeader(rightWidget: Text(""), context: context),
        // filter animation

        Flexible(
          child: Container(
            child: StreamBuilder<List<Provider>>(
                stream: providersProvider.providers,
                builder: (context, snapshot) {
                  return snapshot.hasData
                      ? ListView.builder(
                          padding: const EdgeInsets.all(20.0),
                          shrinkWrap: true,
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            return _NearbyProviderCard(
                              index: index,
                              provider: snapshot.data[index],
                            );
                          },
                        )
                      : Center(
                          child: SpinKitWave(
                          color: colors["primary"],
                          size: 20,
                        ));
                }),
          ),
        )
      ],
    ));
  }
}
