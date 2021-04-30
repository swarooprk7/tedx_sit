import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tedx_sit/components/drawer_item/drawer_item.dart';
import 'package:tedx_sit/components/drawer_item/drawer_item_bean.dart';
import 'package:tedx_sit/resources/color.dart';
import 'package:tedx_sit/resources/navigation.dart';
import 'package:tedx_sit/resources/route.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Center(
        child: Container(
          color: MyColor.blackBG,
          height: double.infinity,
          width: double.infinity,
          child: ListView(
            shrinkWrap: true,
            children: [
              DrawerHeader(
                child: Image.asset(
                  'assets/images/logo.png',
                ),
              ),
              DrawerItem(
                drawerItemBean: DrawerItemBean(
                  icon: Icons.home,
                  title: 'Home',
                  onTap: () {
                    MyNavigation().pop(context: context);
                  },
                ),
              ),
              DrawerItem(
                drawerItemBean: DrawerItemBean(
                  icon: Icons.queue_play_next_outlined,
                  title: 'Upcoming event',
                  onTap: () {
                    MyNavigation().pop(context: context);
                    MyNavigation().push(
                      context: context,
                      screen: MyRoute.upcomingEvent,
                    );
                  },
                ),
              ),
              DrawerItem(
                drawerItemBean: DrawerItemBean(
                  icon: FontAwesomeIcons.clock,
                  title: 'Past events',
                  onTap: () {
                    MyNavigation().pop(context: context);
                    MyNavigation().push(
                      context: context,
                      screen: MyRoute.events,
                    );
                  },
                ),
              ),
              DrawerItem(
                drawerItemBean: DrawerItemBean(
                  icon: FontAwesomeIcons.user,
                  title: 'Our Speakers',
                  onTap: () {
                    MyNavigation().pop(context: context);
                    MyNavigation().push(
                      context: context,
                      screen: MyRoute.speakerScreen,
                    );
                  },
                ),
              ),
              DrawerItem(
                drawerItemBean: DrawerItemBean(
                  icon: FontAwesomeIcons.handsHelping,
                  title: 'Our Sponsors',
                  onTap: () {
                    MyNavigation().pop(context: context);
                    MyNavigation().push(
                      context: context,
                      screen: MyRoute.sponsors,
                    );
                  },
                ),
              ),
              DrawerItem(
                drawerItemBean: DrawerItemBean(
                  icon: FontAwesomeIcons.users,
                  title: 'Our team',
                  onTap: () {
                    MyNavigation().pop(context: context);
                    MyNavigation().push(
                      context: context,
                      screen: MyRoute.teamMembers,
                    );
                  },
                ),
              ),
              DrawerItem(
                drawerItemBean: DrawerItemBean(
                  icon: Icons.quick_contacts_dialer_rounded,
                  title: 'Contact us',
                  onTap: () {
                    MyNavigation().pop(context: context);
                    MyNavigation().push(
                      context: context,
                      screen: MyRoute.contactUs,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
