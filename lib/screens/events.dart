import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tedx_sit/components/event/event_bean.dart';
import 'package:tedx_sit/components/event/event_component.dart';
import 'package:tedx_sit/resources/color.dart';

class EventScreen extends StatefulWidget {
  final String year;
  final List<String> allYears;
  EventScreen({
    this.year = '2019',
    this.allYears,
  });

  @override
  _EventScreenState createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  bool dataArrived = false;
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
    void choiceAction(String choice) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => EventScreen(
            year: choice,
            allYears: widget.allYears,
          ),
        ),
      );
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
              return widget.allYears.map((String choice) {
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
                          rhs:
                              'SiddagangaInstituteofTechnology - ${widget.year}',
                        ),
                        SizedBox(height: 10.0),
                        BuildText(
                          screenHeight: screenHeight,
                          lhs: 'Theme: ',
                          rhs: theme,
                        ),
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
                          },
                        ),
                      ],
                    ),
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
