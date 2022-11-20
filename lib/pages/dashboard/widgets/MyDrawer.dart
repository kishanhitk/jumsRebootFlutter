import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jums_reboot/pages/examSchedulePage/exam_schedules_page.dart';
import 'package:jums_reboot/pages/loginPage/loginPage.dart';
import 'package:package_info/package_info.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  PackageInfo _packageInfo = PackageInfo(
    appName: 'JUMS Reboot',
    packageName: 'com.kishans.jumsRebootFlutter',
    version: 'v1.0',
    buildNumber: '1',
  );
  @override
  void initState() {
    super.initState();
    _initPackageInfo();
  }

  Future<void> _initPackageInfo() async {
    final PackageInfo info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      semanticLabel: "Menu",
      child: Column(
        children: [
          DrawerHeader(
            child: Image.asset('assets/logo_trans.png'),
          ),
          ListTile(
            onTap: () async {
              SharedPreferences _preferences =
                  await SharedPreferences.getInstance();
              _preferences.clear();
              Navigator.pushAndRemoveUntil(
                  context,
                  CupertinoPageRoute(builder: (context) => LoginPage()),
                  (Route<dynamic> route) => false);
            },
            title: Text(
              "Log out",
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (cotext) => ExamSchedule()));
            },
            title: Text("Exam Routines"),
          ),
          ListTile(
            onTap: () {
              launch(
                  'https://play.google.com/store/apps/details?id=com.kishans.jumsRebootFlutter');
            },
            title: Text("Rate us on Play Store"),
          ),
          AboutListTile(
            applicationIcon:
                SizedBox(height: 90, child: Image.asset('assets/logo.png')),
            applicationName: _packageInfo.appName,
            applicationVersion: _packageInfo.version,
            applicationLegalese: "By Kishan Kumar",
          ),
          ListTile(
            onTap: () {
              launch('https://github.com/kishanhitk/jumsRebootFlutter/issues');
            },
            title: Text("Report an issue"),
          ),
          ListTile(
            onTap: () {
              launch('https://github.com/kishanhitk/jumsRebootFlutter');
            },
            title: Text("Fork me on GitHub"),
          ),
          ListTile(
            onTap: () {
              Share.share("""
Hey!\n
Try out this awesome app for JUMS results.\n
JUMS Reboot-\n
https://play.google.com/store/apps/details?id=com.kishans.jumsRebootFlutter \n
It also sends notification about new result announcements.""",
                  subject: "JUMS Reboot is here.");
            },
            title: Text("Share app with friends"),
          ),
          Spacer(),
          Text(
            "Made with ❤️ by",
            textAlign: TextAlign.center,
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: TextButton(
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  backgroundColor: Color(0x11304ffe),
                ),
                onPressed: () {
                  launchUrl(Uri.https('kishanhitk.github.io'));
                },
                child: Text(
                  "Kishan Kumar",
                  style: TextStyle(fontSize: 15),
                )),
          )
        ],
      ),
    );
  }
}
