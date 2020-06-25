import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';
import 'package:jumsRebootFlutter/loginPage.dart';
import 'package:jumsRebootFlutter/models/user.dart';
import 'package:flutter_full_pdf_viewer/flutter_full_pdf_viewer.dart';
import 'package:flutter_full_pdf_viewer/full_pdf_viewer_plugin.dart';
import 'package:flutter_full_pdf_viewer/full_pdf_viewer_scaffold.dart';
import 'package:jumsRebootFlutter/notificcations.dart';
import 'package:jumsRebootFlutter/reusables/widgets.dart';
import 'package:package_info/package_info.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share/share.dart';
import 'package:share_extend/share_extend.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfilePage extends StatefulWidget {
  final User user;
  final String uname;
  final String pass;

  ProfilePage({this.user, this.pass, this.uname});
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isLoading = true;
  final GlobalKey _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: MyDrawer(),
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
              icon: FaIcon(Icons.notifications ?? FontAwesomeIcons.bell,
                  color: Theme.of(context).primaryColor),
              onPressed: () {
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: (context) => NotificationPage()));
              })
        ],
        title: Text(
          "Profile",
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
      ),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              // color: Color(0x11304ffe),
              borderRadius: BorderRadius.circular(10),
              border:
                  Border.all(color: Theme.of(context).primaryColor, width: 0.1),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 150,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: CachedNetworkImage(
                        imageUrl: widget.user.imgUrl,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Text(
                        widget.user.name,
                        style: TextStyle(fontSize: 25),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 3, bottom: 10),
                      child: Text(widget.user.course),
                    )
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: ListView.builder(
              itemCount: widget.user.buttons.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 10),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0x10304ffe),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          color: Theme.of(context).primaryColor, width: 0.1),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Text(
                              widget.user.buttons[index].text,
                              style: TextStyle(fontSize: 22),
                            ),
                          ),
                          Divider(
                            thickness: 1,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Wrap(
                              alignment: WrapAlignment.spaceEvenly,
                              spacing: 30,
                              children: [
                                RaisedButton(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50.0),
                                      side: BorderSide.none,
                                    ),
                                    color: Theme.of(context).primaryColor,
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return Dialog(
                                              child: SizedBox(
                                                  height: 150,
                                                  width: 150,
                                                  child: MyLoading()));
                                        },
                                      );
                                      downloadAdmitCard(
                                        widget.user.buttons[index].link,
                                        widget.user.buttons[index].text,
                                      );
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Text(
                                        "Admit Card",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 16),
                                      ),
                                    )),
                                RaisedButton(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50.0),
                                      side: BorderSide.none,
                                    ),
                                    color: Theme.of(context).primaryColor,
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return Dialog(
                                              child: SizedBox(
                                                  height: 150,
                                                  width: 150,
                                                  child: MyLoading()));
                                        },
                                      );
                                      downloadGradeCard(
                                        widget.user.buttons[index].link,
                                        widget.user.buttons[index].text,
                                      );
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Text(
                                        "Grade Card",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 16),
                                      ),
                                    )),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // isLoading ? CircularProgressIndicator() : Container(),
          // PDFViewerScaffold(path: )
        ],
      ),
    );
  }

  void downloadAdmitCard(String link, String text) async {
    String dir = (await getExternalStorageDirectory()).path;
    print(dir);
    bool exists = await File('$dir/${widget.uname}Admit$text.pdf').exists();
    setState(() {
      isLoading = true;
    });
    print(widget.pass);
    print(link);
    print(widget.uname);
    if (exists) {
      print("FIle Already exist");
      Navigator.pop(context);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  PDFScreen(File('$dir/${widget.uname}Admit$text.pdf').path)));
    } else {
      Response response = await post(
        "https://ancient-waters-86273.herokuapp.com/admitCard",
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'uname': widget.uname,
          'pass': widget.pass,
          'url': link
        }),
      );
      if (response.statusCode == 200) {
        var bytes = response.bodyBytes;
        print(bytes);

        File file = new File('$dir/${widget.uname}Admit$text.pdf');
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
    setState(() {
      isLoading = false;
    });
  }

  void downloadGradeCard(String link, String text) async {
    String dir = (await getExternalStorageDirectory()).path;
    print(dir);
    bool exists = await File('$dir/${widget.uname}Grade$text.pdf').exists();
    setState(() {
      isLoading = true;
    });
    print(widget.pass);
    print(link);
    print(widget.uname);
    if (exists) {
      print("FIle Already exist");
      Navigator.pop(context);

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  PDFScreen(File('$dir/${widget.uname}Grade$text.pdf').path)));
    } else {
      Response response = await post(
        "https://ancient-waters-86273.herokuapp.com/gradeCard",
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'uname': widget.uname,
          'pass': widget.pass,
          'url': link
        }),
      );
      if (response.statusCode == 200) {
        var bytes = response.bodyBytes;
        print(bytes);

        File file = new File('$dir/${widget.uname}Grade$text.pdf');
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
    setState(() {
      isLoading = false;
    });
  }
}

class MyDrawer extends StatefulWidget {
  const MyDrawer({
    Key key,
  }) : super(key: key);

  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
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
              Navigator.push(context,
                  CupertinoPageRoute(builder: (context) => LoginPage()));
            },
            title: Text(
              "Log out",
            ),
          ),
          ListTile(
            onTap: () {
              launch(
                  'https://play.google.com/store/apps/details?id=com.kishans.jumsRebootFlutter');
            },
            title: Text("Exam Schedules"),
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
              Share.share(
                  "Hey!\nTry out this app for JUMS results.\nJUMS Reboot-\nhttps://play.google.com/store/apps/details?id=com.kishans.jumsRebootFlutter");
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
            child: FlatButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                color: Color(0x11304ffe),
                onPressed: () {
                  launch('https://www.linkedin.com/in/kishanju/');
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

class AdmitCardErrorDialog extends StatelessWidget {
  final String type;

  const AdmitCardErrorDialog({Key key, this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Something Went Wrong.\nPossible Reasons:-"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: Text("⚫ $this card for this semester is not available yet."),
          ),
          ListTile(
            title: Text("⚫ Original JUMS Website is down."),
          ),
          ListTile(
            title: Text(
                "⚫ Your JUMS password has changed since your last login.\nPlease logout and login with your new password."),
          ),
          ListTile(
            title: Text("⚫ Our server is down."),
          ),
        ],
      ),
      actions: [
        FlatButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("Dismiss"))
      ],
    );
  }
}

class PDFScreen extends StatelessWidget {
  final String pathPDF;
  PDFScreen(this.pathPDF);

  @override
  Widget build(BuildContext context) {
    return PDFViewerScaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(CupertinoIcons.back,
                  color: Theme.of(context).primaryColor),
              onPressed: () => Navigator.pop(context)),
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          title: Text("Document",
              style: TextStyle(color: Theme.of(context).primaryColor)),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.share,
                color: Theme.of(context).primaryColor,
              ),
              onPressed: () {
                ShareExtend.share(pathPDF, "file");
              },
            ),
          ],
        ),
        path: pathPDF);
  }
}
