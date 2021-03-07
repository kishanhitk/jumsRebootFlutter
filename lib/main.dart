import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:jumsRebootFlutter/models/ad_state.dart';
import 'package:jumsRebootFlutter/pages/splash/splashScreen.dart';
import 'package:jumsRebootFlutter/theme/themeData.dart';
import 'package:provider/provider.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final initFuture = MobileAds.instance.initialize();
  final adState = AdState(initFuture);
  runApp(Provider.value(
    value: adState,
    builder: (ctx, child) => MyApp(),
  ));
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
