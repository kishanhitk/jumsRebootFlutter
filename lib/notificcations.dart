import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart';
import 'package:jumsRebootFlutter/models/user.dart';
import 'package:jumsRebootFlutter/reusables/widgets.dart';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  List<String> notices = [];
  var refreshKey = GlobalKey<RefreshIndicatorState>();

  Future getNotices() async {
    refreshKey.currentState?.show();
    Response response =
        await get('https://ancient-waters-86273.herokuapp.com/notices');
    var resBody = response.body;
    var temp = json.decode(resBody)['notices'];
    List<String> noticeList = List<String>.from(temp);
    setState(() {
      notices = noticeList;
    });
  }

  @override
  void initState() {
    super.initState();
    getNotices();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color(0xff304ffe),
          onPressed: getNotices,
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
                onRefresh: getNotices,
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
                                    color: Colors.black ??
                                        Color(0xff304ffe) ??
                                        Colors.white,
                                    fontFamily: "ProductSans",
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        // Divider(
                        //   indent: 30,
                        //   color: Theme.of(context).primaryColor,
                        //   thickness: 0.3,
                        // )
                      ],
                    );
                  },
                ),
              )
            : MyLoading());
  }
}
