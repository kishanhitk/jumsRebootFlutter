import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class MyLoading extends StatelessWidget {
  const MyLoading({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SpinKitSquareCircle(
          color: Theme.of(context).primaryColor,
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text("Loading..."),
        )
      ],
    ));
  }
}
