import 'package:agora_uikit/agora_uikit.dart';

import "package:flutter/material.dart";

const appId = "cd57515713a342bca69b051e01ecc9a8";
const token =
    "006cd57515713a342bca69b051e01ecc9a8IAAEO5r3wLP352Z6qKZzuntZJfMfX6lprDSXDU0dGkHZDGmn4GYAAAAAEADYPDyUloW9YgEAAQCWhb1i";

class AgoraScreen extends StatefulWidget {
  const AgoraScreen({Key? key}) : super(key: key);

  @override
  State<AgoraScreen> createState() => _AgoraScreenState();
}

class _AgoraScreenState extends State<AgoraScreen> {
  AgoraClient? client;

  @override
  void initState() {
    initAgora();
    super.initState();
  }

  void initAgora() async {
    client = AgoraClient(
        agoraEventHandlers: AgoraRtcEventHandlers(
          leaveChannel: (state) => Navigator.pop(context),
          // connectionLost: () => ScaffoldMessenger.of(context)
          //         .showMaterialBanner(MaterialBanner(
          //             content: const Text("Connection Lost"),
          //             actions: [
          //           TextButton(
          //               onPressed: () => Navigator.pop(context),
          //               child: const Text("Cancel"))
          //         ])
          //         )
        ),
        agoraChannelData: AgoraChannelData(
            setCameraAutoFocusFaceModeEnabled: true,
            setBeautyEffectOptions: BeautyOptions(
              lighteningContrastLevel: LighteningContrastLevel.Normal,
              lighteningLevel: 0.8,
              smoothnessLevel: 0.4,
            )),
        agoraConnectionData: AgoraConnectionData(
            appId: appId, channelName: "meet2", tempToken: token),
        enabledPermission: [Permission.camera, Permission.microphone]);

    await client!.initialize();
    print("Number of users" + client!.users.length.toString());
  }

  @override
  void dispose() {
    client = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Agora Video Call"),
      ),
      body: client!.isInitialized
          ? Stack(
              children: [
                AgoraVideoViewer(
                  client: client!,
                  layoutType: Layout.floating,
                  enableHostControls: true,
                  showAVState: true,
                  showNumberOfUsers: true,
                  videoRenderMode: VideoRenderMode.Fit,
                  floatingLayoutContainerHeight: 300,
                  floatingLayoutContainerWidth: 200,
                  // disabledVideoWidget: Container(
                  //     height: MediaQuery.of(context).size.height,
                  //     width: MediaQuery.of(context).size.width,
                  //     color: Colors.black,
                  //     child: const Center(
                  //       child: Text("Getch",
                  //           style: TextStyle(fontSize: 25.0, color: Colors.white)),
                  //     )), // Add this to enable host controls
                ),
                if (client!.users.length == 1)
                  const Center(
                    child: Text("Wait Participants to join"),
                  ),
                AgoraVideoButtons(
                  autoHideButtonTime: 10,
                  autoHideButtons: true,
                  client: client!,
                ),
              ],
            )
          : const Center(
              child: CircularProgressIndicator(
                value: 1.0,
                color: Colors.redAccent,
                backgroundColor: Colors.blueGrey,
                strokeWidth: 6.0,
              ),
            ),
    );
  }
}
