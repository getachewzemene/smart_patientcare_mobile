import 'dart:convert';

import 'package:shortid/shortid.dart';
import 'package:uuid/uuid.dart';
import "package:shared_preferences/shared_preferences.dart";

var uuid = const Uuid();
var currentUser;
Future<String> getUserId() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  String? userId;
  if (preferences.containsKey("userId")) {
    userId = preferences.getString("userId");
  } else {
    userId = uuid.v4();
    preferences.setString("userId", userId);
  }
  return userId!;
}

String generateId() {
  String id = shortid.generate();
  return id;
}

Future<String?> getCurrentUser() async {
  SharedPreferences userPreference = await SharedPreferences.getInstance();
  currentUser = userPreference.getString("user");
  // print(currentUser);
  return currentUser;
}
