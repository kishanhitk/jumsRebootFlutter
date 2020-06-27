import 'dart:io';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:jumsRebootFlutter/forgotpassword.dart';
import 'package:jumsRebootFlutter/models/semsterButtons.dart';
import 'package:jumsRebootFlutter/models/user.dart';
import 'package:jumsRebootFlutter/profilePage.dart';
import 'package:jumsRebootFlutter/reusables/widgets.dart';
import 'package:jumsRebootFlutter/services/networking.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String uname = "001811601047";
  String pass = '158261ed';
  String url;
  bool isLoading = false;
  bool _isObscureText = true;
  void toggle() {
    setState(() {
      _isObscureText = !_isObscureText;
    });
  }

  final _formKey = GlobalKey<FormState>();

  String serverResponse;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white ?? Color(0xff323D4E),
      body: Center(
        child: Container(
          child: isLoading
              ? MyLoading()
              : SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/logo_trans.png'),
                      Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 10),
                              child: TextFormField(
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return "Enter your roll no.";
                                  } else
                                    return null;
                                },
                                decoration: InputDecoration(
                                    filled: true,
                                    hintText: "University Roll No.",
                                    fillColor: Color(
                                      0x11304ffe,
                                    ),
                                    prefixIcon: Icon(
                                      Icons.person,
                                    ),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(50),
                                    )),
                                keyboardType: TextInputType.number,
                                onChanged: (val) {
                                  setState(() {
                                    uname = val;
                                  });
                                  print(val);
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 10),
                              child: TextFormField(
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return "Enter your password";
                                  } else
                                    return null;
                                },
                                obscureText: _isObscureText,
                                decoration: InputDecoration(
                                    fillColor: Color(
                                      0x11304ffe,
                                    ),
                                    filled: true,
                                    hintText: "Password",
                                    prefixIcon: Icon(
                                      Icons.lock,
                                    ),
                                    suffixIcon: IconButton(
                                        icon: Icon(!_isObscureText
                                            ? Icons.visibility
                                            : Icons.visibility_off),
                                        onPressed: () {
                                          toggle();
                                        }),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(50),
                                    )),
                                onChanged: (val) {
                                  setState(() {
                                    pass = val;
                                  });
                                  print(val);
                                },
                              ),
                            ),
                            Hero(
                              tag: "FOR",
                              child: FlatButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ForgotPassword()));
                                },
                                child: Text(
                                  "Forgot Password?",
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: ButtonTheme(
                                minWidth:
                                    MediaQuery.of(context).size.width * 0.9,
                                child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50)),
                                  color: Color(
                                    0xff304ffe,
                                  ),
                                  onPressed: () async {
                                    if (_formKey.currentState.validate()) {
                                      setState(() {
                                        isLoading = true;
                                      });
                                      await Networking(pass, uname)
                                          .login(context);
                                      setState(() {
                                        isLoading = false;
                                      });
                                    }
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 15),
                                    child: Text(
                                      "Login",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
