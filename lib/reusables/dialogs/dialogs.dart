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
