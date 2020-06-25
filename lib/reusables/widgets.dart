import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class MyLoading extends StatelessWidget {
  const MyLoading({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SpinKitSquareCircle(
          color: Theme.of(context).primaryColor,
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text("Loading..."),
        )
      ],
    ));
  }
}
class LoginErrorDialog extends StatelessWidget {
  const LoginErrorDialog({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Something Went Wrong.\nPossible Reasons:-"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: Text(
                "⚫ You entered a wrong roll number and password combination. Try resetting the password."),
          ),
          ListTile(
            title: Text("⚫ Original JUMS website is down."),
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
