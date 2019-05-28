import 'package:flutter/material.dart';
import 'package:mobile/api/auth_api.dart';
import 'package:mobile/main.dart';
import 'package:mobile/providers/user_provider.dart';
import 'package:mobile/utils/constants.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class AuthenticationSignUpForm extends StatelessWidget {
  final userProvider = getIt.get<UserProvider>();

  final BehaviorSubject _loading$ = BehaviorSubject.seeded(false);
  final GlobalKey<FormState> _form = GlobalKey<FormState>();

  final RegExp _emailRegex = new RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  final _nameController = TextEditingController(text: "Jorge Rossi");
  final _emailController =
      TextEditingController(text: "jorgefzrossi@gmail.com");
  final _passwordController = TextEditingController(text: "12345678");

  @override
  Widget build(BuildContext context) {
    _loading$.pairwise().listen((val) async {
      final latestValues = val.toList();
      if (!latestValues[0] && latestValues[1]) {
        try {
          final name = _nameController.value.text;
          final email = _emailController.value.text;
          final password = _passwordController.value.text;

          final result = await AuthApi.signUp(
              name: name, email: email, password: password);

          debugPrint(result.toString());

          switch (result["message"]) {
            case "user already exists":
              _loading$.add(false);

              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text(
                  "Email já foi utilizado",
                  textAlign: TextAlign.center,
                ),
              ));
              break;

            case "user created":
              userProvider.signIn(context, email: email, password: password);

              break;
            default:
          }
        } catch (e) {
          _loading$.add(false);
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text(
              "Erro. Por favor, tente novamente",
              textAlign: TextAlign.center,
            ),
          ));
        }
      }
    });

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: <Widget>[
          Container(
            height: 300,
            child: Stack(
              children: [
                Container(
                  child: Container(
                    decoration: BoxDecoration(
                      color: colors["backgroundColor2"],
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 50, right: 50, bottom: 50),
                      child: _buildForm(context),
                    ),
                  ),
                ),
                Transform.translate(
                  offset: Offset(0, 30),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: _buildButton(),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container _buildButton() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: colors["primaryColor"]),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            _submitForm();
          },
          child: Container(
            width: 200,
            height: 60,
            child: StreamBuilder(
                stream: _loading$.stream,
                builder: (context, snapshot) {
                  return Center(
                      child: !snapshot.hasData || !snapshot.data
                          ? Text(
                              "Criar conta",
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

  Widget _buildForm(BuildContext context) {
    return Form(
      key: _form,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _buildNameInput(context),
          _buildEmailInput(context),
          _buildPasswordInput(context)
        ],
      ),
    );
  }

  Widget _buildNameInput(BuildContext context) {
    return TextFormField(
        validator: (value) {
          if (value.isEmpty) {
            return "Digite um nome";
          }
        },
        controller: _nameController,
        textInputAction: TextInputAction.next,
        onFieldSubmitted: (_) {
          FocusScope.of(context).requestFocus(_emailFocusNode);
        },
        style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 20.0),
            hintText: "Nome",
            hintStyle: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
            prefixIcon: Padding(
              padding: const EdgeInsets.all(0.0),
              child: Icon(
                Icons.person,
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

  Widget _buildEmailInput(BuildContext context) {
    return TextFormField(
        validator: (value) {
          if (value.isEmpty || !_emailRegex.hasMatch(value)) {
            return "Email inválido";
          }
        },
        controller: _emailController,
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.emailAddress,
        focusNode: _emailFocusNode,
        onFieldSubmitted: (_) {
          FocusScope.of(context).requestFocus(_passwordFocusNode);
        },
        style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 20.0),
            hintText: "Email",
            hintStyle: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
            prefixIcon: Padding(
              padding: const EdgeInsets.all(0.0),
              child: Icon(
                Icons.email,
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

  Widget _buildPasswordInput(BuildContext context) {
    return TextFormField(
        validator: (value) {
          if (value.isEmpty) {
            return "Digite a senha";
          }
        },
        controller: _passwordController,
        obscureText: true,
        textInputAction: TextInputAction.done,
        focusNode: _passwordFocusNode,
        style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 20.0),
            hintText: "Senha",
            hintStyle: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
            prefixIcon: Padding(
              padding: const EdgeInsets.all(0.0),
              child: Icon(
                Icons.lock,
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

  void _submitForm() {
    if (_form.currentState.validate()) {
      _loading$.add(true);
    }
  }
}
