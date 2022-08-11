import 'dart:convert';
import "package:http/http.dart" as http;
import 'package:smart_health_assistant/constants/api_url.dart';
import 'package:smart_health_assistant/models/meeting.dart';
import '../utils/user_utils.dart';

String BASE_URL = getBaseUrl;
Map<String, String> requestHeaders = {'content-Type': "application/json"};
Future<String> createAppointment(Map<String, dynamic> appointmentData) async {
  var responnse = await http.post(Uri.parse(BASE_URL + "appointment/add"),
      headers: requestHeaders, body: jsonEncode(appointmentData));

  return responnse.body;
}
