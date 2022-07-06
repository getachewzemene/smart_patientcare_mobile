import 'package:flutter/material.dart';
import 'package:flutter_background/flutter_background.dart';
import 'package:provider/provider.dart';
import '/providers/map_provider.dart';
import '../screens/home_screen.dart';

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
    return ChangeNotifierProvider(
      create: (context) => MapProvider(),
      child: MaterialApp(
        title: 'Smart Health Assistant',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
