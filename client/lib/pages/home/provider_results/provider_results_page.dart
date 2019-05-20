import 'package:flutter/material.dart';
import 'package:mobile/utils/constants.dart';

class ProviderResultsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: colors["backgroundColor"],
        body: Column(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: _buildHeader(context),
            ),
            Expanded(
              flex: 4,
              child: _buildSubHeader(),
            ),
            Expanded(flex: 10, child: _buildBody()),
          ],
        ));
  }

  Container _buildBody() {
    return Container(
      child: ListView(
        padding: EdgeInsets.only(top: 20),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(
              left: 20.0,
              right: 20.0,
            ),
            child: _buildProviderCard(),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 20.0,
              right: 20.0,
            ),
            child: _buildProviderCard(),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 20.0,
              right: 20.0,
            ),
            child: _buildProviderCard(),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 20.0,
              right: 20.0,
            ),
            child: _buildProviderCard(),
          ),
        ],
      ),
    );
  }

  Container _buildSubHeader() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: colors["backgroundColor2"],
      ),
      margin: EdgeInsets.only(left: 20, right: 20, top: 40, bottom: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Mostrando resultados para: ",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              Row(
                children: <Widget>[
                  Text(
                    "Encanador",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: colors["primaryColor"]),
                  ),
                  Text(
                    ", até 15 km",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  )
                ],
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: Container(
        color: colors["backgroundColor2"],
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Icon(
                Icons.arrow_back,
                size: 32,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Text(
                "Voltar",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
    );
  }

  Container _buildProviderCard() {
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
            offset: new Offset(0.0, 2.0),
            blurRadius: 2.0,
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
                          Icon(Icons.ac_unit),
                          Padding(
                            padding: const EdgeInsets.only(left: 4.0),
                            child: Text(
                              "3000",
                              style: TextStyle(
                                  color: colors["primaryColor"],
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
