import 'package:flutter/material.dart';

final colors = {
  "primary": Color(0xFFF57474),
  "background": Color(0xFF2B2E33),
  "background2": Color(0xFF34363A)
};

double Width(BuildContext context, double percent) =>
    MediaQuery.of(context).size.width * percent;

double Height(BuildContext context, double percent) =>
    MediaQuery.of(context).size.height * percent;

Widget HelprBase({@required Widget child}) {
  return Scaffold(
    resizeToAvoidBottomInset: false,
    backgroundColor: colors["background"],
    body: SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[Expanded(child: child)],
      ),
    ),
  );
}

Widget HelprBaseScroll({@required Widget child}) {
  return Scaffold(
    backgroundColor: colors["background"],
    body: SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[Expanded(child: child)],
      ),
    ),
  );
}

Widget HelprBody(
        {@required Widget child,
        EdgeInsets margin = const EdgeInsets.only(
            top: 15.0, left: 15.0, right: 15.0, bottom: 15.0)}) =>
    Container(
      margin: margin,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8), color: colors["background2"]),
      child: child,
    );

Widget HelprButton({@required String text, @required Function onPressed}) =>
    FlatButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(color: Colors.white),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
      color: colors["primary"],
    );

Widget HelprFloatTop(
    {@required Widget child, Offset offset = const Offset(0.0, -20.0)}) {
  return Transform.translate(
    offset: offset,
    child: Align(
      alignment: Alignment.topCenter,
      child: child,
    ),
  );
}

Widget HelprFloatBottom(
    {@required Widget child, Offset offset = const Offset(0.0, 25.0)}) {
  return Transform.translate(
    offset: offset,
    child: Align(
      alignment: Alignment.bottomCenter,
      child: child,
    ),
  );
}

Widget HelprBackHeader({BuildContext context, Widget rightWidget}) {
  return Container(
    width: Width(context, 1),
    height: Height(context, 0.1),
    padding: const EdgeInsets.symmetric(horizontal: 10.0),
    color: colors["primary"],
    child: Row(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
              ),
              Text(
                "Voltar",
                style: TextStyle(fontSize: 18),
              )
            ],
          ),
        ),
        Expanded(
          child: Container(),
        ),
        if (rightWidget != null) rightWidget
      ],
    ),
  );
}

Widget HelprTextFormField(
    {@required BuildContext context,
    @required String hintText,
    @required TextEditingController controller,
    Function(String) validator,
    FocusNode focusNode,
    FocusNode nextFocusNode,
    bool password = false}) {
  return TextFormField(
      style: TextStyle(color: Colors.white),
      textCapitalization: TextCapitalization.words,
      validator: validator,
      focusNode: focusNode,
      controller: controller,
      obscureText: password,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (text) =>
          FocusScope.of(context).requestFocus(nextFocusNode),
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 20.0),
          hintText: hintText,
          hintStyle: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
          border: UnderlineInputBorder(
              borderSide: BorderSide(color: colors["primary"])),
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: colors["primary"])),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: colors["primary"]))));
}

// Widget HelprStackedBody({Widget top, Widget bottom, Widget child}) {
//   return Expanded(
//     child: Container(
//         child: Stack(
//       children: [
//         HelprBody(child: child)],
//     )),
//   );
// }

// Container(
//         child: Stack(
//       children: <Widget>[
//         if (top != null)
//           Transform.translate(
//             offset: Offset(0, -50),
//             child: Align(
//               alignment: Alignment.topCenter,
//               child: top,
//             ),
//           ),
//         if (bottom != null)
//           Transform.translate(widget
//             offset: Offset(0, 50),
//             child: Align(
//               alignment: Alignment.bottomCenter,
//               child: top,
//             ),
//           ),
//         HelprBody(child: Expanded(child: child)),
//       ],
//     ));
