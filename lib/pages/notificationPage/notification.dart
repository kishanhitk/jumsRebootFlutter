import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jums_reboot/reusables/widgets.dart';
import 'package:jums_reboot/services/networking.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  List<String> notices = [];
  var refreshKey = GlobalKey<RefreshIndicatorState>();

  Future checkNotices() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String> temp = prefs.getStringList('notices') ?? [];
    if (temp != null) {
      setState(() {
        notices = temp;
      });
    } else {
      var temp = await Networking("", "").getNotices(refreshKey);
      setState(() {
        notices = temp;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    checkNotices();
    WidgetsFlutterBinding.ensureInitialized();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color(0xff304ffe),
          onPressed: () async {
            var notices = await Networking("", "").getNotices(refreshKey);
            this.setState(() {
              notices = notices;
            });
            print("Notices Fetched");
          },
          child: Icon(Icons.refresh),
        ),
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(CupertinoIcons.back,
                  color: Theme.of(context).primaryColor),
              onPressed: () => Navigator.pop(context)),
          elevation: 0,
          centerTitle: true,
          backgroundColor: Colors.white,
          title: Text(
            "Notifications",
            style: TextStyle(
              color: Color(0xff304ffe),
              // fontFamily: "ProuctSans",
            ),
          ),
        ),
        body: notices.length != 0
            ? RefreshIndicator(
                key: refreshKey,
                onRefresh: () async {
                  var notices = await Networking("", "").getNotices(refreshKey);
                  this.setState(() {
                    notices = notices;
                  });
                  print("Notices Fetched");
                },
                child: ListView.builder(
                  itemCount: notices.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 3.0),
                          child: Card(
                            elevation: 3,
                            shadowColor: Colors.white,
                            child: Container(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15.0, vertical: 15),
                                child: Text(
                                  notices[index],
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontFamily: "ProductSans",
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              )
            : MyLoading());
  }
}
