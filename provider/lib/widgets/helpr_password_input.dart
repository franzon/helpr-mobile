import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class HelprPasswordInput extends StatefulWidget {
  final Function callback;

  HelprPasswordInput({@required this.callback});

  @override
  _HelprPasswordInputState createState() =>
      _HelprPasswordInputState(callback: callback);
}

class _HelprPasswordInputState extends State<HelprPasswordInput> {
  final Function callback;

  final input = BehaviorSubject<String>.seeded("");

  _HelprPasswordInputState({@required this.callback});

  @override
  void initState() {
    super.initState();

    input.debounce(new Duration(milliseconds: 300)).listen((text) {
      bool hasMinimumLength = text.length >= 6;
      callback(hasMinimumLength, text);
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
      obscureText: true,
      onChanged: (text) => input.add(text),
      keyboardType: TextInputType.text,
      
      maxLines: 1,
      decoration: InputDecoration(
          filled: true,
          fillColor: Theme.of(context).accentColor,
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          hintText: "Senha"),
    );
  }
}
