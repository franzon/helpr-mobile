import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class TextOutput {
  final String value;
  final bool valid;

  TextOutput(this.value, this.valid);
}

class HelprEmailInput extends StatefulWidget {
  final BehaviorSubject<TextOutput> output;

  HelprEmailInput({@required this.output});

  @override
  _HelprEmailInputState createState() =>
      _HelprEmailInputState(output: this.output);
}

class _HelprEmailInputState extends State<HelprEmailInput> {
  final RegExp regex = new RegExp(
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$");
  final BehaviorSubject<TextOutput> output;
  final BehaviorSubject<String> input = new BehaviorSubject<String>.seeded("");

  bool isValid = false;

  _HelprEmailInputState({@required this.output});

  @override
  void initState() {
    super.initState();
    input.debounce(new Duration(milliseconds: 300)).listen((text) {
      bool correctFormat = this.regex.hasMatch(text);
      if (correctFormat) {
        setState(() {
          isValid = true;
        });
      } else {
        setState(() {
          isValid = false;
        });
      }
      output.add(TextOutput(text, correctFormat));
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
