import 'package:flutter/material.dart';
import 'package:tedx_sit/resources/route.dart';
import 'package:tedx_sit/screens/contact_us_screen.dart';
import 'package:tedx_sit/screens/events.dart';
import 'package:tedx_sit/screens/speaker_screen.dart';
import 'package:tedx_sit/screens/sponsors.dart';
import 'package:tedx_sit/screens/start.dart';
import 'package:tedx_sit/screens/team_members.dart';

class MyRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case MyRoute.start:
        return MaterialPageRoute(builder: (_) => Start());

      case MyRoute.speakerScreen:
        return MaterialPageRoute(builder: (_) => SpeakerScreen());
      case MyRoute.teamMembers:
        return MaterialPageRoute(builder: (_) => TeamMembers());
      case MyRoute.events:
        return MaterialPageRoute(builder: (_) => EventScreen());
      case MyRoute.sponsors:
        return MaterialPageRoute(builder: (_) => SponsorScreen());
      case MyRoute.contactUs:
        return MaterialPageRoute(builder: (_) => ContactUsScreen());

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('Welcome')),
          ),
        );
    }
  }
}
