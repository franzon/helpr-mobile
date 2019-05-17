import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class HelprEmailInput extends StatefulWidget {
  final Function callback;

  HelprEmailInput({@required this.callback});

  @override
  _HelprEmailInputState createState() =>
      _HelprEmailInputState(callback: callback);
}

class _HelprEmailInputState extends State<HelprEmailInput> {
  final Function callback;

  final regex = RegExp(
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$");
  final input = BehaviorSubject<String>.seeded("");

  _HelprEmailInputState({@required this.callback});

  @override
  void initState() {
    super.initState();

    input.debounceTime(new Duration(milliseconds: 300)).listen((text) {
      bool correctFormat = this.regex.hasMatch(text);
      callback(correctFormat, text);
    });
  }

  @override
  void dispose() {
    super.dispose();
    input.close();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (text) => input.add(text),
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
          filled: true,
          fillColor: Theme.of(context).accentColor,
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          hintText: "Digite seu email"),
    );
  }
}
