import 'package:flutter/material.dart';

class ForgotPassErrorDialog extends StatelessWidget {
  const ForgotPassErrorDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Something Went Wrong.\nPossible Reasons:-"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const ListTile(
            title: Text("⚫ You entered a wrong roll number."),
          ),
          const ListTile(
            title: Text("⚫ You entered a wrong mobile number."),
          ),
          const ListTile(
            title: Text("⚫ Original JUMS website is down."),
          ),
          const ListTile(
            title: Text("⚫ Our server is down."),
          ),
        ],
      ),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Dismiss"))
      ],
    );
  }
}

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class AdmitCardErrorDialog extends StatelessWidget {
  final String type;
  const AdmitCardErrorDialog({super.key, required this.type});

  // const AdmitCardErrorDialog({Key key, this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Something Went Wrong.\nPossible Reasons:-"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: Text("⚫ $type card for this semester is not available yet."),
          ),
          const ListTile(
            title: Text("⚫ Original JUMS Website is down."),
          ),
          const ListTile(
            title: Text(
                "⚫ Your JUMS password has changed since your last login.\nPlease logout and login with your new password."),
          ),
          const ListTile(
            title: Text("⚫ Our server is down."),
          ),
        ],
      ),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Dismiss"))
      ],
    );
  }
}
