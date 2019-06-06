import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hackathon_demo/translation/TranslationService.dart';
import 'package:hackathon_demo/user/storage/user_shared_pref.dart';

class AppSplashScreen extends StatefulWidget {
  @override
  _AppSplashScreenState createState() => _AppSplashScreenState();
}

class _AppSplashScreenState extends State<AppSplashScreen> {
  bool isUserLoggedIn = false;

  @override
  void initState() {
    super.initState();

   startTimer();
  }

  startMainScreen() {
    UserSharedPreference.getLoggedInUserEmail().then((email) {
      print(email);
      if (email != null && email.toString() != "")
        Navigator.pushReplacementNamed(context, "/chat");
      else {
        Navigator.pushReplacementNamed(context, "/login");
      }
    });
  }

  startTimer() async {
    var _duration = new Duration( milliseconds: 1500);
    return new Timer(_duration, startMainScreen);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
        body: Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            decoration: BoxDecoration( 
                gradient: LinearGradient(colors: [
                  Color(0xff1C6BFF),
                  Color(0xffC523FF),
                ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
           height: size.height,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  height: size.height * 0.15,
                  width: size.height * 0.15,
                  decoration: BoxDecoration(),
                  child: Material(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(75))),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Image.asset(
                          "assets/images/icon.png",
                          fit: BoxFit.cover,
                        ),
                      )),
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
