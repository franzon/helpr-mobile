import 'package:flutter/material.dart';


class HelprBackButton extends StatelessWidget {
  const HelprBackButton({
    Key key,
    @required this.text,
    @required this.onPressed,
  }) : super(key: key);

  final String text;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Padding(padding: EdgeInsets.only(left: 25.0, top: 155.0)),
        Container(
          height: 55.0,
          child: OutlineButton(
            textColor: Colors.white,
            borderSide: BorderSide(color: Colors.white, width: 1.5),
            onPressed: onPressed,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.arrow_back,
                  size: 30.0,
                  color: Colors.white,
                ),
                Container(
                  padding: EdgeInsets.only(left: 25.0, right: 5.0),
                  child: Text(
                    text,
                    textScaleFactor: 1.75,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.normal
                      ),
                  ),
                ),
              ],
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6.0)
            ),
          ),
        ),
      ],
    );
  }
}
