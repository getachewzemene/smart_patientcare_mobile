import "package:http/http.dart" as http;
import 'package:smart_health_assistant/constants/api_url.dart';
import 'package:smart_health_assistant/models/disease.dart';

import '../models/disease.dart';

String BASE_URL = getBaseUrl;
Map<String, String> requestHeaders = {'content-Type': "application/json"};
Future<Disease?> checkDisease(var symptomData) async {
  var responnse = await http.get(
      Uri.parse(BASE_URL + "predict-disease?symptoms=$symptomData"),
      headers: requestHeaders);
  if (responnse.statusCode == 200) {
    Disease disease = diseaseFromJson(responnse.body);

    // print(disease.diseaseName);
    // print(disease.precuation);
    return disease;
  } else {
    return null;
  }
}
