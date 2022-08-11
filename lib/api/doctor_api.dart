import "package:http/http.dart" as http;
import 'package:smart_health_assistant/models/doctor.dart';
import '/constants/api_url.dart';

String BASE_URL = getBaseUrl;
Map<String, String> requestHeaders = {
  'content-Type': "application/json",
  "accept": "application/json"
};
Future<List<Doctor>> getDoctorsData() async {
  var responnse = await http.get(
    Uri.parse(BASE_URL + "doctor/all?role=doctor"),
    headers: requestHeaders,
  );
  var doctotrData = doctorFromJson(responnse.body);
  return doctotrData;
  // print(responnse.body);
}
