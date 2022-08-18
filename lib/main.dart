import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_background/flutter_background.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:smart_health_assistant/providers/api_notifier.dart';
import 'package:smart_health_assistant/providers/auth_notifier.dart';
import 'package:smart_health_assistant/screens/doctor_screen.dart';
import 'package:smart_health_assistant/screens/welcome_screen.dart';
import 'package:smart_health_assistant/utils/user_utils.dart';
import '/providers/map_provider.dart';
import 'screens/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // if (defaultTargetPlatform == TargetPlatform.android) {
  //   AndroidGoogleMapsFlutter.useAndroidViewSurface = true;
  // }
  // if (WebRTC.platformIsDesktop) {
  //   debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  // } else if (WebRTC.platformIsAndroid) {
  //   WidgetsFlutterBinding.ensureInitialized();
  //   startForegroundService();
  // }
  runApp(const MainApp());
}

Future<bool> startForegroundService() async {
  const androidConfig = FlutterBackgroundAndroidConfig(
    notificationTitle: 'permission',
    notificationText: 'record permission',
    notificationImportance: AndroidNotificationImportance.Default,
    notificationIcon: AndroidResource(
        name: 'background_icon',
        defType: 'drawable'), // Default is ic_launcher from folder mipmap
  );
  await FlutterBackground.initialize(androidConfig: androidConfig);
  return FlutterBackground.enableBackgroundExecution();
}

class MainApp extends StatefulWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (context) => MapProvider(),
            ),
            ChangeNotifierProvider(
              create: (context) => ApiNotifier(),
            ),
            ChangeNotifierProvider(
              create: (context) => AuthNotifier(),
            ),
          ],
          child: MaterialApp(
              title: 'Smart Health Assistant',
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                primarySwatch: Colors.blue,
              ),
              home: FutureBuilder(
                  future: getCurrentUser(),
                  builder: ((context, _) {
                    if (currentUser != null) {
                      var data = jsonDecode(currentUser);
                      var role = data["role"];
                      // print(role);
                      if (role == "doctor") {
                        return DoctorScreen(id: data["id"]);
                      }
                      if (role == "geust") {
                        return const HomeScreen();
                      }
                    }
                    return const WelcomeScreen();
                  }))));
    });
  }
}
