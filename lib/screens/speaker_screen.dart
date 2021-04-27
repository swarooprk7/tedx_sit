import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tedx_sit/components/speakers/speakers_bean.dart';
import 'package:tedx_sit/components/speakers/speakers_components.dart';
import 'package:tedx_sit/resources/color.dart';

class SpeakerScreen extends StatefulWidget {
  final String year;
  SpeakerScreen({this.year = '2020'});

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
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColor.blackBG,
        title: Text(
          'Speakers - 2020',
          style: TextStyle(
            color: MyColor.redSecondary,
            fontSize: screenHeight * 0.035,
          ),
        ),
      ),
      backgroundColor: MyColor.blackBG,
      body: SingleChildScrollView(
        child: Container(
          width: screenWidth * 0.95,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 10,
              ),
              dataArrived == true
                  ? ListView.builder(
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
                      })
                  : Center(child: CircularProgressIndicator()),
            ],
          ),
        ),
      ),
    );
  }
}
