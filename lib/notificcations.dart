import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:jumsRebootFlutter/models/user.dart';

class NotificationPage extends StatefulWidget {
  final User user;

  const NotificationPage({Key key, this.user}) : super(key: key);

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
        body: RefreshIndicator(
          key: refreshKey,
          onRefresh: getNotices,
          child: ListView.builder(
            itemCount: notices.length,
            itemBuilder: (context, index) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Theme.of(context).primaryColor, width: 0.2),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      notices[index],
                      style: TextStyle(
                        fontSize: 16,
                        color:
                            Colors.black ?? Color(0xff304ffe) ?? Colors.white,
                        fontFamily: "ProductSans",
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ));
  }
}
