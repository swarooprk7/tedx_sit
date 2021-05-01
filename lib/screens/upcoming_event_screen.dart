import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tedx_sit/components/icon_info_event_details/IconInfoEventDetails.dart';
import 'package:tedx_sit/components/icon_info_event_details/icon_info_event_details_bean.dart';
import 'package:tedx_sit/components/speakers/speakers_bean.dart';
import 'package:tedx_sit/components/speakers/speakers_components.dart';
import 'package:tedx_sit/resources/color.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

class UpcomingEventScreen extends StatefulWidget {
  @override
  _UpcomingEventScreenState createState() => _UpcomingEventScreenState();
}

class _UpcomingEventScreenState extends State<UpcomingEventScreen> {
  String date;
  String time;
  String venue;
  String year;
  String themeImage;
  String themeTitle;
  String themeSubtitle;
  bool dataArrived = false;
  String tickets;
  List<SpeakersBean> speakersList = [];

  Future<void> readData() async {
    DocumentReference contactRef =
        FirebaseFirestore.instance.collection('tedx_sit').doc('upcoming_event');
    DocumentSnapshot upcomingSnapshot = await contactRef.get();
    Map data = upcomingSnapshot.data();
    setState(() {
      date = data['date'];
      time = data['time'];
      venue = data['venue'];
      year = data['year'];
      tickets = data['ticketLink'];
    });
    DocumentSnapshot themeSnapshot = await FirebaseFirestore.instance
        .collection('tedx_sit')
        .doc(year)
        .collection('theme')
        .doc('theme')
        .get();
    Map themeData = themeSnapshot.data();
    setState(() {
      themeTitle = themeData['title'];
      themeSubtitle = themeData['subtitle'];
    });
    await FirebaseFirestore.instance
        .collection('tedx_sit')
        .doc('home')
        .collection('theme_image')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        themeImage = element.data().values.first;
      });
    });
    CollectionReference collectionReference = FirebaseFirestore.instance
        .collection('tedx_sit')
        .doc(year)
        .collection('speakers');
    await collectionReference.orderBy('priority').get().then((value) {
      value.docs.forEach((element) {
        Map<String, dynamic> dataMap = element.data();
        SpeakersBean bean = SpeakersBean(
          name: dataMap['name'],
          designation: dataMap['designation'],
          briefInfo: dataMap['info'],
          imageURL: dataMap['image_url'],
        );
        speakersList.add(bean);
      });
    });
    setState(() {
      dataArrived = true;
    });
  }

  @override
  void initState() {
    readData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        backgroundColor: MyColor.blackBG,
        centerTitle: true,
        title: Text(
          'Upcoming Event',
          style: TextStyle(
            color: MyColor.redSecondary,
            fontSize: screenHeight * 0.035,
          ),
        ),
      ),
      backgroundColor: MyColor.blackBG,
      body: dataArrived
          ? SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: screenHeight * 0.04,
                ),
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.03,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Theme',
                              style: TextStyle(
                                color: MyColor.redSecondary,
                                fontSize: 30,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Image.network(
                        themeImage,
                        height: 200,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.03,
                        ),
                        child: Column(
                          children: [
                            IconInfoEventDetails(
                              iconInfoEventDetailsBean:
                                  IconInfoEventDetailsBean(
                                icon: FontAwesomeIcons.calendar,
                                info: date,
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            IconInfoEventDetails(
                              iconInfoEventDetailsBean:
                                  IconInfoEventDetailsBean(
                                icon: FontAwesomeIcons.clock,
                                info: time,
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            IconInfoEventDetails(
                              iconInfoEventDetailsBean:
                                  IconInfoEventDetailsBean(
                                icon: Icons.location_on,
                                info: venue,
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                  MyColor.redPrimary,
                                ),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(
                                        30,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              onPressed: () {
                                UrlLauncher.launch(tickets);
                              },
                              child: Padding(
                                padding: EdgeInsets.all(
                                  10,
                                ),
                                child: Text(
                                  'Get your tickets',
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Text(
                              'Speakers',
                              style: TextStyle(
                                color: MyColor.redSecondary,
                                fontSize: 30,
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            ListView.builder(
                                physics: ScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemCount: speakersList.length,
                                itemBuilder: (BuildContext ctxt, int index) {
                                  return SpeakerComponent(
                                    screenHeight: screenHeight,
                                    screenWidth: screenWidth,
                                    speakersBean: speakersList[index],
                                  );
                                }),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          : Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: CircularProgressIndicator(
                    valueColor:
                        AlwaysStoppedAnimation<Color>(MyColor.redSecondary),
                  ),
                ),
              ],
            ),
    );
  }
}
