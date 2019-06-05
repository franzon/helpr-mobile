import 'package:flutter/material.dart';
import 'package:mobile/utils/constants.dart';

class ProviderResultsCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
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
                        "Fulano de tal",
                        style: TextStyle(
                            color: colors["primaryColor"],
                            fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Image.asset(
                              "assets/icons/reputation.png",
                              scale: 3,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 4.0),
                            child: Text(
                              "3000",
                              style: TextStyle(
                                  color: Colors.yellow,
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
                      Column(
                        children: <Widget>[
                          Text("Ciclano, há 3 dias"),
                          Text("Mucho bom...",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ))
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            "75",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text("atendimentos")
                        ],
                      )
                    ],
                  )
                ],
              ),
              height: 100,
            ),
          ),
          Container(
            transform: Matrix4.translationValues(-10.0, -10.0, 0.0),
            decoration: new BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                        "https://randomuser.me/api/portraits/men/37.jpg")),
                shape: BoxShape.circle,
                border: Border.all(width: 1, color: Colors.yellow)),
            width: 50,
            height: 50,
          )
        ],
      ),
    );
  }
}
