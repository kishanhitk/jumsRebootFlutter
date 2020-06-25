import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class MyLoading extends StatelessWidget {
  final List<String> facts = [
    "The first computer was invented in the 1940s.",
    "Space smells like seared steak.",
    "The unicorn is the national animal of Scotland.",
    "Bees sometimes sting other bees.",
    "Jadavpur University's emblem is designed by Nandalal Basu",
    "The total weight of ants on earth once equaled the total weight of people.",
    "E is the most common letter and appears in 11 percent of all english words.",
    "A dozen bodies were once found in Benjamin Franklin's basement.",
    "The healthiest place in the world is in Panama.",
    "A pharaoh once lathered his slaves in honey to keep bugs away from him.",
    "Abraham Lincoln's bodyguard left his post at Ford's Theatre to go for a drink.",
    "Playing the accordion was once required for teachers in North Korea.",
    "Plastic Easter eggs and plastic Easter grass were invented by a man who holds more patents than Thomas Edison.",
    "Water makes different pouring sounds depending on its temperature.",
    "Humans are just one of the estimated 8.7 million species on Earth.",
    "Bee hummingbirds are so small they get mistaken for insects.",
    "The first iPhone wasn't made by Apple.",
    "Napoleon was once attacked by thousands of rabbits.",
    "The Comic Sans font came from an actual comic book.",
    "Jadavpur University is ranked 5 by NIRF among all the universities in India.",
    "Octopuses lay 56,000 eggs at a time",
    "That tiny pocket in jeans was designed to store pocket watches"
  ];

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 100,
          child: SpinKitSquareCircle(
            size: 60,
            color: Theme.of(context).primaryColor,
          ),
        ),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                "While it loads, here is a quick fact.",
                style: TextStyle(color: Colors.grey),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Text(
                "${facts[Random().nextInt(facts.length)]}",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20),
              ),
            )
          ],
        )
      ],
    ));
  }
}

class LoginErrorDialog extends StatelessWidget {
  const LoginErrorDialog({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Something Went Wrong.\nPossible Reasons:-"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: Text(
                "⚫ You entered a wrong roll number and password combination. Try resetting the password."),
          ),
          ListTile(
            title: Text("⚫ Original JUMS website is down."),
          ),
          ListTile(
            title: Text("⚫ Our server is down."),
          ),
        ],
      ),
      actions: [
        FlatButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("Dismiss"))
      ],
    );
  }
}
