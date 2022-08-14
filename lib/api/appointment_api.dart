import 'dart:convert';
import "package:http/http.dart" as http;
import 'package:smart_health_assistant/constants/api_url.dart';

String BASE_URL = getBaseUrl;
Map<String, String> requestHeaders = {'content-Type': "application/json"};
Future<http.Response> createAppointment(
    Map<String, dynamic> appointmentData) async {
  var response = await http.post(Uri.parse(BASE_URL + "appointment/add"),
      headers: requestHeaders, body: jsonEncode(appointmentData));

  return response;
}
