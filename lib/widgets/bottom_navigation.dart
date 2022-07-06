import 'package:flutter/material.dart';
import '/screens/meeting_screen.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) async {
    setState(() {
      _selectedIndex = index;
    });
    switch (_selectedIndex) {
      case 0:
        break;
      case 1:
        Navigator.push(context,
            MaterialPageRoute(builder: ((context) => const MeetingScreen())));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        showSelectedLabels: true,
        showUnselectedLabels: true,
        //fixedColor: Colors.redAccent,
        // backgroundColor: Colors.blue,
        // unselectedItemColor: Colors.white,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home",
              backgroundColor: Color.fromARGB(255, 204, 189, 57)),
          // BottomNavigationBarItem(
          //     icon: Icon(Icons.search),
          //     label: 'search'.tr,
          //     backgroundColor: Colors.red),
          BottomNavigationBarItem(
            icon: Icon(Icons.video_camera_back),
            label: 'Meeting',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.help_outline),
            label: 'Aboout',
          ),
        ],
        type: BottomNavigationBarType.shifting,
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.red,
        unselectedLabelStyle: const TextStyle(color: Colors.black),
        iconSize: 20,
        onTap: _onItemTapped,
        elevation: 1);
  }
}
