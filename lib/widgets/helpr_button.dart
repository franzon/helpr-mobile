import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:rxdart/rxdart.dart';

enum ButtonStatus { initial, loading, completed }

class HelprButton extends StatefulWidget {
  final String text;
  final BehaviorSubject<ButtonStatus> clickListener;

  HelprButton({@required this.text, @required this.clickListener});

  @override
  _HelprButtonState createState() =>
      _HelprButtonState(text: text, clickListener: this.clickListener);
}

class _HelprButtonState extends State<HelprButton> {
  final String text;
  final BehaviorSubject<ButtonStatus> clickListener;
  bool loading = false;

  _HelprButtonState({@required this.text, @required this.clickListener});

  @override
  void initState() {
    super.initState();
    this
        .clickListener
        .where((item) => item == ButtonStatus.completed)
        .listen((_) {
      if (this.mounted) {
        debugPrint('mounted');
        setState(() {
          this.loading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        clipBehavior: Clip.antiAlias,
        color: Theme.of(context).primaryColor,
        child: !this.loading
            ? InkWell(
                onTap: () {
                  setState(() {
                    this.loading = true;
                  });
                  this.clickListener.add(ButtonStatus.loading);
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 60,
                  child: Text(
                    this.text,
                    style: TextStyle(
                        color: Theme.of(context).accentColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              )
            : Container(
                alignment: Alignment.center,
                height: 60,
                child: SpinKitWave(
                  color: Theme.of(context).accentColor,
                  size: 20,
                )));
  }
}
