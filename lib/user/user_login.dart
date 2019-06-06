import 'package:flutter/material.dart';
import 'package:hackathon_demo/delegates/snackbar_delegate.dart';
import 'package:hackathon_demo/statics/color_pallets.dart';
import 'package:hackathon_demo/statics/text_styles.dart';
import 'package:hackathon_demo/user/server/login_server.dart';
import 'package:hackathon_demo/user/storage/user_shared_pref.dart';
import 'package:hackathon_demo/utils/validators.dart';

import 'model/user_model.dart';

class UserLogin extends StatefulWidget {
  @override
  _UserLoginState createState() => _UserLoginState();
}

class _UserLoginState extends State<UserLogin>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> splashAnimation;
  Animation<double> borderAnimation;
  final passwordTextController = TextEditingController();
  final nameTextController = TextEditingController();

  final emailTextController = TextEditingController();
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();
  bool isLoggedIn = false;
  var profileData;
  FocusNode textSecondFocusNode = new FocusNode();
  bool isLoading = false;

  @override
  void initState() {
    _controller =
        AnimationController(duration: Duration(milliseconds: 1200), vsync: this);
    Tween tween = new Tween<double>(begin: 1, end: 0.5);
    Tween tween2 = new Tween<double>(begin: 0, end: 1);
    splashAnimation = tween.animate(
      CurvedAnimation(
parent: _controller,
curve: Curves.easeInCubic
      )
      );
    borderAnimation = tween2.animate(CurvedAnimation(
parent: _controller,
curve: Curves.easeInCubic
      ));
   // splashAnimation.addListener(() {
    //  setState(() {});
  //  });
    _controller.forward();
    emailTextController.text = "";
    passwordTextController.text = "";
    super.initState();
  }

  updateData() {
    String name = nameTextController.text;
    String email = emailTextController.text;
    LoginServer().uploadUserData(email, name).then((isComplete) {
      if (isComplete) {
        SnackBarDelegate.showSnackBar(
            context, "Registration complete", _scaffoldKey);
      } else {}
      setState(() {
        isLoading = false;
      });
    });
  }

  /*askUserName() {
    showDialog(
      context: context,
      builder: (BuildContext context) => new AlertDialog(
            title: new Text("Details"),
            content: Column(
              children: <Widget>[
                new Text("Enter your email to continue"),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 4),
                  decoration: BoxDecoration(
//                    color: Colors.black38,
                      borderRadius: BorderRadius.circular(75),
                      border: Border.all(color: Colors.black26)),
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 48),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: TextFormField(
                          controller: nameTextController,
                          style: TextStyle(letterSpacing: 1),
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Email',
                              hintStyle: TextStyle(
                                  fontSize: 16,
//                                color: Colors.white54,
                                  letterSpacing: 1)),
                          validator: Validator.validateEmail,
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (value) {
                            updateData();
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            actions: [
              FlatButton(
                child: new Text('Submit'),
                onPressed: () async {
                  updateData();

                  Navigator.of(context).pop();
                },
              )
            ],
          ),
    );
  }*/

  showError(error) {
    SnackBarDelegate.showSnackBar(context, error, _scaffoldKey);
  }

  signIn() {
    String email = emailTextController.text.toString().trim();
    String password = passwordTextController.text.toString().trim();
    LoginServer().handleSignIn(email, password).then((user) {
      if (user == "error") {
        showError(user);
      } else {
        print(user);
        User u = user;
        if (u != null) {
          UserSharedPreference.updateLoggedInUserDetails(
            email,
            email,
          );
          UserSharedPreference.getLoggedInUserDetails().then((userData) {
            print(userData);
            Navigator.pushReplacementNamed(context, "/chat");
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, widget) => Scaffold(
            key: _scaffoldKey,
            resizeToAvoidBottomPadding: true,
//      appBar: AppBar(
//        primary: true,
//        title: Text("Login"),
//        centerTitle: true,
//      ),
            body: Container(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(borderAnimation.value*40),
                                bottomRight: Radius.circular(borderAnimation.value*40),
                              ),
                              gradient: LinearGradient(
                                  colors: [
                                    Color(0xff1C6BFF),
                                    Color(0xffC523FF),
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight)),
                          height: size.height * splashAnimation.value,
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
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(75))),
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
                    SizedBox(
                      height: 60,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 4),
                      decoration: BoxDecoration(
//                    color: Colors.black38,
                          borderRadius: BorderRadius.circular(75),
                          border: Border.all(color: Colors.black26)),
                      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 48),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: TextFormField(
                              controller: emailTextController,
                              style: TextStyle(letterSpacing: 1),
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Email',
                                  hintStyle: TextStyle(
                                      fontSize: 16,
//                                color: Colors.white54,
                                      letterSpacing: 1)),
                              validator: Validator.validateEmail,
                              textInputAction: TextInputAction.next,
                              onFieldSubmitted: (value) {
                                FocusScope.of(context)
                                    .requestFocus(textSecondFocusNode);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 4),
                      decoration: BoxDecoration(
//                    color: Colors.black38,
                          borderRadius: BorderRadius.circular(75),
                          border: Border.all(color: Colors.black26)),
                      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 48),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: TextFormField(
                              controller: passwordTextController,
                              style: TextStyle(letterSpacing: 1),
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.emailAddress,
                              obscureText: true,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Password',
                                  hintStyle: TextStyle(
                                      fontSize: 16, letterSpacing: 1)),
                              validator: Validator.validatePassword,
                              focusNode: textSecondFocusNode,
                              textInputAction: TextInputAction.next,
                              onFieldSubmitted: (value) {
                                signIn();
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(32.0),
                    ),
                    (isLoading)
                        ? CircularProgressIndicator()
                        : Container(
                            width: MediaQuery.of(context).size.width,
                            margin: const EdgeInsets.symmetric(horizontal: 48),
                            alignment: Alignment.center,
                            child: (isLoading)
                                ? CircularProgressIndicator()
                                : InkWell(
                                    child: Material(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(75)),
                                      child: Container(
                                        width: size.width * 0.75,
                                        decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                                colors: [
                                                  Color(0xff1C6BFF),
                                                  Color(0xffC523FF),
                                                ],
                                                begin: Alignment.topLeft,
                                                end: Alignment.bottomRight),
                                            borderRadius:
                                                BorderRadius.circular(75)),
                                        child: Padding(
                                            padding: EdgeInsets.only(
                                                top: 16.0,
                                                bottom: 16.0,
                                                left: 16,
                                                right: 16),
                                            child: Text(
                                              'Sign in',
                                              textAlign: TextAlign.center,
                                              overflow: TextOverflow.ellipsis,
                                              textScaleFactor: 1,
                                              style: CustomTextStyles
                                                  .primaryButtonTextStyle,
                                            )),
                                      ),
                                    ),
                                    onTap: () {
                                      signIn();
//                                String email =
//                                    emailTextController.text.toString().trim();
//                                String password = passwordTextController.text
//                                    .toString()
//                                    .trim();
//
//                                setState(() {
//                                  isLoading = true;
//                                });
//                                LoginServer()
//                                    .handleSignIn(email, password)
//                                    .then((user) {
//                                  print(user);
//                                  User u = user;
//                                  if (u != null) {
//                                    UserSharedPreference
//                                        .updateLoggedInUserDetails(
//                                      email,
//                                      u.name,
//                                    );
//                                    UserSharedPreference
//                                            .getLoggedInUserDetails()
//                                        .then((userData) {
//                                      setState(() {
//                                        isLoading = false;
//                                      });
//                                      print(userData);
//                                      Navigator.pushReplacementNamed(
//                                          context, "/dashboard");
//                                    });
//                                  }
//                                }).catchError((error) {
//                                  print(error);
//                                  showCenterShortToast("Can't Login");
//                                  setState(() {
//                                    isLoading = false;
//                                  });
//                                });
                                    })),
                  ],
                ),
              ),
            ),
          ),
    );
  }

  void showCenterShortToast(message) {
//    Fluttertoast.showToast(
//        msg: message,
//        toastLength: Toast.LENGTH_SHORT,
//        gravity: ToastGravity.CENTER,
//        timeInSecForIos: 1);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    emailTextController.dispose();
    passwordTextController.dispose();
  }
}
