import 'dart:convert';
import "package:http/http.dart" as http;
import '/constants/api_url.dart';

String BASE_URL = getBaseUrl;
Map<String, String> requestHeaders = {
  'content-Type': "application/json",
  "accept": "application/json"
};
Future<http.Response?> siggnIn(Map<String, dynamic> credintial) async {
  var response = await http.post(Uri.parse(BASE_URL + "login"),
      headers: requestHeaders, body: jsonEncode(credintial));
  print(response.body);
  print(response.statusCode);

  return response;
}

Future<http.Response?> signUp(Map<String, dynamic> userData) async {
  var response = await http.post(Uri.parse(BASE_URL + "register"),
      headers: requestHeaders, body: jsonEncode(userData));
  print(response.body);
  print(response.statusCode);
  return response;
}
