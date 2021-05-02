import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tedx_sit/components/event/event_bean.dart';
import 'package:tedx_sit/components/event/event_component.dart';
import 'package:tedx_sit/resources/color.dart';

class EventScreen extends StatefulWidget {
  @override
  _EventScreenState createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  String yearString = '';
  String year;
  List<String> allYears = [];
  bool dataArrived = false;

  String theme = '';
  List<EventBean> eventsList = [];

  DocumentReference defaultYearRef =
      FirebaseFirestore.instance.collection('tedx_sit').doc('default_year_set');

  Future<void> readInitialData() async {
    await defaultYearRef.get().then((value) {
      year = value.get('event_year');
    });
    await defaultYearRef.collection('event_year_history').get().then((value) {
      value.docs.forEach((element) {
        if (element['to_show']) allYears.add(element['year']);
      });
    });
    setState(() {
      yearString = year;
    });
    readData();
  }

  Future<void> readData() async {
    CollectionReference eventRef = FirebaseFirestore.instance
        .collection('tedx_sit')
        .doc(year)
        .collection('events');
    CollectionReference themeRef = FirebaseFirestore.instance
        .collection('tedx_sit')
        .doc(year)
        .collection('theme');
    await eventRef.orderBy('priority').get().then((value) {
      value.docs.forEach((element) {
        EventBean bean = EventBean(
          youtubeURL: element['youtube'],
          title: element['title'],
          name: element['name'],
          imageURL: element['image_url'],
        );
        setState(() {
          eventsList.add(bean);
        });
      });
    });
    await themeRef.get().then((value) {
      value.docs.forEach((element) {
        theme = element['title'] + ' ' + element['subtitle'];
      });
    });
    setState(() {
      dataArrived = true;
    });
  }

  @override
  void initState() {
    readInitialData();
    super.initState();
  }

  void choiceAction(String choice) async {
    setState(() {
      year = choice;
      yearString = choice;
      eventsList.clear();
      dataArrived = false;
      theme = '';
      readData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: MyColor.blackBG,
      appBar: AppBar(
        brightness: Brightness.light,
        systemOverlayStyle: SystemUiOverlayStyle(
          systemNavigationBarIconBrightness: Brightness.light,
          systemNavigationBarDividerColor: Colors.black,
          systemNavigationBarColor: Colors.black,
          statusBarColor: Colors.black,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.dark,
        ),
        centerTitle: true,
        backgroundColor: MyColor.blackBG,
        title: Text(
          'Events $yearString',
          style: TextStyle(
            color: MyColor.redSecondary,
            fontSize: screenHeight * 0.035,
          ),
        ),
        actions: [
          if (dataArrived)
            PopupMenuButton<String>(
              color: MyColor.black,
              onSelected: choiceAction,
              itemBuilder: (BuildContext context) {
                return allYears.map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(
                      choice,
                      style: TextStyle(
                        color: MyColor.primaryTheme,
                      ),
                    ),
                  );
                }).toList();
              },
            ),
        ],
      ),
      body: dataArrived
          ? Container(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.03,
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 20.0),
                    Column(
                      children: [
                        BuildText(
                          screenHeight: screenHeight,
                          lhs: 'TEDx',
                          rhs: 'SiddagangaInstituteofTechnology  ' + yearString,
                        ),
                        SizedBox(height: 10.0),
                        BuildText(
                          screenHeight: screenHeight,
                          lhs: 'Theme: ',
                          rhs: theme,
                        ),
                      ],
                    ),
                    dataArrived
                        ? Column(
                            children: [
                              ListView.builder(
                                physics: ScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemCount: eventsList.length,
                                itemBuilder: (BuildContext ctxt, int index) {
                                  return BuildEventItem(
                                    eventBean: eventsList[index],
                                    screenWidth: screenWidth,
                                    screenHeight: screenHeight,
                                  );
                                },
                              ),
                            ],
                          )
                        : Container(),
                  ],
                ),
              ),
            )
          : Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      MyColor.redSecondary,
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
