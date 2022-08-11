import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:smart_health_assistant/constants/widget_params.dart';
import 'package:smart_health_assistant/screens/agora_screen.dart';
import 'package:smart_health_assistant/screens/appointment_screen.dart';
import 'package:smart_health_assistant/screens/doctors_list_screen.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int index = 0;
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  _goToScreen(index) {
    switch (index) {
      case 1:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const AgoraScreen()));
        break;
      case 2:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const DoctorsListScreen()));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      key: _bottomNavigationKey,
      index: 0,
      height: 60.0,
      items: <Widget>[
        Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(
                Icons.home,
                size: 25,
              ),
              Text("home", style: bootomText)
            ]),
        Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(
                Icons.video_call,
                size: 25,
              ),
              Text(
                "video-call",
                style: bootomText,
                softWrap: true,
              )
            ]),
        Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(
                Icons.person_add,
                size: 25,
              ),
              Text(
                "appointment",
                style: bootomText,
                softWrap: true,
              )
            ]),
        Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(
                Icons.person,
                size: 25,
              ),
              Text(
                "profile",
                style: bootomText,
                softWrap: true,
              )
            ]),
      ],
      color: Colors.white,
      buttonBackgroundColor: Colors.cyanAccent,
      backgroundColor: Colors.yellow,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 600),
      onTap: (index) {
        setState(() {
          index = index;
        });
        _goToScreen(index);
      },
      letIndexChange: (index) => true,
    );
  }
}
