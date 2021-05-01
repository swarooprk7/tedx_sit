import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tedx_sit/components/speakers/speakers_bean.dart';
import 'package:tedx_sit/components/speakers/speakers_components.dart';
import 'package:tedx_sit/resources/color.dart';

class SpeakerScreen extends StatefulWidget {
  final String year;
  final List<String> allYears;
  SpeakerScreen({
    this.year = '2020',
    this.allYears,
  });

  @override
  _SpeakerScreenState createState() => _SpeakerScreenState();
}

class _SpeakerScreenState extends State<SpeakerScreen> {
  bool dataArrived = false;
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
      dataArrived = true;
    });
  }

  @override
  void initState() {
    readDate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void choiceAction(String choice) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => SpeakerScreen(
            year: choice,
            allYears: widget.allYears,
          ),
        ),
      );
    }

    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
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
