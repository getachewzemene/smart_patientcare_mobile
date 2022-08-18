import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_health_assistant/providers/auth_notifier.dart';
import 'package:smart_health_assistant/screens/doctors_list_screen.dart';
import 'package:smart_health_assistant/screens/home_screen.dart';
import 'package:smart_health_assistant/screens/patient_history_screen.dart';
import 'package:smart_health_assistant/screens/welcome_screen.dart';

import '../screens/map.dart';

class SidebarMenu extends StatefulWidget {
  const SidebarMenu({Key? key}) : super(key: key);

  @override
  State<SidebarMenu> createState() => _SidebarMenuState();
}

class _SidebarMenuState extends State<SidebarMenu> {
  var currentUser;
  @override
  void initState() {
    super.initState();
  }

  Future<void> getCurrentUser() async {
    SharedPreferences currentUserPreferences =
        await SharedPreferences.getInstance();
    currentUser = jsonDecode(currentUserPreferences.getString("user")!);
    await Future.delayed(const Duration(seconds: 1), () {});
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getCurrentUser(),
        builder: ((context, _) => currentUser == null
            ? const CircularProgressIndicator()
            : SingleChildScrollView(
                // padding: const EdgeInsets.symmetric(vertical: 50.0),
                child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.person,
                            size: 60.0,
                          ),
                          radius: 70.0,
                        ),
                        const SizedBox(height: 16.0),
                        Padding(
                          padding: const EdgeInsets.only(left: 12.0),
                          child: Text(
                            "Hello, ${currentUser['email'] ?? "User"}",
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                        const SizedBox(height: 20.0),
                      ],
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomeScreen()));
                    },
                    leading:
                        const Icon(Icons.home, size: 20.0, color: Colors.white),
                    title: const Text("Home"),
                    textColor: Colors.white,
                    dense: true,
                  ),
                  ListTile(
                    onTap: () {},
                    leading: const Icon(Icons.key_sharp,
                        size: 20.0, color: Colors.white),
                    title: const Text("change password"),
                    textColor: Colors.white,
                    dense: true,

                    // padding: EdgeInsets.zero,
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const DoctorsListScreen()));
                    },
                    leading: const Icon(Icons.message,
                        size: 20.0, color: Colors.white),
                    title: const Text("View appointment"),
                    textColor: Colors.white,
                    dense: true,

                    // padding: EdgeInsets.zero,
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const DoctorsListScreen()));
                    },
                    leading: const Icon(Icons.medical_information,
                        size: 20.0, color: Colors.white),
                    title: const Text("Prescription"),
                    textColor: Colors.white,
                    dense: true,

                    // padding: EdgeInsets.zero,
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const DoctorsListScreen()));
                    },
                    leading: const Icon(Icons.person_add,
                        size: 20.0, color: Colors.white),
                    title: const Text("Add appointment"),
                    textColor: Colors.white,
                    dense: true,
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const PatientHistory()));
                    },
                    leading: const Icon(Icons.history,
                        size: 20.0, color: Colors.white),
                    title: const Text("History"),
                    textColor: Colors.white,
                    dense: true,

                    // padding: EdgeInsets.zero,
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const DoctorsListScreen()));
                    },
                    leading: const Icon(Icons.person,
                        size: 20.0, color: Colors.white),
                    title: const Text("Doctors"),
                    textColor: Colors.white,
                    dense: true,

                    // padding: EdgeInsets.zero,
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MapScreen()));
                    },
                    leading:
                        const Icon(Icons.map, size: 20.0, color: Colors.white),
                    title: const Text("Map"),
                    textColor: Colors.white,
                    dense: true,

                    // padding: EdgeInsets.zero,
                  ),
                  ListTile(
                    onTap: () {},
                    leading: const Icon(Icons.share,
                        size: 20.0, color: Colors.white),
                    title: const Text("Share"),
                    textColor: Colors.white,
                    dense: true,

                    // padding: EdgeInsets.zero,
                  ),
                  ListTile(
                    onTap: () {},
                    leading: const Icon(Icons.settings,
                        size: 20.0, color: Colors.white),
                    title: const Text("Settings"),
                    textColor: Colors.white,
                    dense: true,

                    // padding: EdgeInsets.zero,
                  ),
                  ListTile(
                    onTap: () {
                      logout(context);
                    },
                    leading: const Icon(Icons.logout,
                        size: 20.0, color: Colors.white),
                    title: const Text("Logout"),
                    textColor: Colors.white,
                    dense: true,

                    // padding: EdgeInsets.zero,
                  ),
                ],
              ))));
  }
}

void logout(context) async {
  var loginNotifier = Provider.of<AuthNotifier>(context, listen: false);
  await loginNotifier.logout();
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => const WelcomeScreen()));
}
