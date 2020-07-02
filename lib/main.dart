import 'package:flutter/material.dart';
import 'package:jumsRebootFlutter/pages/loginPage/loginPage.dart';
import 'package:jumsRebootFlutter/models/semsterButtons.dart';
import 'package:jumsRebootFlutter/pages/dashboard/dashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'models/user.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
  runApp(MyApp(
      isLoggedIn: uname != null ? true : false,
      user: user,
      uname: uname,
      pass: pass));
}

class MyApp extends StatelessWidget {
  bool isLoggedIn = false;
  User user;
  String uname;
  String pass;
  MyApp({this.isLoggedIn, this.user, this.pass, this.uname});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "JUMS Reboot",
      theme: ThemeData(
        primaryColor: Color(
          0xff304ffe,
        ),
        fontFamily: "ProductSans",
        appBarTheme: AppBarTheme(
          color: Color(
            0xff304ffe,
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: isLoggedIn
          ? ProfilePage(
              user: user,
              uname: uname,
              pass: pass,
            )
          : LoginPage(),
    );
  }
}
