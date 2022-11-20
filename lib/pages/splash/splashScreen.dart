import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:jums_reboot/models/semsterButtons.dart';
import 'package:jums_reboot/pages/dashboard/dashboard.dart';
import 'package:jums_reboot/pages/loginPage/loginPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  initState() {
    super.initState();
    checkAuthentication();
  }

  checkAuthentication() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var uname = prefs.getString('uname');
    if (uname != null) {
      String name = prefs.getString('name') ?? "";
      String course = prefs.getString('course') ?? "";
      String imgUrl = prefs.getString('imgUrl') ?? "";
      List<SemButtons> butons =
          SemButtons.decodeButtons(prefs.getString('buttons') ?? "");
    }
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) {
          return uname != null ? Dashboard() : LoginPage();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          height: 100,
          child: SpinKitSquareCircle(
            size: 60,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
    );
  }
}
