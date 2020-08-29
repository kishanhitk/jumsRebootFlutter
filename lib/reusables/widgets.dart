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
    "Nintendo trademarked the phrase “It’s on like Donkey Kong” in 2010.",
    "In 2006, a Coca-Cola employee offered to sell Coca-Cola secrets to Pepsi. Pepsi responded by notifying Coca-Cola.",
    "If a Polar Bear and a Grizzly Bear mate, their offspring is called a “Pizzy Bear”.",
    "The famous line in Titanic from Leonardo DiCaprio, “I’m king of the world!” was improvised.",
    "A single strand of Spaghetti is called a “Spaghetto”.",
    "There is actually a difference between coffins and caskets – coffins are typically tapered and six-sided, while caskets are rectangular.",
    "To leave a party without telling anyone is called in English, a “French Exit”. In French, it’s called a “partir à l’anglaise”, to leave like the English.",
    "The first movie ever to put out a motion-picture soundtrack was Snow White and the Seven Dwarves.",
    "If you point your car keys to your head, it increases the remote’s signal range.",
    "In order to protect themselves from poachers, African Elephants have been evolving without tusks, which unfortunately also hurts their species.",
    "At birth, a baby panda is smaller than a mouse.",
    "Iceland does not have a railway system.",
    "In order to keep Nazis away, a Polish doctor faked a typhus outbreak. This strategy staved 8,000 people.",
    "An 11-year-old girl proposed the name for Pluto after the Roman god of the Underworld.",
    "The voice actor of SpongeBob and the voice actor of Karen, Plankton’s computer wife, have been married since 1995.",
    "75% of the world’s diet is produced from just 12 plant and five different animal species.",
    "Violin bows are commonly made from horse hair.",
    "In Svalbard, a remote Norwegian island, it is illegal to die."
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
