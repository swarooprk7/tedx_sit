import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tedx_sit/commons/year_constant/year_constant.dart';
import 'package:tedx_sit/components/speakers/speakers_bean.dart';
import 'package:tedx_sit/components/speakers/speakers_components.dart';
import 'package:tedx_sit/resources/color.dart';

class SpeakerScreen extends StatefulWidget {
  final String year;
  SpeakerScreen({
    this.year = '2020',
  });

  @override
  _SpeakerScreenState createState() => _SpeakerScreenState();
}

class _SpeakerScreenState extends State<SpeakerScreen> {
  bool dataArrived = false;
  bool noDataFound = false;
  bool dataAbsent = true;
  List<SpeakersBean> speakersList = [];

  Future<void> readDate() async {
    CollectionReference collectionReference = FirebaseFirestore.instance
        .collection('tedx_sit')
        .doc(widget.year)
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
      if (!(speakersList.length >= 1)) {
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
    readDate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (dataAbsent) {
      Timer(Duration(seconds: 2), () {
        setState(() {
          noDataFound = true;
        });
      });
    }
    void choiceAction(String choice) {
      if (choice == Constants.year1) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => SpeakerScreen(year: '2019')),
        );
      } else if (choice == Constants.year2) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => SpeakerScreen(year: '2020')),
        );
      } else if (choice == Constants.year3) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => SpeakerScreen(year: '2021')),
        );
      }
    }

    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColor.blackBG,
        title: Text(
          'Speakers - ${widget.year}',
          style: TextStyle(
            color: MyColor.redSecondary,
            fontSize: screenHeight * 0.035,
          ),
        ),
        actions: [
          PopupMenuButton<String>(
            onSelected: choiceAction,
            itemBuilder: (BuildContext context) {
              return Constants.choices.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      backgroundColor: MyColor.blackBG,
      body: dataArrived
          ? SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: 4.0,
                  horizontal: 4.0,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      child: ListView.builder(
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
                    )
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
