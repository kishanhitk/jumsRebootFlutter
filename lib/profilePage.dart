import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';
import 'package:jumsRebootFlutter/models/user.dart';
import 'package:flutter_full_pdf_viewer/flutter_full_pdf_viewer.dart';
import 'package:flutter_full_pdf_viewer/full_pdf_viewer_plugin.dart';
import 'package:flutter_full_pdf_viewer/full_pdf_viewer_scaffold.dart';
import 'package:jumsRebootFlutter/notificcations.dart';
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(CupertinoIcons.back,
                color: Theme.of(context).primaryColor),
            onPressed: () => Navigator.pop(context)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
              icon: FaIcon(Icons.notifications ?? FontAwesomeIcons.bell,
                  color: Theme.of(context).primaryColor),
              onPressed: () {
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: (context) => NotificationPage(
                              user: widget.user,
                            )));
              })
        ],
        title: Text(
          "Profile",
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
      ),
      body: Column(
        children: [
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 150,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Image.network(
                        widget.user.imgUrl,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Text(
                        widget.user.name,
                        style: TextStyle(fontSize: 25),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 3, bottom: 10),
                      child: Text(widget.user.course),
                    )
                  ],
                ),
              ],
            ),
          ),
          Divider(color: Colors.black),
          Expanded(
            flex: 2,
            child: ListView.builder(
              itemCount: widget.user.buttons.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 10),
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Theme.of(context).primaryColor, width: 0.5)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text(
                            widget.user.buttons[index].text,
                            style: TextStyle(fontSize: 22),
                          ),
                          Divider(
                            thickness: 1,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                RaisedButton(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: BorderSide.none,
                                    ),
                                    color: Theme.of(context).primaryColor,
                                    onPressed: () {
                                      downloadAdmitCard(
                                        widget.user.buttons[index].link,
                                        widget.user.buttons[index].text,
                                      );
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Text(
                                        "Admit Card",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 16),
                                      ),
                                    )),
                                RaisedButton(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: BorderSide.none,
                                    ),
                                    color: Theme.of(context).primaryColor,
                                    onPressed: () {
                                      downloadGradeCard(
                                        widget.user.buttons[index].link,
                                        widget.user.buttons[index].text,
                                      );
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Text(
                                        "Grade Card",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 16),
                                      ),
                                    )),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
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
          leading: IconButton(
              icon: Icon(CupertinoIcons.back,
                  color: Theme.of(context).primaryColor),
              onPressed: () => Navigator.pop(context)),
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          title: Text("Document",
              style: TextStyle(color: Theme.of(context).primaryColor)),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.share,
                color: Theme.of(context).primaryColor,
              ),
              onPressed: () {
                ShareExtend.share(pathPDF, "file");
              },
            ),
          ],
        ),
        path: pathPDF);
  }
}
