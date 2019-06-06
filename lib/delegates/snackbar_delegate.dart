import 'package:flutter/material.dart';

class SnackBarDelegate {
  static showSnackBar(context, String text, scaffoldKey,{int time}) {
    scaffoldKey.currentState.showSnackBar(SnackBar(
      content: new Text(text),
      duration: Duration(milliseconds: (time==null)?400:time),
    ));
  }
}
