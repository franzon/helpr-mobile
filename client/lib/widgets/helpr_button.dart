import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class HelprButton extends StatelessWidget {
  final bool isLoading;
  final bool isDisabled;
  final String text;
  final Function callback;

  HelprButton(
      {@required this.isLoading,
      @required this.isDisabled,
      @required this.text,
      @required this.callback});

  @override
  Widget build(BuildContext context) {
    return Material(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        clipBehavior: Clip.antiAlias,
        color: this.isDisabled ? Colors.grey : Theme.of(context).primaryColor,
        child: !this.isLoading
            ? InkWell(
                onTap: this.isDisabled
                    ? null
                    : () {
                        if (callback != null) callback();
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
