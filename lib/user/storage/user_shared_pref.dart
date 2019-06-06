import 'dart:async';

import 'package:hackathon_demo/user/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserSharedPreference {
  static const String _LOGGED_IN_USER_EMAIL_KEY = "logged_in_user_email";
  static const String _LOGGED_IN_USER_NAME_KEY = "logged_in_user_name";

  static void updateLoggedInUserEmail(String email) async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    prefs.setString(_LOGGED_IN_USER_EMAIL_KEY, email.toLowerCase());
    return;
  }

  static void updateLoggedInUserDetails(String email, String name) async {
//   email  password name role workshop mobilenum
    removeLoggedInUser();
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    prefs.setString(_LOGGED_IN_USER_EMAIL_KEY, email.toLowerCase());
    prefs.setString(_LOGGED_IN_USER_NAME_KEY, name);

    return;
  }

  static getLoggedInUserEmail() async {
    Completer completer = Completer();
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    String email = prefs.getString(_LOGGED_IN_USER_EMAIL_KEY);
    completer.complete(email);
    return completer.future;
  }

  static getLoggedInUserDetails() async {
    Completer completer = Completer();
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    String email = prefs.getString(_LOGGED_IN_USER_EMAIL_KEY);
    String name = prefs.getString(_LOGGED_IN_USER_NAME_KEY);
    User user = User(name, email);

    completer.complete(user);
    return completer.future;
  }

  static removeLoggedInUser() async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    prefs.remove(_LOGGED_IN_USER_EMAIL_KEY);
    prefs.remove(_LOGGED_IN_USER_NAME_KEY);
    return;
  }
}
