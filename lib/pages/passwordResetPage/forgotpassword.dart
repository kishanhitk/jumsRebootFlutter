
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jumsRebootFlutter/reusables/widgets.dart';
import 'package:jumsRebootFlutter/services/networking.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        centerTitle: true,
        title: Text(
          "Reset Password",
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
      ),
      body: Center(
        child: isLoading
            ? MyLoading()
            : SingleChildScrollView(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 50.0),
                        child: Container(
                            height: 300,
                            child: Hero(
                                tag: "FOR",
                                child: Image.asset('assets/forgot.png'))),
                      ),
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
                                onChanged: (val) {
                                  setState(() {
                                    uname = val;
                                  });
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
                                    labelText: "Phone Number",
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
                                onChanged: (val) {
                                  setState(() {
                                    phone = val;
                                  });
                                },
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
                                      await Networking(uname, null)
                                          .resetPassword(uname, phone, context);
                                      setState(() {
                                        isLoading = false;
                                      });
                                    }
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 15.0),
                                    child: Text(
                                      "Reset Password",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                      
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
