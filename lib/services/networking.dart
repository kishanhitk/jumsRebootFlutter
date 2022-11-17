import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:jumsRebootFlutter/models/user.dart';
import 'package:jumsRebootFlutter/pages/pdfPage/pdfPage.dart';
import 'package:jumsRebootFlutter/pages/dashboard/dashboard.dart';
import 'package:jumsRebootFlutter/reusables/dialogs/dialogs.dart';
import 'package:jumsRebootFlutter/reusables/widgets.dart';
import 'package:jumsRebootFlutter/services/database.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Networking {
  final String uname;
  final String pass;

  Networking(this.pass, this.uname);

  Future<void> login(BuildContext context) async {
    String serverResponse;
    Response response = await post(
      "https://jums-reboot.onrender.com/",
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
          builder: (context) => Dashboard(),
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
      "https://jums-reboot.onrender.com/forgotPassword",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{'uname': uname, 'mobile': phone}),
    );
    if (response.statusCode == 200) {
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
        await get('https://jums-reboot.onrender.com/notices');
    var resBody = response.body;
    var temp = json.decode(resBody)['notices'];

    List<String> noticeList = List<String>.from(temp);
    prefs.setStringList('notices', noticeList);
    return noticeList;
  }

  Future<void> downloadAdmitCard(
      String link, String text, BuildContext context) async {
    String dir = (await getExternalStorageDirectory()).path;
    bool exists = await File('$dir/${uname}Admit$text.pdf').exists();

    if (exists) {
      Navigator.pop(context);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  PDFScreen(File('$dir/${uname}Admit$text.pdf').path)));
    } else {
      Response response = await post(
        "https://jums-reboot.onrender.com/admitCard",
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
            <String, String>{'uname': uname, 'pass': pass, 'url': link}),
      );
      if (response.statusCode == 200) {
        var bytes = response.bodyBytes;

        File file = new File('$dir/${uname}Admit$text.pdf');
        await file.writeAsBytes(bytes);
        Navigator.pop(context);

        Navigator.push(context,
            MaterialPageRoute(builder: (context) => PDFScreen(file.path)));
      } else {
        Navigator.pop(context);
        showDialog(
            context: context,
            builder: (context) {
              return AdmitCardErrorDialog(
                type: "Admit",
              );
            });
      }
    }
  }

  Future<void> downloadGradeCard(
      String link, String text, BuildContext context) async {
    String dir = (await getExternalStorageDirectory()).path;
    bool exists = await File('$dir/${uname}Grade$text.pdf').exists();

    if (exists) {
      Navigator.pop(context);

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  PDFScreen(File('$dir/${uname}Grade$text.pdf').path)));
    } else {
      Response response = await post(
        "https://jums-reboot.onrender.com/gradeCard",
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
            <String, String>{'uname': uname, 'pass': pass, 'url': link}),
      );
      if (response.statusCode == 200) {
        var bytes = response.bodyBytes;

        File file = new File('$dir/${uname}Grade$text.pdf');
        await file.writeAsBytes(bytes);
        Navigator.pop(context);

        Navigator.push(context,
            MaterialPageRoute(builder: (context) => PDFScreen(file.path)));
      } else {
        Navigator.pop(context);

        showDialog(
            context: context,
            builder: (context) {
              return AdmitCardErrorDialog(type: "Grade");
            });
      }
    }
  }
}
