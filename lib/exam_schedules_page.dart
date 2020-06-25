import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class ExamSchedule extends StatefulWidget {
  @override
  _ExamScheduleState createState() => _ExamScheduleState();
}

class _ExamScheduleState extends State<ExamSchedule> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          "Exam Routines",
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
      ),
      body: Column(
        children: [
          ListTile(
            trailing: Icon(
              Icons.launch,
              color: Theme.of(context).primaryColor,
            ),
            subtitle: Text("Odd Sem 2020"),
            leading: Icon(FontAwesomeIcons.code),
            onTap: () => launch(
                "http://juadmission.jdvu.ac.in/jums_exam/Reports/2020/Odd/Engg_Odd_Sem_2020_Routine.pdf"),
            title: Text("Engineering"),
          ),
          Divider(),
          ListTile(
            trailing: Icon(
              Icons.launch,
              color: Theme.of(context).primaryColor,
            ),
            subtitle: Text("Odd Sem 2020"),
            leading: Icon(FontAwesomeIcons.artstation),
            onTap: () => launch(
                "http://juadmission.jdvu.ac.in/jums_exam/Reports/2020/Odd/Arts_Odd_Sem_2020_Routine.pdf"),
            title: Text("Arts"),
          ),
        ],
      ),
    );
  }
}
