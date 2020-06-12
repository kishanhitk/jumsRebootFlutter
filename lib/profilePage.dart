import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';
import 'package:jumsRebootFlutter/models/user.dart';
import 'package:flutter_full_pdf_viewer/flutter_full_pdf_viewer.dart';
import 'package:flutter_full_pdf_viewer/full_pdf_viewer_plugin.dart';
import 'package:flutter_full_pdf_viewer/full_pdf_viewer_scaffold.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share/share.dart';
import 'package:share_extend/share_extend.dart';

class ProfilePage extends StatefulWidget {
  final User user;
  final String uname;
  final String pass;

  ProfilePage({this.user, this.pass, this.uname});
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 200,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      widget.user.imgUrl,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(widget.user.name),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(widget.user.course),
                  )
                ],
              ),
            ],
          ),
          Expanded(
            flex: 2,
            child: ListView.builder(
              itemCount: widget.user.buttons.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text(widget.user.buttons[index].text),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              RaisedButton(
                                  onPressed: () {
                                    downloadAdmitCard(
                                      widget.user.buttons[index].link,
                                      widget.user.buttons[index].text,
                                    );
                                  },
                                  child: Text("Admit Card")),
                              RaisedButton(
                                  onPressed: () {
                                    downloadGradeCard(
                                      widget.user.buttons[index].link,
                                      widget.user.buttons[index].text,
                                    );
                                  },
                                  child: Text("Grade Card")),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Text("Notice"),
          Expanded(
            flex: 1,
            child: ListView.builder(
              itemCount: widget.user.notices.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(widget.user.notices[index]),
                );
              },
            ),
          ),
          isLoading ? CircularProgressIndicator() : Container(),
          // PDFViewerScaffold(path: )
        ],
      ),
    );
  }

  void downloadAdmitCard(String link, String text) async {
    String dir = (await getExternalStorageDirectory()).path;
    print(dir);
    bool exists = await File('$dir/${widget.uname}Admit$text.pdf').exists();
    setState(() {
      isLoading = true;
    });
    print(widget.pass);
    print(link);
    print(widget.uname);
    if (exists) {
      print("FIle Already exist");
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  PDFScreen(File('$dir/${widget.uname}Admit$text.pdf').path)));
    } else {
      Response response = await post(
        "https://ancient-waters-86273.herokuapp.com/admitCard",
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'uname': widget.uname,
          'pass': widget.pass,
          'url': link
        }),
      );
      if (response.statusCode == 200) {
        var bytes = response.bodyBytes;
        print(bytes);

        File file = new File('$dir/${widget.uname}Admit$text.pdf');
        await file.writeAsBytes(bytes);
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => PDFScreen(file.path)));
      } else {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: FaIcon(FontAwesomeIcons.solidWindowClose),
                title:
                    Text("Admit Card for this semester is not available yet."),
              );
            });
      }
    }
    setState(() {
      isLoading = false;
    });
  }

  void downloadGradeCard(String link, String text) async {
    String dir = (await getExternalStorageDirectory()).path;
    print(dir);
    bool exists = await File('$dir/${widget.uname}Grade$text.pdf').exists();
    setState(() {
      isLoading = true;
    });
    print(widget.pass);
    print(link);
    print(widget.uname);
    if (exists) {
      print("FIle Already exist");
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  PDFScreen(File('$dir/${widget.uname}Grade$text.pdf').path)));
    } else {
      Response response = await post(
        "https://ancient-waters-86273.herokuapp.com/gradeCard",
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'uname': widget.uname,
          'pass': widget.pass,
          'url': link
        }),
      );
      if (response.statusCode == 200) {
        var bytes = response.bodyBytes;
        print(bytes);

        File file = new File('$dir/${widget.uname}Grade$text.pdf');
        await file.writeAsBytes(bytes);
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => PDFScreen(file.path)));
      } else {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: FaIcon(FontAwesomeIcons.solidWindowClose),
                title:
                    Text("Grade Card for this semester is not available yet."),
              );
            });
      }
    }
    setState(() {
      isLoading = false;
    });
  }
}

class PDFScreen extends StatelessWidget {
  final String pathPDF;
  PDFScreen(this.pathPDF);

  @override
  Widget build(BuildContext context) {
    return PDFViewerScaffold(
        appBar: AppBar(
          title: Text("Document"),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.share),
              onPressed: () {
                ShareExtend.share(pathPDF, "file");
              },
            ),
          ],
        ),
        path: pathPDF);
  }
}
