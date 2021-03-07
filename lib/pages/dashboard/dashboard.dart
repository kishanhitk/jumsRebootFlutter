import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:jumsRebootFlutter/models/semsterButtons.dart';
import 'package:jumsRebootFlutter/models/user.dart';
import 'package:jumsRebootFlutter/pages/notificationPage/notification.dart';
import 'package:jumsRebootFlutter/pages/dashboard/widgets/MyDrawer.dart';
import 'package:jumsRebootFlutter/reusables/widgets.dart';
import 'package:jumsRebootFlutter/services/networking.dart';
import 'package:jumsRebootFlutter/services/updater.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  var pass;
  var uname;
  User user;
  bool isLoading = true;
  final GlobalKey _scaffoldKey = GlobalKey<ScaffoldState>();
  bool updateAvailable = false;
  bool updateDownloaded = false;
  @override
  void initState() {
    super.initState();
    // Updater.performInAppUpdate();
    performInAppUpdate();
    getDataFromDB();
  }

  Future<void> performInAppUpdate() async {
    print("CHECKING FOR UPDATES");
    AppUpdateInfo updateInfo;

    try {
      updateInfo = await InAppUpdate.checkForUpdate();
    } catch (e) {
      print(e);
    }
    print("UPDATE INFO IS $updateInfo");
    if (updateInfo.updateAvailable) {
      if (updateInfo.flexibleUpdateAllowed) {
        this.setState(() {
          updateAvailable = true;
        });
      } else if (updateInfo.immediateUpdateAllowed) {
        await InAppUpdate.performImmediateUpdate();
      }
    } else {
      print("No Update available");
    }
  }

  getDataFromDB() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var unameFromDB = prefs.getString('uname');
    var passFromDB;
    User userFromDB;
    if (unameFromDB != null) {
      passFromDB = prefs.getString('pass');
      String name = prefs.getString('name');
      String course = prefs.getString('course');
      String imgUrl = prefs.getString('imgUrl');
      List<SemButtons> buttons =
          SemButtons.decodeButtons(prefs.getString('buttons'));
      userFromDB =
          User(name: name, course: course, imgUrl: imgUrl, buttons: buttons);
      this.setState(() {
        pass = passFromDB;
        uname = unameFromDB;
        user = userFromDB;
      });
    }
  }

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
          "Dashboard",
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
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 150,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: CachedNetworkImage(
                          imageUrl: user.imgUrl,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                ),
                Flexible(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: Text(
                          user.name,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 25),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 3, bottom: 10),
                        child: Text(
                          user.course,
                          textAlign: TextAlign.center,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: ListView.builder(
              itemCount: user.buttons.length,
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
                              user.buttons[index].text,
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
                              spacing: 20,
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
                                          return AlertDialog(
                                              contentPadding: EdgeInsets.all(0),
                                              titlePadding:
                                                  EdgeInsets.only(top: 30),
                                              title: Center(
                                                child: Text(
                                                    "Downloading Admit Card."),
                                              ),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(8)),
                                              content: SizedBox(
                                                  height: 400,
                                                  child: MyLoading()));
                                        },
                                      );
                                      Networking(pass, uname).downloadAdmitCard(
                                          user.buttons[index].link,
                                          user.buttons[index].text,
                                          context);
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
                                          return AlertDialog(
                                              contentPadding: EdgeInsets.all(0),
                                              titlePadding:
                                                  EdgeInsets.only(top: 30),
                                              title: Center(
                                                child: Text(
                                                    "Downloading Grade Card."),
                                              ),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(8)),
                                              content: SingleChildScrollView(
                                                  child: MyLoading()));
                                        },
                                      );
                                      Networking(pass, uname).downloadGradeCard(
                                          user.buttons[index].link,
                                          user.buttons[index].text,
                                          context);
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
          updateAvailable
              ? Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 15,
                  ),
                  child: Container(
                    height: 45,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        updateDownloaded
                            ? Text("App Updated Successfully")
                            : Text("New version available"),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 6.0,
                            horizontal: 3,
                          ),
                          child: FlatButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            color: Theme.of(context).primaryColor,
                            onPressed: !updateDownloaded
                                ? () async {
                                    await InAppUpdate.startFlexibleUpdate()
                                        .then(
                                      (_) {
                                        this.setState(() {
                                          updateDownloaded = true;
                                        });
                                        // InAppUpdate.completeFlexibleUpdate();
                                      },
                                    );
                                  }
                                : () async {
                                    await InAppUpdate.completeFlexibleUpdate();
                                  },
                            child: Text(
                              updateDownloaded ? "Restart App" : "Update Now!",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              : Container()
          // isLoading ? CircularProgressIndicator() : Container(),
          // PDFViewerScaffold(path: )
        ],
      ),
    );
  }
}
