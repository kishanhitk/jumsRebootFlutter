import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:jumsRebootFlutter/models/semsterButtons.dart';
import 'package:jumsRebootFlutter/models/user.dart';
import 'package:jumsRebootFlutter/profilePage.dart';
import 'package:jumsRebootFlutter/reusables/dialogs/dialogs.dart';
import 'package:jumsRebootFlutter/reusables/widgets.dart';
import 'package:jumsRebootFlutter/services/database.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Networking {
  final String uname;
  final String pass;

  Networking(this.pass, this.uname);

  Future<void> login(BuildContext context) async {
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
      Database().saveToDb(user, uname, pass);

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

  Future<void> resetPassword(
      String uname, String phone, BuildContext context) async {
    Response response = await post(
      "https://ancient-waters-86273.herokuapp.com/forgotPassword",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{'uname': uname, 'mobile': phone}),
    );
    if (response.statusCode == 200) {
      print(response.body);

      String newPasswordText = response.body;

      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: SelectableText(newPasswordText),
                content: Text("Long press password to copy."),
              ));
    } else {
      showDialog(
          context: context, builder: (context) => ForgotPassErrorDialog());
    }
  }

  Future<List<String>> getNotices(
      GlobalKey<RefreshIndicatorState> refreshKey) async {
    var prefs = await SharedPreferences.getInstance();
    refreshKey.currentState?.show();
    Response response =
        await get('https://ancient-waters-86273.herokuapp.com/notices');
    var resBody = response.body;
    var temp = json.decode(resBody)['notices'];

    List<String> noticeList = List<String>.from(temp);
    prefs.setStringList('notices', noticeList);
    return noticeList;
  }
}
