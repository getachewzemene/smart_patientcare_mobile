import "package:http/http.dart" as http;
import 'package:smart_health_assistant/models/doctor.dart';
import 'package:smart_health_assistant/models/doctor_by_id.dart';
import '/constants/api_url.dart';

String BASE_URL = getBaseUrl;
Map<String, String> requestHeaders = {
  'content-Type': "application/json",
  "accept": "application/json"
};
Future<http.Response> getDoctorsData() async {
  var response = await http.get(
    Uri.parse(BASE_URL + "doctor/all?role=doctor"),
    headers: requestHeaders,
  );
  return response;
}

Future<DoctorById?> getDoctorsDataById(String id) async {
  var response = await http.get(
    Uri.parse(BASE_URL + "doctor/doctor-by-id?id=$id"),
    headers: requestHeaders,
  );
  if (response.statusCode == 200) {
    var doctorData = doctorByIdFromJson(response.body);

    return doctorData;
  } else {
    return null;
  }
}
