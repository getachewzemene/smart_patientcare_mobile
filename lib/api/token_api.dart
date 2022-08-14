import 'dart:convert';
import "package:http/http.dart" as http;
import '/constants/api_url.dart';

String BASE_URL = getBaseUrl;
Map<String, String> requestHeaders = {
  'content-Type': "application/json",
  "accept": "application/json"
};
Future<http.Response?> getToken(Map<String, dynamic> tokenData) async {
  var response = await http.post(Uri.parse(BASE_URL + "/rtc-token"),
      headers: requestHeaders, body: jsonEncode(tokenData));
  print(response.body);
  // print(response.statusCode);

  return response;
}
