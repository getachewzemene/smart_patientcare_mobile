import 'package:flutter/material.dart';
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
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          VideoCallScreen(channelName: _channelController.text),
                    ));
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
