import 'package:flutter/material.dart';
import 'package:flutter_background/flutter_background.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:smart_health_assistant/providers/api_notifier.dart';
import 'package:smart_health_assistant/providers/auth_notifier.dart';
import 'package:smart_health_assistant/screens/welcome_screen.dart';
import '/providers/map_provider.dart';

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

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);
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
          home: const WelcomeScreen(),
        ),
      );
    });
  }
}
