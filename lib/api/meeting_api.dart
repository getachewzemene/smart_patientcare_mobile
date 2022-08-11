import 'dart:convert';
import "package:http/http.dart" as http;
import 'package:smart_health_assistant/constants/api_url.dart';
import 'package:smart_health_assistant/models/meeting.dart';
import '../utils/user_utils.dart';

String BASE_URL = getBaseUrl;
Future<http.Response?> startMeeting() async {
  String userId = await getUserId();
  Map<String, String> requestHeaders = {'content-Type': "application/json"};
  var response = await http.post(Uri.parse("$BASE_URL/start"),
      headers: requestHeaders,
      body: jsonEncode({'hostId': userId, "hostName": ''}));
  if (response.statusCode == 200) {
    return response;
  } else {
    return null;
  }
}

Future<Meeting> joinMeeting(String meetingId) async {
  var response = await http.get(Uri.parse("$BASE_URL/join/$meetingId"));
  print(response.statusCode);
  if (response.statusCode >= 200 && response.statusCode < 400) {
    var meetingdata = jsonDecode(response.body);
    Meeting meeting = Meeting.fromJson(meetingdata["data"]);
    print(meeting);
    return meeting;
  } else {
    throw UnsupportedError("Not a Valid Meetig");
  }
}

Future<bool> isMeetingPresent(String meetingId) async {
  var response = await http.get(Uri.parse('$BASE_URL/join/$meetingId'));
  if (response.statusCode == 200) {
    var meeting = json.decode(response.body);
    print(meeting['data']);
    return true;
  } else {
    print(response.statusCode);
    print(response.body);
    return false;
  }
}
