import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tedx_sit/commons/year_constant/year_constant.dart';
import 'package:tedx_sit/components/event/event_bean.dart';
import 'package:tedx_sit/components/event/event_component.dart';
import 'package:tedx_sit/resources/color.dart';

class EventScreen extends StatefulWidget {
  final String year;

  EventScreen({
    this.year = '2019',
  });

  @override
  _EventScreenState createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  bool dataArrived = false;
  bool noDataFound = false;
  bool dataAbsent = true;
  String theme;
  List<EventBean> eventsList = [];

  Future<void> readData() async {
    CollectionReference eventRef = FirebaseFirestore.instance
        .collection('tedx_sit')
        .doc(widget.year)
        .collection('events');
    CollectionReference themeRef = FirebaseFirestore.instance
        .collection('tedx_sit')
        .doc(widget.year)
        .collection('theme');
    await eventRef.orderBy('priority').get().then((value) {
      value.docs.forEach((element) {
        EventBean bean = EventBean(
          youtubeURL: element['youtube'],
          title: element['title'],
          name: element['name'],
          imageURL: element['image_url'],
        );
        eventsList.add(bean);
      });
    });
    await themeRef.get().then((value) {
      value.docs.forEach((element) {
        theme = element['name'];
      });
    });

    setState(() {
      if (eventsList.isEmpty || theme.isEmpty) {
        dataAbsent = true;
      } else
        dataAbsent = false;
    });
    setState(() {
      dataArrived = true;
    });
  }

  @override
  void initState() {
    noDataFound = false;
    readData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (dataAbsent) {
      Timer(Duration(seconds: 20), () {
        setState(() {
          noDataFound = true;
        });
      });
    }
    void choiceAction(String choice) {
      if (choice == Constants.year1) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => EventScreen(year: '2019')),
        );
      } else if (choice == Constants.year2) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => EventScreen(year: '2020')),
        );
      } else if (choice == Constants.year3) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => EventScreen(year: '2021')),
        );
      }
    }

    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: MyColor.blackBG,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: MyColor.blackBG,
        title: Text(
          'Events  ' + widget.year,
          style: TextStyle(
            color: MyColor.redSecondary,
            fontSize: screenHeight * 0.035,
          ),
        ),
        actions: [
          PopupMenuButton<String>(
            color: MyColor.black,
            onSelected: choiceAction,
            itemBuilder: (BuildContext context) {
              return Constants.choices.map((String choice) {
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
                    if (!noDataFound)
                      Column(
                        children: [
                          BuildText(
                              screenHeight: screenHeight,
                              lhs: 'TEDx',
                              rhs:
                                  'SiddagangaInstituteofTechnology - ${widget.year}'),
                          SizedBox(height: 10.0),
                          BuildText(
                              screenHeight: screenHeight,
                              lhs: 'Theme: ',
                              rhs: theme),
                        ],
                      ),
                    Column(
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
                            }),
                      ],
                    ),
                  ],
                ),
              ),
            )
          : !dataAbsent
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Center(
                  child: Text(
                  noDataFound ? 'Sorry, No Data Found!' : 'Loading ...',
                  style: TextStyle(color: MyColor.primaryTheme, fontSize: 16.0),
                )),
    );
  }
}
