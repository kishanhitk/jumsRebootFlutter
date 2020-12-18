import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:jumsRebootFlutter/models/semsterButtons.dart';
import 'package:jumsRebootFlutter/models/user.dart';
import 'package:jumsRebootFlutter/pages/dashboard/dashboard.dart';
import 'package:jumsRebootFlutter/pages/loginPage/loginPage.dart';
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
    var pass;
    User user;
    if (uname != null) {
      pass = prefs.getString('pass');
      String name = prefs.getString('name');
      String course = prefs.getString('course');
      String imgUrl = prefs.getString('imgUrl');
      List<SemButtons> butons =
          SemButtons.decodeButtons(prefs.getString('buttons'));
      user = User(name: name, course: course, imgUrl: imgUrl, buttons: butons);
    }
    Navigator.of(context).push(
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
