import 'package:flutter/material.dart';

class ForgotPassErrorDialog extends StatelessWidget {
  const ForgotPassErrorDialog({
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
            title: Text("⚫ You entered a wrong roll number."),
          ),
          ListTile(
            title: Text("⚫ You entered a wrong mobile number."),
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

