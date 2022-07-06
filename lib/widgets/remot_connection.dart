import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:flutter_webrtc_wrapper/flutter_webrtc_wrapper.dart';

class RemoteConnecion extends StatefulWidget {
  final RTCVideoRenderer renderer;
  final Connection connection;
  const RemoteConnecion(
      {Key? key, required this.renderer, required this.connection})
      : super(key: key);

  @override
  State<RemoteConnecion> createState() => _RemoteConnecionState();
}

class _RemoteConnecionState extends State<RemoteConnecion> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        children: <Widget>[
          RTCVideoView(widget.renderer),
          Positioned(
            child: Container(
              padding: const EdgeInsets.all(5),
              color: const Color.fromRGBO(0, 0, 0, 0.7),
              child: const Text(
                "getch",
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
            ),
            bottom: 10.0,
            left: 10.0,
          ),
          Container(
            color: widget.connection.videoEnabled!
                ? Colors.transparent
                : Colors.black,
            child: Center(
                child: Text(
              widget.connection.videoEnabled! ? '' : widget.connection.name!,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 30.0,
              ),
            )),
          ),
          Positioned(
            child: Container(
              padding: const EdgeInsets.all(5),
              color: const Color.fromRGBO(0, 0, 0, 0.7),
              child: Row(
                children: <Widget>[
                  Icon(
                    widget.connection.videoEnabled!
                        ? Icons.videocam
                        : Icons.videocam_off,
                    color: Colors.white,
                  ),
                  const SizedBox(
                    width: 10,
                    height: 10,
                  ),
                  Icon(
                    widget.connection.audioEnabled! ? Icons.mic : Icons.mic_off,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
            bottom: 10.0,
            right: 10.0,
          )
        ],
      ),
    );
  }
}
