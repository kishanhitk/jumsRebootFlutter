import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jumsRebootFlutter/models/user.dart';

class NotificationPage extends StatelessWidget {
  final User user;

  const NotificationPage({Key key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: ListView.builder(
        itemCount: user.notices.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
            child: Card(
                color: Color(0xff304ffe) ?? Color(0xff3d5afe),
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    user.notices[index],
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontFamily: "ProductSans",
                    ),
                  ),
                )),
          );
        },
      ),
    );
  }
}
