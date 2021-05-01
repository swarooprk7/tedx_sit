import 'package:flutter/material.dart';
import 'package:tedx_sit/resources/route.dart';
import 'package:tedx_sit/screens/contact_us_screen.dart';
import 'package:tedx_sit/screens/events.dart';
import 'package:tedx_sit/screens/home_screen.dart';
import 'package:tedx_sit/screens/speakers_screen.dart';
import 'package:tedx_sit/screens/sponsors.dart';
import 'package:tedx_sit/screens/team_members.dart';
import 'package:tedx_sit/screens/upcoming_event_screen.dart';

class MyRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case MyRoute.speakerScreen:
        return MaterialPageRoute(builder: (_) => SpeakerScreen());
      case MyRoute.teamMembers:
        return MaterialPageRoute(builder: (_) => TeamMembers());
      case MyRoute.events:
        return MaterialPageRoute(builder: (_) => EventScreen());
      case MyRoute.sponsors:
        return MaterialPageRoute(builder: (_) => SponsorScreen());
      case MyRoute.home:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case MyRoute.contactUs:
        return MaterialPageRoute(builder: (_) => ContactUsScreen());
      case MyRoute.upcomingEvent:
        return MaterialPageRoute(builder: (_) => UpcomingEventScreen());
      // default:
      //   return MaterialPageRoute(builder: (_) => HomeScreen());
      // return MaterialPageRoute(
      //   builder: (_) => Scaffold(
      //     body: Center(child: Text('Welcome')),
      //   ),
      // );
    }
  }
}
