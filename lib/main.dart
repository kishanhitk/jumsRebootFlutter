import 'package:flutter/material.dart';
import 'package:jumsRebootFlutter/pages/splash/splashScreen.dart';
import 'package:jumsRebootFlutter/theme/themeData.dart';

main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "JUMS Reboot",
      theme: themeData,
      home: SplashScreen(),
    );
  }
}
