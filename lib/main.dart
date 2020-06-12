import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:jumsRebootFlutter/loginPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}
