import "package:http/http.dart" as http;

import '../models/Patient_history.dart';
import '/constants/api_url.dart';

String BASE_URL = getBaseUrl;
Map<String, String> requestHeaders = {
  'content-Type': "application/json",
  "accept": "application/json"
};
Future<PatientHistory?> getPatientHistoryById(var id) async {
  PatientHistory? history;
  var response = await http.get(
    Uri.parse(BASE_URL + "doctor/patient-history/by-id?id=$id"),
    headers: requestHeaders,
  );
  // print(response.body);
  if (response.statusCode == 200) {
    history = patientHistoryFromJson(response.body);
  } else {
    history = null;
  }

  return history;
}
