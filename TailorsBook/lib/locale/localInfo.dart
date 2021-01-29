import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalInfo extends ChangeNotifier {
  Locale _appLocale = Locale('en');
  bool loggedIn = false;

  fetchLogDetail() async {
    var prefs = await SharedPreferences.getInstance();
    if (prefs.getBool("logged_in") != null &&
        prefs.getBool("logged_in") == true)
      this.loggedIn = true;
    else
      this.loggedIn = false;
    return Null;
  }

  changeStatustoLogin() async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setBool("logged_in", true);
    notifyListeners();
  }

  changeStatustoLogout() async {
    var prefs = await SharedPreferences.getInstance();
    if (prefs.getBool("logged_in") != null) {
      prefs.remove("logged_in");
    }
    notifyListeners();
  }

  Locale get appLocal {
    if (this._appLocale == Locale('hi')) {
      return Locale('hi');
    } else {
      return Locale('en');
    }
  }

  fetchLocale() async {
    var prefs = await SharedPreferences.getInstance();
    if (prefs.getString('language_code') == null) {
      this._appLocale = Locale('en');
      return Null;
    }
    this._appLocale = Locale(prefs.getString('language_code'));
    return Null;
  }

  void changeLanguage(Locale type) async {
    var prefs = await SharedPreferences.getInstance();
    if (this._appLocale == type) {
      return;
    }
    if (type == Locale("hi")) {
      this._appLocale = Locale("hi");
      await prefs.setString('language_code', 'hi');
      await prefs.setString('countryCode', '');
      print(this._appLocale);
    } else {
      this._appLocale = Locale("en");
      await prefs.setString('language_code', 'en');
      await prefs.setString('countryCode', '');
      print(this._appLocale);
    }
    notifyListeners();
  }
}
