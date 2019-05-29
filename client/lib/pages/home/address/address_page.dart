import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mobile/utils/constants.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

class AddressPage extends StatefulWidget {
  @override
  _AddressPageState createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage>
    with TickerProviderStateMixin {
  final BehaviorSubject<String> _cep$ = BehaviorSubject.seeded("");
  final BehaviorSubject<bool> _cepLoading$ = BehaviorSubject.seeded(false);
  final BehaviorSubject _loading$ = BehaviorSubject.seeded(false);
  final _cepController = MaskedTextController(mask: '00000-000');

  AnimationController _controller;
  Animation _animation;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    _animation = Tween<double>(
      begin: 150,
      end: 350,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.ease,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _cep$.debounceTime(const Duration(milliseconds: 600)).listen((cep) {
      if (cep.length >= 8) {
        debugPrint(cep);
        _cepLoading$.add(true);
        _controller.forward();

        Future.delayed(Duration(seconds: 5), () {
          _cepLoading$.add(false);
        });
      } else {
        _controller.reset();
      }
    });

    return Scaffold(
      backgroundColor: colors["backgroundColor"],
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView(
                children: <Widget>[
                  Container(height: 20),
                  _buildHeader(),
                  Container(
                    height: 20,
                  ),
                  Container(height: 60, child: _buildSubheader(context)),
                  Container(
                    height: 30,
                  ),
                  _buildForm(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(
            "helpr",
            style: TextStyle(
              color: colors["primaryColor"],
              fontSize: 48,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSubheader(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      decoration: BoxDecoration(
          color: colors["backgroundColor2"],
          borderRadius: BorderRadius.circular(5)),
      child: Center(
        child: Text(
          "Você ainda não tem um endereço cadastrado",
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _buildForm(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: <Widget>[
          AnimatedBuilder(
            animation: _controller,
            builder: (BuildContext context, Widget child) {
              return Container(
                height: _animation.value,
                child: Stack(
                  children: [
                    Container(
                      child: Container(
                        decoration: BoxDecoration(
                          color: colors["backgroundColor2"],
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 50, right: 50),
                          child: Form(
                            child: StreamBuilder(
                                stream: _cep$,
                                builder: (context, snapshot) {
                                  if (!snapshot.hasData ||
                                      snapshot.data.toString().length < 8) {
                                    return Padding(
                                      padding: const EdgeInsets.only(top: 30.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          _buildCepInput(context),
                                        ],
                                      ),
                                    );
                                  }

                                  return Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      _buildCepInput(context),
                                      _buildCountyInput(context),
                                      _buildCountyInput(context),
                                      _buildCountyInput(context)
                                      // _buildCepInput(context),
                                      // _buildCepInput(context),
                                    ],
                                  );
                                }),
                          ),
                        ),
                      ),
                    ),
                    // Transform.translate(
                    //   offset: Offset(0, 30),
                    //   child: Align(
                    //     alignment: Alignment.bottomCenter,
                    //     child: _buildButton(),
                    //   ),
                    // )
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCepInput(BuildContext context) {
    return StreamBuilder<Object>(
        stream: _cepLoading$,
        builder: (context, snapshot) {
          return TextField(

              // validator: (value) {
              //   // if (value.isEmpty || !_emailRegex.hasMatch(value)) {
              //   //   return "Email inválido";
              //   // }
              // },
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              // onFieldSubmitted: (_) {
              //   // FocusScope.of(context).requestFocus(_passwordFocusNode);
              // },
              controller: _cepController,
              maxLength: 9,
              onChanged: (text) => _cep$.add(text),
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12),
              decoration: InputDecoration(
                  counterText: "",
                  contentPadding: EdgeInsets.symmetric(vertical: 20.0),
                  hintText: "CEP",
                  hintStyle: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Icon(
                      Icons.map,
                      color: colors["primaryColor"],
                    ),
                  ),
                  suffixIcon: snapshot.hasData && snapshot.data
                      ? Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: ConstrainedBox(
                            constraints:
                                BoxConstraints(maxWidth: 20, maxHeight: 20),
                            child: SpinKitWave(
                              color: colors["primaryColor"],
                              size: 16,
                            ),
                          ))
                      : null,
                  border: UnderlineInputBorder(
                      borderSide: BorderSide(color: colors["primaryColor"])),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: colors["primaryColor"])),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: colors["primaryColor"]))));
        });
  }

  Widget _buildCountyInput(BuildContext context) {
    return TextFormField(
        validator: (value) {
          if (value.isEmpty) {
            return "Digite a cidade";
          }
        },
        // keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.next,
        onFieldSubmitted: (_) {
          // FocusScope.of(context).requestFocus(_passwordFocusNode);
        },
        // controller: _emailController,
        style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 20.0),
            hintText: "Cidade",
            hintStyle: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
            prefixIcon: Padding(
              padding: const EdgeInsets.all(0.0),
              child: Icon(
                Icons.location_city,
                color: colors["primaryColor"],
              ),
            ),
            border: UnderlineInputBorder(
                borderSide: BorderSide(color: colors["primaryColor"])),
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: colors["primaryColor"])),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: colors["primaryColor"]))));
  }

  Container _buildButton() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: colors["primaryColor"]),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          child: Container(
            width: 200,
            height: 60,
            child: StreamBuilder(
                stream: _loading$.stream,
                builder: (context, snapshot) {
                  return Center(
                      child: !snapshot.hasData || !snapshot.data
                          ? Text(
                              "Entrar",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          : SpinKitWave(
                              color: Colors.white,
                              size: 20,
                            ));
                }),
          ),
        ),
      ),
    );
  }
}
