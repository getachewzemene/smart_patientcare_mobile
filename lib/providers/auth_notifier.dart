import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../api/auth_api.dart';

class AuthNotifier extends ChangeNotifier {
  // bool isLoading = false;
  bool isLogin = false;
  var isRegister = false;
  String errorMessage = "";
  Future<void> notifySignIn(Map<String, dynamic> loginCredintial) async {
    SharedPreferences loginPreferences = await SharedPreferences.getInstance();
    var response = await siggnIn(loginCredintial);
    if (response!.statusCode == 200) {
      var decodedResponse = jsonDecode(response.body);
      // print(decodedResponse["id"]);
      // print(decodedResponse["email"]);
      // print(decodedResponse["accessToken"]);
      // print(decodedResponse["role"]);
      // loginPreferences.setBool("isLogin", true);
      // loginPreferences.setString("id", value)
      isLogin = true;
    } else {
      errorMessage = response.body;
      isLogin = false;
    }
    notifyListeners();
  }

  Future<void> notifySignUp(Map<String, dynamic> userData) async {
    SharedPreferences loginPreferences = await SharedPreferences.getInstance();
    var response = await signUp(userData);
    if (response!.statusCode == 200) {
      // var decodedResponse = jsonDecode(response.body);
      // print(decodedResponse["id"]);
      // print(decodedResponse["email"]);
      // print(decodedResponse["accessToken"]);
      // print(decodedResponse["role"]);
      // loginPreferences.setBool("isLogin", true);
      // loginPreferences.setString("id", value)
      isRegister = true;
    } else {
      errorMessage = response.body;
      isRegister = false;
    }
    notifyListeners();
  }
}
