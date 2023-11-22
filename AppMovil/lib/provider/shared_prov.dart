import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedProv extends ChangeNotifier {
  late SharedPreferences sharedPreferences;

  Future<SharedPreferences> getShared() async {
    sharedPreferences = (await SharedPreferences.getInstance());
    return sharedPreferences;
  }

  Future<void> setShared(String key, String value) async {
    sharedPreferences = (await SharedPreferences.getInstance());
    sharedPreferences.setString(key, value);
    notifyListeners();
  }

  Future<String> getVShared(String key) async {
    sharedPreferences = (await SharedPreferences.getInstance());
    return sharedPreferences.getString(key)!;
  }

}