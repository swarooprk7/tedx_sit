import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tedx_sit/components/sponsors/sponsors_bean.dart';
import 'package:tedx_sit/components/sponsors/sponsors_components.dart';
import 'package:tedx_sit/resources/color.dart';

class SponsorScreen extends StatefulWidget {
  @override
  _SponsorScreenState createState() => _SponsorScreenState();
}

class _SponsorScreenState extends State<SponsorScreen> {
  bool dataArrived = false;
  String firstImage;
  String secondImage;
  String titleSponsor;
  List<SponsorBean> grandSponsorsList = [];
  List<SponsorBean> goldSponsorsList = [];

  CollectionReference mainRef = FirebaseFirestore.instance
      .collection('tedx_sit')
      .doc('2020')
      .collection('main_sponsors');
  CollectionReference goldRef = FirebaseFirestore.instance
      .collection('tedx_sit')
      .doc('2020')
      .collection('gold_sponsors');
  CollectionReference grandRef = FirebaseFirestore.instance
      .collection('tedx_sit')
      .doc('2020')
      .collection('grand_sponsors');

  Future<void> readData() async {
    await mainRef.doc('first_image').get().then((value) {
      firstImage = value.get('first_image');
    });
    await mainRef.doc('second_image').get().then((value) {
      secondImage = value.get('second_image');
    });
    await mainRef.doc('title_sponsors').get().then((value) {
      titleSponsor = value.get('title_sponsors');
    });
    await goldRef.get().then((value) => {
          value.docs.forEach((element) {
            SponsorBean bean = SponsorBean(
              imageURL: element['image_url'],
              title: element['title'],
            );
            goldSponsorsList.add(bean);
          })
        });
    await grandRef.get().then((value) => {
          value.docs.forEach((element) {
            SponsorBean bean = SponsorBean(
              imageURL: element['image_url'],
              title: element['title'],
            );
            grandSponsorsList.add(bean);
          })
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
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: MyColor.blackBG,
      appBar: AppBar(
        backgroundColor: MyColor.blackBG,
        title: Text(
          'Sponsors 2020',
          style: TextStyle(
            color: MyColor.redSecondary,
            fontSize: screenHeight * 0.035,
          ),
        ),
      ),
      body: dataArrived
          ? Container(
              width: screenWidth * 0.98,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 20.0),
                    BuildLogo(
                      screenHeight: screenHeight,
                      screenWidth: screenWidth,
                      imageURL: firstImage,
                    ),
                    SizedBox(height: 30.0),
                    if (secondImage.length > 3)
                      BuildLogo(
                        screenHeight: screenHeight,
                        screenWidth: screenWidth,
                        imageURL: secondImage,
                      ),
                    if (secondImage.length > 3) SizedBox(height: 30.0),
                    BuildSponsor(
                      screenHeight: screenHeight,
                      screenWidth: screenWidth,
                      sponsorBean: SponsorBean(
                        imageURL: titleSponsor,
                        title: 'Title Sponsor',
                      ),
                    ),
                    SizedBox(height: 60.0),
                    BuildSponsorList(
                      heading: 'Grand Sponsors',
                      screenHeight: screenHeight,
                      sponsorList: grandSponsorsList,
                      screenWidth: screenWidth,
                    ),
                    SizedBox(height: 60.0),
                    BuildSponsorList(
                      heading: 'Gold Sponsors',
                      screenHeight: screenHeight,
                      sponsorList: goldSponsorsList,
                      screenWidth: screenWidth,
                    ),
                    SizedBox(height: 40.0),
                  ],
                ),
              ),
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}