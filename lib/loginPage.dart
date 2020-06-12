import 'dart:io';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:jumsRebootFlutter/models/user.dart';
import 'package:jumsRebootFlutter/profilePage.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String uname = "001811601047";
  String pass = '158261ed';
  String url;
  bool isLoading = false;

  String serverResponse;
  submit() async {
    setState(() {
      isLoading = true;
    });
    print(uname);
    print(pass);
    Response response = await post(
      "https://ancient-waters-86273.herokuapp.com/",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{'uname': uname, 'pass': pass}),
    );
    setState(() {
      serverResponse = response.body;
    });
    var b = User.fromJson(json.decode(serverResponse));
    print(b.buttons);
    setState(() {
      isLoading = false;
    });
    Navigator.push(
        context,
        CupertinoPageRoute(
            builder: (context) => ProfilePage(
                  user: b,
                  pass: pass,
                  uname: uname,
                )));
    // print(a['name']);
    // print(json.decode(serverResponse));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("JUMS Reboot"),
      ),
      body: Container(
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : Form(
                child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      initialValue: "001811601047",
                      onChanged: (val) {
                        setState(() {
                          uname = val;
                        });
                        print(val);
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      initialValue: "158261ed",
                      onChanged: (val) {
                        setState(() {
                          pass = val;
                        });
                        print(val);
                      },
                    ),
                  ),
                  RaisedButton(
                    onPressed: submit,
                    child: Text("Login"),
                  )
                ],
              )),
      ),
    );
  }
}
