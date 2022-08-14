import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:flutter_webrtc_wrapper/flutter_webrtc_wrapper.dart';
import 'package:smart_health_assistant/constants/widget_params.dart';
import '/widgets/remot_connection.dart';
import '../widgets/control_panel.dart';
import '../utils/user_utils.dart';

import '../models/meeting.dart';

class VideoCallScreen extends StatefulWidget {
  final String? meetingId;
  final String? name;
  final Meeting? meeting;
  const VideoCallScreen(
      {Key? key,
      required this.meetingId,
      required this.name,
      required this.meeting})
      : super(key: key);
  @override
  State<VideoCallScreen> createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<VideoCallScreen> {
  final _localRenderer = RTCVideoRenderer();
  final Map<String, dynamic> mediaConstraints = {
    "audio": true, "video": true, //    {
    "mandatory": {
      "minWidth": '600', // Provide your own width, height and frame rate here
      "minHeight": '400',
      "minFrameRate": '30',
    },
    "facingMode": "user",
    "optional": [],
  };

  bool isConnectionFailed = false;
  WebRTCMeetingHelper? meetingHelper;
  bool isChatOpen = false;

  final PageController pageController = PageController();
  void startMeeting() async {
    // print("display name:" + widget.name!);
    final String userId = await getUserId();
    meetingHelper = WebRTCMeetingHelper(
        url: "http://10.161.84.64:4000",
        meetingId: widget.meeting!.id,
        userId: userId,
        name: widget.name);
    MediaStream _localStream =
        await navigator.mediaDevices.getUserMedia(mediaConstraints);
    _localRenderer.srcObject = _localStream;
    meetingHelper!.stream = _localStream;
    meetingHelper!.on("open", context, (ev, context) {
      setState(() {
        isConnectionFailed = false;
      });
    });
    meetingHelper!.on("connection ", context, (ev, context) {
      setState(() {
        isConnectionFailed = false;
      });
    });
    meetingHelper!.on("user-left", context, (ev, context) {
      setState(() {
        isConnectionFailed = false;
      });
    });
    meetingHelper!.on("video-toggle", context, (ev, context) {
      setState(() {});
    });
    meetingHelper!.on("audio-toggle", context, (ev, context) {
      setState(() {});
    });
    meetingHelper!.on("meeting-ended", context, (ev, context) {
      onMeetingEnd();
    });
    meetingHelper!.on("connection-setting-changed", context, (ev, context) {
      setState(() {
        isConnectionFailed = false;
      });
    });
    meetingHelper!.on("stream-changed", context, (ev, context) {
      setState(() {
        isConnectionFailed = false;
      });
    });
    setState(() {});
  }

  initRenderers() async {
    await _localRenderer.initialize();
  }

  @override
  void initState() {
    super.initState();
    initRenderers();
    startMeeting();
  }

  @override
  void deactivate() {
    super.deactivate();
    _localRenderer.dispose();
    if (meetingHelper != null) {
      meetingHelper!.destroy();
      meetingHelper = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: contentColor,
      body: _buildMeetingRoom(),
      bottomNavigationBar: ControlPanel(
        audioEnabled: isAudioEnabled(),
        videoEnabled: isVideoEnabled(),
        isConnectionFailed: isConnectionFailed,
        onAudioToggle: onAudioToggle,
        onVideoToggle: onVideoToggle,
        onReconnect: handleReconnect,
        onMeetingEnd: onMeetingEnd,
        onChatToggle: handleChatToggle,
        isChatOpen: isChatOpen,
      ),
    );
  }

  void onMeetingEnd() {
    if (meetingHelper != null) {
      meetingHelper!.endMeeting();
      meetingHelper = null;
      Navigator.pop(context);
    }
  }

  _buildMeetingRoom() {
    return Stack(children: [
      meetingHelper != null && meetingHelper!.connections.isNotEmpty
          ? GridView.count(
              crossAxisCount: meetingHelper!.connections.length < 3 ? 1 : 2,
              children: List.generate(
                  meetingHelper!.connections.length,
                  (index) => Padding(
                        padding: const EdgeInsets.all(1),
                        child: RemoteConnecion(
                          renderer: meetingHelper!.connections[index].renderer,
                          connection: meetingHelper!.connections[index],
                        ),
                      )))
          : const Center(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  "Waiting for participants to join",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey, fontSize: 24.0),
                ),
              ),
            ),
      Positioned(
          bottom: 10,
          right: 0,
          child: Container(
            width: 150.0,
            height: 200.0,
            decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(20.0)),
            child: RTCVideoView(_localRenderer),
          ))
    ]);
  }

  bool isAudioEnabled() {
    return meetingHelper != null ? meetingHelper!.audioEnabled! : false;
  }

  bool isVideoEnabled() {
    return meetingHelper != null ? meetingHelper!.videoEnabled! : false;
  }

  void onAudioToggle() {
    if (meetingHelper != null) {
      setState(() {
        meetingHelper!.toggleAudio();
      });
    }
  }

  void onVideoToggle() {
    if (meetingHelper != null) {
      setState(() {
        meetingHelper!.toggleVideo();
      });
    }
  }

  void handleReconnect() {
    if (meetingHelper != null) {
      meetingHelper!.reconnect();
    }
  }

  void handleChatToggle() {
    setState(() {
      isChatOpen = !isChatOpen;
      pageController.jumpToPage(isChatOpen ? 1 : 0);
    });
  }
}
