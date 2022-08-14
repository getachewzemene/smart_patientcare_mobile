import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_health_assistant/api/doctor_api.dart';
import 'package:smart_health_assistant/models/doctor.dart';
import '../api/auth_api.dart';

class AuthNotifier extends ChangeNotifier {
  // bool isLoading = false;
  bool isLogin = false;
  var isRegister = false;
  String errorMessage = "";
  var loggedInUser;
  List<Doctor> doctorList = [];
  Future<void> notifySignIn(Map<String, dynamic> loginCredintial) async {
    var response = await signIn(loginCredintial);
    if (response!.statusCode == 200) {
      await setLogIn(response.body);
      isLogin = true;
    } else {
      errorMessage = response.body;
      isLogin = false;
    }
    notifyListeners();
  }

  Future<void> notifySignUp(Map<String, dynamic> userData) async {
    var response = await signUp(userData);
    if (response!.statusCode == 200) {
      isRegister = true;
    } else {
      errorMessage = response.body;
      isRegister = false;
    }
    notifyListeners();
  }

  Future<void> setLogIn(var data) async {
    SharedPreferences loginPreferences = await SharedPreferences.getInstance();
    loginPreferences.setBool("isLogin", true);
    loginPreferences.setString("user", data);
    notifyListeners();
  }

  Future<bool> getLoggedUser() async {
    SharedPreferences? loginPreferences = await SharedPreferences.getInstance();
    doctorList = await getDoctorsData();
    loggedInUser = jsonDecode(loginPreferences.getString("user")!);
    // print(loggedInUser["id"]);
    isLogin = loginPreferences.getBool("isLogin")!;
    return isLogin;
  }

  Future<void> logout() async {
    SharedPreferences loginPreferences = await SharedPreferences.getInstance();
    loginPreferences.remove("user");
    loginPreferences.remove("isLogin");
    loginPreferences.clear();
    isLogin = false;
    notifyListeners();
  }
}
