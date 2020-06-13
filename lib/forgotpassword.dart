import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  String uname;
  String phone;
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  String newPasswordText = ' ';
  submit() async {
    setState(() {
      isLoading = true;
    });
    print(uname);
    print(phone);
    Response response = await post(
      "https://ancient-waters-86273.herokuapp.com/forgotPassword",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{'uname': uname, 'mobile': phone}),
    );
    if (response.statusCode == 200) {
      print(response.body);

      setState(() {
        newPasswordText = response.body;
      });
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                content: SelectableText(newPasswordText),
              ));
    } else {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                content: Text("Something went wrong!"),
              ));
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Reset Password"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          isLoading
              ? Center(child: CircularProgressIndicator())
              : Form(
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
                              return "Please enter your complete Roll No.";
                            } else
                              return null;
                          },
                          decoration: InputDecoration(
                              fillColor: Color(
                                0x11304ffe,
                              ),
                              labelText: "University Roll No.",
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              filled: true,
                              prefixIcon: Icon(
                                Icons.person,
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(50),
                              )),
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
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 10),
                        child: TextFormField(
                          validator: (value) {
                            if (value.length != 10)
                              return "Mobile number should be 10 digits.";
                            else
                              return null;
                          },
                          decoration: InputDecoration(
                              fillColor: Color(
                                0x11304ffe,
                              ),
                              filled: true,
                              labelText: "Password",
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              prefixIcon: Icon(
                                Icons.phone,
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(50),
                              )),
                          keyboardType: TextInputType.phone,
                          initialValue: "9521875124",
                          onChanged: (val) {
                            setState(() {
                              phone = val;
                            });
                            print(val);
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)),
                          color: Color(
                            0xff304ffe,
                          ),
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              print(uname);
                              print(phone);
                              submit();
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 110.0, vertical: 15),
                            child: Text(
                              "Reset Password",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      
                    ],
                  ),
                ),
        ],
      ),
    );
  }
}
