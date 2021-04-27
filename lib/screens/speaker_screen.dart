import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tedx_sit/commons/network_image/network_image_component.dart';
import 'package:tedx_sit/resources/color.dart';

class SpeakerScreen extends StatefulWidget {
  @override
  _SpeakerScreenState createState() => _SpeakerScreenState();
}

class SpeakersBean {
  String name;
  String designation;
  String briefInfo;
  String imageURL;
  SpeakersBean({
    this.name,
    this.designation,
    this.briefInfo,
    this.imageURL,
  });
}

class _SpeakerScreenState extends State<SpeakerScreen> {
  bool dataArrived = false;

  List<SpeakersBean> speakersList = [];

  CollectionReference collectionReference = FirebaseFirestore.instance
      .collection('tedx_sit')
      .doc('2020')
      .collection('speakers');
  Future<void> readDate() async {
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
                          imageURL: speakersList[index].imageURL,
                          title: speakersList[index].name,
                          description: speakersList[index].designation,
                          briefInfo: speakersList[index].briefInfo,
                        );
                      })
                  : Center(
                      child: CircularProgressIndicator(),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

class SpeakerComponent extends StatefulWidget {
  SpeakerComponent({
    @required this.screenHeight,
    @required this.screenWidth,
    @required this.title,
    @required this.description,
    @required this.briefInfo,
    @required this.imageURL,
  });

  final double screenHeight;
  final double screenWidth;
  final String title;
  final String briefInfo;
  final String description;
  final String imageURL;

  @override
  _SpeakerComponentState createState() => _SpeakerComponentState();
}

class _SpeakerComponentState extends State<SpeakerComponent> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 10.0,
        ),
        widget.imageURL.length < 2 || widget.imageURL == null
            ? Icon(
                Icons.account_circle,
                size: widget.screenHeight * 0.25,
                color: MyColor.primaryTheme,
              )
            : MyNetworkImage(
                imageURL: widget.imageURL,
                totalHeight: widget.screenHeight * 0.25,
                totalWidth: widget.screenHeight * 0.25,
                width: widget.screenHeight * 0.25,
                height: widget.screenHeight * 0.25,
              ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Text(
                  widget.title,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: MyColor.primaryTheme,
                  ),
                ),
                Text(
                  widget.description,
                  style: TextStyle(
                    fontSize: 16.0,
                    color: MyColor.redSecondary,
                  ),
                ),
              ],
            ),
            IconButton(
                onPressed: () {
                  setState(() {
                    isSelected = !isSelected;
                  });
                },
                icon: Icon(
                  !isSelected
                      ? Icons.keyboard_arrow_down_sharp
                      : Icons.keyboard_arrow_up_sharp,
                  color: MyColor.primaryTheme,
                )),
          ],
        ),
        if (isSelected)
          Container(
            padding: EdgeInsets.only(left: 8.0, right: 1.0),
            margin:
                EdgeInsets.only(left: 4.0, right: 1.0, top: 4.0, bottom: 4.0),
            child: Text(
              widget.briefInfo,
              textAlign: TextAlign.justify,
              style: TextStyle(
                color: MyColor.primaryTheme,
                letterSpacing: 0.4,
                fontSize: 15.0,
              ),
            ),
          ),
        SizedBox(
          height: 10.0,
        ),
      ],
    );
  }
}
