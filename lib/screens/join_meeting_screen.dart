import 'package:flutter/material.dart';

class JoinMeetingScreen extends StatelessWidget {
  const JoinMeetingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Join Meeting"),
        centerTitle: true,
      ),
      body: const Center(
        child: Text("Join Meeting"),
      ),
    );
  }
}
