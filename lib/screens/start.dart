import 'package:flutter/material.dart';
import 'package:tedx_sit/resources/navigation.dart';
import 'package:tedx_sit/resources/route.dart';

class Start extends StatefulWidget {
  @override
  _StartState createState() => _StartState();
}

class _StartState extends State<Start> {
  MyNavigation myNavigation = MyNavigation();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 2.5,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(16),
            child: ElevatedButton(
              onPressed: () {
                myNavigation.push(
                    screen: MyRoute.speakerScreen, context: context);
              },
              child: Text("Speakers Screen"),
            ),
          ),
          Container(
            padding: EdgeInsets.all(16),
            child: ElevatedButton(
              onPressed: () {
                myNavigation.push(
                    screen: MyRoute.teamMembers, context: context);
              },
              child: Text("Team Members"),
            ),
          ),
        ],
      ),
    );
  }
}
