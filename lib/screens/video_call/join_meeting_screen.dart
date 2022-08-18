import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:smart_health_assistant/api/token_api.dart';
import 'package:smart_health_assistant/widgets/custom_snackbar.dart';
import './video_call_screen.dart';

class JoinMeetingScreen extends StatefulWidget {
  const JoinMeetingScreen({Key? key}) : super(key: key);

  @override
  State<JoinMeetingScreen> createState() => _JoinMeetingScreenState();
}

class _JoinMeetingScreenState extends State<JoinMeetingScreen> {
  final TextEditingController _channelController = TextEditingController();
  final TextEditingController _tokeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text(
          'Join meeting',
        ),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.7,
              child: TextFormField(
                controller: _channelController,
                decoration: const InputDecoration(hintText: 'Channel Name'),
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.7,
              child: TextFormField(
                controller: _tokeController,
                decoration: const InputDecoration(hintText: 'Token'),
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.5,
              child: MaterialButton(
                color: Colors.blue,
                onPressed: () async {
                  var tokenParams = {
                    "channelName": _channelController.text.trim(),
                    "isPublisher": false,
                  };
                  var tokenResponse = await getToken(tokenParams);

                  if (tokenResponse!.statusCode == 200) {
                    var meetingData = jsonDecode(tokenResponse.body);
                    // print(meetingData['uid']);
                    // print(meetingData['token']);
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => VideoCallScreen(
                          channelName: _channelController.text,
                          uid: meetingData['uid'],
                          token: meetingData['token']),
                    ));
                  } else {
                    customSnackBar(true, context, "Invalid token try again");
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'Join',
                      style: TextStyle(color: Colors.white),
                    ),
                    Icon(
                      Icons.arrow_right,
                      color: Colors.white,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
