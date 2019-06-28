import 'package:client_v3/constants/ui.dart';
import 'package:client_v3/pages/home/Home.dart';
import 'package:client_v3/providers/ClientProvider.dart';
import 'package:client_v3/repositories/ClientRepository.dart';
import 'package:client_v3/setupSingletons.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class EmailConfirmation extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _codeFocusNode = FocusNode();
  final _codeController = TextEditingController(text: "");
  final _clientRepository = getIt<ClientRepository>();
  final _clientProvider = getIt<ClientProvider>();

  @override
  Widget build(BuildContext context) {
    return HelprBaseScroll(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _buildAuthenticationHeader(),
          Center(
              child: Text(
            "Enviamos um código para seu email",
            style: TextStyle(fontWeight: FontWeight.normal),
          )),
          Expanded(
              child: HelprBody(
                  margin:
                      EdgeInsets.symmetric(vertical: 50.0, horizontal: 15.0),
                  child: Stack(
                    children: <Widget>[
                      Form(
                        key: _formKey,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              HelprTextFormField(
                                  context: context,
                                  hintText: "Código",
                                  controller: _codeController,
                                  validator: (text) => text.length == 0
                                      ? "Preencha o código"
                                      : null),
                            ],
                          ),
                        ),
                      ),
                      HelprFloatBottom(
                          child: Builder(
                              builder: (context) => HelprButton(
                                  onPressed: () async {
                                    if (this._formKey.currentState.validate()) {
                                      final code =
                                          this._codeController.value.text;
                                      final email =
                                          this._clientProvider.value.email;
                                      try {
                                        final message = await this
                                            ._clientRepository
                                            .confirmEmail(
                                                email: email,
                                                confirmationCode: code);

                                        if (message == "email confirmed") {
                                          this
                                              ._clientProvider
                                              .loadClient()
                                              .then((_) {
                                            Navigator.pushReplacement(
                                                context,
                                                PageTransition(
                                                    duration: const Duration(
                                                        milliseconds: 500),
                                                    type:
                                                        PageTransitionType.fade,
                                                    child: HomePage()));
                                          });
                                        } else if (message ==
                                            "already confirmed") {
                                          Scaffold.of(context)
                                              .showSnackBar(SnackBar(
                                            content: Text(
                                              "Usuário já foi confirmado",
                                              textAlign: TextAlign.center,
                                            ),
                                          ));
                                        } else if (message == "invalid code") {
                                          Scaffold.of(context)
                                              .showSnackBar(SnackBar(
                                            content: Text(
                                              "Código inválido",
                                              textAlign: TextAlign.center,
                                            ),
                                          ));
                                        }
                                      } catch (e) {
                                        Scaffold.of(context)
                                            .showSnackBar(SnackBar(
                                          content: Text(
                                            "Erro ao confirmar",
                                            textAlign: TextAlign.center,
                                          ),
                                        ));
                                      }
                                    }
                                  },
                                  text: "Confirmar")))
                    ],
                  )))
        ],
      ),
    );
  }

  Widget _buildAuthenticationHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(
            "helpr",
            style: TextStyle(
              color: colors["primary"],
              fontSize: 48,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
