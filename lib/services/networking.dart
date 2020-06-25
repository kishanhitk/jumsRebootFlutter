import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:jumsRebootFlutter/models/semsterButtons.dart';
import 'package:jumsRebootFlutter/models/user.dart';
import 'package:jumsRebootFlutter/profilePage.dart';
import 'package:jumsRebootFlutter/reusables/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Networking {
  final String uname;
  final String pass;

  Networking(this.pass, this.uname);
  something() {
    print("THIS IS WORKING NOW.");
  }

  void saveToDb(User user) async {
    final String encodedData = SemButtons.encodeButtons(user.buttons);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('uname', uname);
    prefs.setString('pass', pass);
    prefs.setString('buttons', encodedData);
    prefs.setString('name', user.name);
    prefs.setString('course', user.course);
    prefs.setString('imgUrl', user.imgUrl);
  }

  submit(BuildContext context) async {
    print(uname);
    print(pass);
    String serverResponse;
    Response response = await post(
      "https://ancient-waters-86273.herokuapp.com/",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{'uname': uname, 'pass': pass}),
    );
    if (response.statusCode == 200) {
      serverResponse = response.body;

      var user = User.fromJson(json.decode(serverResponse));
      saveToDb(user);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ProfilePage(
            user: user,
            pass: pass,
            uname: uname,
          ),
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => LoginErrorDialog(),
      );
    }
  }
}
