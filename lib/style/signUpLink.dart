import 'package:flutter/material.dart';

class SignUp extends StatelessWidget {
  SignUp();
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenHeight = screenSize.height;
    final topH = screenHeight/7.12;
    final fontHeight = screenHeight/59.3;

    return (new FlatButton(
      padding: EdgeInsets.only(
        top: topH,
      ),
      onPressed: null,
      child: new Text(
        "¿Necesita Registrarse?",
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
        softWrap: true,
        style: new TextStyle(
            fontWeight: FontWeight.w300,
            letterSpacing: 0.5,
            color: Colors.white,
            fontSize: fontHeight),
      ),
    ));
  }
}