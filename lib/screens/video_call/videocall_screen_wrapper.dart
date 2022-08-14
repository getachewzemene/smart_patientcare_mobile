import 'package:flutter/material.dart';
import 'package:smart_health_assistant/api/token_api.dart';
import 'package:smart_health_assistant/widgets/custom_snackbar.dart';
import './video_call_screen.dart';

class VideoCallScreenWrapper extends StatefulWidget {
  const VideoCallScreenWrapper({Key? key}) : super(key: key);

  @override
  State<VideoCallScreenWrapper> createState() => _VideoCallScreenWrapperState();
}

class _VideoCallScreenWrapperState extends State<VideoCallScreenWrapper> {
  final TextEditingController _channelController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text("Video Call"),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text(
                'Video Call',
                style: TextStyle(fontSize: 30),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                child: TextFormField(
                  controller: _channelController,
                  decoration: const InputDecoration(hintText: 'Channel Name'),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                child: MaterialButton(
                  color: Colors.blue,
                  onPressed: () async {
                    var tokenParams = {
                      "channelName": _channelController.text.trim(),
                      "isPublisher": "true",
                    };
                    var tokenResponse = await getToken(tokenParams);
                    if (tokenResponse!.statusCode == 200) {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => VideoCallScreen(
                            channelName: _channelController.text,
                            tokenData: tokenResponse.body),
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
      ),
    );
  }
}
