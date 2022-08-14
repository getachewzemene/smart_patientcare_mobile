import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as rtc_local_view;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as rtc_remote_view;
import 'package:permission_handler/permission_handler.dart';
import 'package:smart_health_assistant/widgets/custom_snackbar.dart';

const appId = "19640a9b4858430593643c0f0d88aa04";
const token =
    "006cd57515713a342bca69b051e01ecc9a8IAACK/dFWrbXwBeXAwmRnMbeWkZ3LF6yrwUUYoK4GeAOF4CU4W8AAAAAEABiLYCECfn5YgEAAQAI+fli";

class VideoCallScreen extends StatefulWidget {
  const VideoCallScreen(
      {Key? key, required this.channelName, required this.tokenData})
      : super(key: key);
  final String channelName;
  final tokenData;
  @override
  State<VideoCallScreen> createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<VideoCallScreen> {
  int? _remoteUid;
  bool _localUserJoined = false;
  bool _remotUserJoined = false;
  late RtcEngine _engine;
  static final _users = <int>[];
  final _infoStrings = <String>[];
  bool muted = false;
  @override
  void initState() {
    super.initState();
    initialize();
  }

  @override
  void dispose() {
    // clear users
    _users.clear();
    // destroy sdk
    _engine.leaveChannel();
    _engine.destroy();
    super.dispose();
  }

  Future<void> initialize() async {
    // retrieve permissions
    await [Permission.microphone, Permission.camera].request();

    if (appId.isEmpty) {
      setState(() {
        _infoStrings.add(
          'APP_ID missing, please provide your APP_ID in settings.dart',
        );
        _infoStrings.add('Agora Engine is not starting');
      });
      return;
    }
    await _initAgoraRtcEngine();

    _addAgoraEventHandlers();
    await _engine.enableAudioVolumeIndication(200, 3, true);
    await _engine.joinChannel(
        widget.tokenData.token, widget.channelName, null, 0);
    await _engine.enableDualStreamMode(true);
    // await _engine.setParameters("""
    //      { "che.video.lowBitRateStreamParameter": {
    //        "width":160,"height":120,"frameRate":5,"bitRate":45
    //      }}
    //    """);
  }

  // Future<void> initAgora() async {
  //   //create the engine
  //   _engine = await RtcEngine.create(appId);
  //   await _engine.enableVideo();

  //   await _engine.enableDualStreamMode(true);
  //   await _engine.setParameters("""
  //        { "che.video.lowBitRateStreamParameter": {
  //          "width":160,"height":120,"frameRate":5,"bitRate":45
  //        }}
  //      """);
  //   _engine.setEventHandler(
  //     RtcEngineEventHandler(
  //       joinChannelSuccess: (String channel, int uid, int elapsed) {
  //         print("local user $uid joined");
  //         setState(() {
  //           _localUserJoined = true;
  //         });
  //       },
  //       userJoined: (int uid, int elapsed) {
  //         print("remote user $uid joined");
  //         setState(() {
  //           _remoteUid = uid;
  //         });
  //       },
  //       userOffline: (int uid, UserOfflineReason reason) {
  //         print("remote user $uid left channel");
  //         setState(() {

  //         });
  //       },
  //     ),
  //   );
  // }

  Future<void> _initAgoraRtcEngine() async {
    _engine = await RtcEngine.create(appId);
    await _engine.enableVideo();
  }

  void _addAgoraEventHandlers() {
    _engine.setEventHandler(RtcEngineEventHandler(
      activeSpeaker: (uid) {
        final String info = "Active speaker: $uid";
        print(info);
      },
      error: (code) {
        setState(() {
          final info = 'onError: $code';
          _infoStrings.add(info);
        });
      },
      joinChannelSuccess: (String channel, int uid, int elapsed) {
        setState(() {
          final info = 'onJoinChannel: $channel, uid: $uid';
          customSnackBar(false, context, info);
          _infoStrings.add(info);
          _localUserJoined = true;
        });
      },
      leaveChannel: (stats) {
        setState(() {
          _infoStrings.add('onLeaveChannel');
          customSnackBar(true, context, "user leaves");
          _users.clear();
          _localUserJoined = false;
        });
      },
      userJoined: (int uid, int elapsed) {
        setState(() {
          final info = 'userJoined: $uid';
          customSnackBar(true, context, info);
          _infoStrings.add(info);
          setState(() {
            _remoteUid = uid;
          });
          _engine.setRemoteDefaultVideoStreamType(VideoStreamType.High);
          _users.add(uid);
        });
        // if (_users.length >= 5) {
        //   print("Fallback to Low quality video stream");
        //   // _engine.setRemoteDefaultVideoStreamType(VideoStreamType.Low);
        // }
      },
      userOffline: (int uid, reason) {
        setState(() {
          final info = 'userOffline: $uid , reason: $reason';
          customSnackBar(true, context, info);
          _infoStrings.add(info);
          _users.remove(uid);
          _remoteUid = null;
          _remotUserJoined = false;
        });
        if (_users.length <= 3) {
          print("Go back to High quality video stream");
          _engine.setRemoteDefaultVideoStreamType(VideoStreamType.High);
        }
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Video Call'),
      ),
      body: Stack(
        children: [
          Center(
            child: _remoteVideo(),
          ),
          _toolbar(),
          Align(
            alignment: Alignment.topLeft,
            child: SizedBox(
              width: 100,
              height: 150,
              child: Center(
                child: _localUserJoined
                    ? const rtc_local_view.SurfaceView()
                    : const CircularProgressIndicator(
                        backgroundColor: Colors.red,
                        color: Colors.white,
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Display remote user's video
  Widget _remoteVideo() {
    if (_remoteUid != null) {
      return rtc_remote_view.SurfaceView(
        uid: _remoteUid!,
        channelId: widget.channelName,
      );
    } else {
      return const Text(
        'Please wait for remote user to join',
        textAlign: TextAlign.center,
      );
    }
  }

  List<Widget> _getRenderViews() {
    final List<Widget> list = [];
    list.add(const rtc_local_view.SurfaceView());
    if (_users.isNotEmpty) {
      setState(() {
        _remotUserJoined = true;
      });
      for (var uid in _users) {
        list.add(_remoteVideo());
      }
    }
    return list;
  }

  Widget _videoView(view) {
    return Column(
      children: [
        Container(child: view),
        const Text('Please wait for remote user to join',
            textAlign: TextAlign.center),
      ],
    );
  }

  // Video view row wrapper
  Widget _expandedVideoRow(List<Widget> views) {
    final wrappedViews = views.map<Widget>(_videoView).toList();
    return Wrap(
      children: wrappedViews,
    );
  }

  Widget _viewRows() {
    if (!_localUserJoined) {
      return const Center(
        child: CircularProgressIndicator(
          backgroundColor: Colors.red,
          color: Colors.white,
        ),
      );
    } else {
      final views = _getRenderViews();
      if (views.length == 1 && !_remotUserJoined) {
        return SizedBox(
          height: MediaQuery.of(context).size.height - 120,
          child: Column(
            children: <Widget>[_videoView(views[0])],
          ),
        );
      } else if (views.length == 2) {
        return SizedBox(
            height: MediaQuery.of(context).size.height - 120,
            child: Column(
              children: <Widget>[
                _expandedVideoRow([views[0]]),
                _expandedVideoRow([views[1]])
              ],
            ));
      } else if (views.length > 2 && views.length % 2 == 0) {
        return SizedBox(
          height: MediaQuery.of(context).size.height - 120,
          child: Column(
            children: [
              for (int i = 0; i < views.length; i = i + 2)
                _expandedVideoRow(
                  views.sublist(i, i + 2),
                ),
            ],
          ),
        );
      } else if (views.length > 2 && views.length % 2 != 0) {
        return SizedBox(
          height: MediaQuery.of(context).size.height - 120,
          child: Column(
            children: <Widget>[
              for (int i = 0; i < views.length; i = i + 2)
                i == (views.length - 1)
                    ? _expandedVideoRow(views.sublist(i, i + 1))
                    : _expandedVideoRow(views.sublist(i, i + 2)),
            ],
          ),
        );
      } else {
        return Container();
      }
    }
  }

  // Toolbar layout
  Widget _toolbar() {
    return Container(
      alignment: Alignment.bottomCenter,
      padding: const EdgeInsets.symmetric(vertical: 48),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RawMaterialButton(
            onPressed: _onToggleMute,
            child: Icon(
              muted ? Icons.mic_off : Icons.mic,
              color: muted ? Colors.white : Colors.blueAccent,
              size: 20.0,
            ),
            shape: const CircleBorder(),
            elevation: 2.0,
            fillColor: muted ? Colors.blueAccent : Colors.white,
            padding: const EdgeInsets.all(12.0),
          ),
          RawMaterialButton(
            onPressed: () => _onCallEnd(context),
            child: const Icon(
              Icons.call_end,
              color: Colors.white,
              size: 35.0,
            ),
            shape: const CircleBorder(),
            elevation: 2.0,
            fillColor: Colors.redAccent,
            padding: const EdgeInsets.all(15.0),
          ),
          RawMaterialButton(
            onPressed: _onSwitchCamera,
            child: const Icon(
              Icons.switch_camera,
              color: Colors.blueAccent,
              size: 20.0,
            ),
            shape: const CircleBorder(),
            elevation: 2.0,
            fillColor: Colors.white,
            padding: const EdgeInsets.all(12.0),
          )
        ],
      ),
    );
  }

  void _onCallEnd(BuildContext context) {
    Navigator.pop(context);
  }

  void _onToggleMute() {
    setState(() {
      muted = !muted;
    });
    _engine.muteLocalAudioStream(muted);
  }

  void _onSwitchCamera() {
    _engine.switchCamera();
  }
}
