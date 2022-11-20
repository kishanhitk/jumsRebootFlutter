import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share_extend/share_extend.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PDFScreen extends StatelessWidget {
  final String pathPDF;
  PDFScreen(this.pathPDF);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        body: SfPdfViewer.file(File(pathPDF)));
  }
}
