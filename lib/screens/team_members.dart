import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:tedx_sit/commons/network_image/network_image_component.dart';
import 'package:tedx_sit/resources/color.dart';

class TeamMembers extends StatefulWidget {
  @override
  _TeamMembersState createState() => _TeamMembersState();
}

class OrganizersBean {
  String imageURL;
  String title;
  String description;
  String briefInfo;
  String linkDnURL;

  OrganizersBean({
    this.imageURL,
    this.title,
    this.description,
    this.briefInfo,
    this.linkDnURL,
  });
}

class TeamMembersBean {
  final String name;
  final String designation;
  final String linkDnURL;

  TeamMembersBean({
    this.name,
    this.designation,
    this.linkDnURL,
  });
}

class _TeamMembersState extends State<TeamMembers> {
  String aboutUsData;
  bool dataArrived = false;
  OrganizersBean organizersBean;
  OrganizersBean coOrganizersBean;
  TeamMembersBean teamMembersBean;
  CollectionReference collectionReference = FirebaseFirestore.instance
      .collection('tedx_sit')
      .doc('2020')
      .collection('team_members');
  Future<void> readOthersData(
      String collectionName, List<TeamMembersBean> dataList) async {
    DocumentReference others = collectionReference.doc('others');
    CollectionReference colRef = others.collection(collectionName);

    await colRef.orderBy('priority').get().then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        Map<String, dynamic> element = result.data();

        TeamMembersBean bean = TeamMembersBean(
          linkDnURL: element['linkdn_url'],
          designation: element['designation'],
          name: element['name'],
        );
        dataList.add(bean);
      });
    });
  }

  Future<void> readDate() async {
    DocumentReference aboutUs = collectionReference.doc('about_us');
    DocumentReference organizer = collectionReference.doc('organizer');
    DocumentReference coOrganizer = collectionReference.doc('co_organizer');

    await aboutUs.get().then((value) {
      value.data().forEach((key, value) {
        aboutUsData = value;
      });
    });

    await organizer.get().then((value) {
      OrganizersBean bean = OrganizersBean(
        title: value.get('name'),
        description: value.get('designation'),
        imageURL: value.get('image_url'),
        briefInfo: value.get('brief_info'),
        linkDnURL: value.get('linkdn_url'),
      );
      organizersBean = bean;
    });
    await coOrganizer.get().then((value) {
      OrganizersBean bean = OrganizersBean(
        title: value.get('name'),
        description: value.get('designation'),
        imageURL: value.get('image_url'),
        briefInfo: value.get('brief_info'),
        linkDnURL: value.get('linkdn_url'),
      );
      coOrganizersBean = bean;
    });

    setState(() {
      dataArrived = true;
    });
  }

  List<TeamMembersBean> artAndDesignList = [];
  List<TeamMembersBean> budgetAndFinanceList = [];
  List<TeamMembersBean> curatorsList = [];
  List<TeamMembersBean> marketingAndPromotionsList = [];
  List<TeamMembersBean> operationsList = [];
  List<TeamMembersBean> technicalTeamList = [];

  @override
  void initState() {
    readDate();
    readOthersData('art_and_design', artAndDesignList);
    readOthersData('budget_and_finance', budgetAndFinanceList);
    readOthersData('curators', curatorsList);
    readOthersData('marketing_and_promotions', marketingAndPromotionsList);
    readOthersData('operations', operationsList);
    readOthersData('technical_team', technicalTeamList);
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
          'Our Team',
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
          child: dataArrived == true
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(4.0),
                          child: Text(
                            'Meet the Organisers',
                            style: TextStyle(
                              fontSize: 24.0,
                              color: MyColor.redSecondary,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Container(
                          padding: EdgeInsets.all(4.0),
                          child: Text(
                            aboutUsData,
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                              fontSize: 16.0,
                              color: MyColor.primaryTheme,
                            ),
                          ),
                        ),
                      ],
                    ),
                    OrganizerComponent(
                      screenHeight: screenHeight,
                      screenWidth: screenWidth,
                      imageURL: organizersBean.imageURL,
                      title: organizersBean.title,
                      description: organizersBean.description,
                      briefInfo: organizersBean.briefInfo,
                    ),
                    OrganizerComponent(
                      screenWidth: screenWidth,
                      screenHeight: screenHeight,
                      imageURL: coOrganizersBean.imageURL,
                      title: coOrganizersBean.title,
                      description: coOrganizersBean.description,
                      briefInfo: coOrganizersBean.briefInfo,
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    TeamMembersComponents(
                      heading: 'Curator',
                      dataList: curatorsList,
                    ),
                    TeamMembersComponents(
                      heading: 'Budget and Finance',
                      dataList: budgetAndFinanceList,
                    ),
                    TeamMembersComponents(
                      heading: 'Marketing and Promotion',
                      dataList: marketingAndPromotionsList,
                    ),
                    TeamMembersComponents(
                      heading: 'Technical Team',
                      dataList: technicalTeamList,
                    ),
                    TeamMembersComponents(
                      heading: 'Art And Design',
                      dataList: artAndDesignList,
                    ),
                    TeamMembersComponents(
                      heading: 'Operations',
                      dataList: operationsList,
                    ),
                  ],
                )
              : Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }
}

class TeamMembersComponents extends StatelessWidget {
  final String heading;
  final List<TeamMembersBean> dataList;
  TeamMembersComponents({
    @required this.heading,
    @required this.dataList,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 16.0,
      ),
      child: Column(
        children: [
          Text(
            heading,
            style: TextStyle(
              color: MyColor.primaryTheme,
              fontSize: 24.0,
            ),
          ),
          SizedBox(
            height: 15.0,
          ),
          ListView.builder(
              physics: ScrollPhysics(),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: dataList.length,
              itemBuilder: (BuildContext ctxt, int index) {
                return TeamMemberListBuilder(
                    name: dataList[index].name,
                    designation: dataList[index].designation,
                    linkdnID: dataList[index].linkDnURL);
              }),
        ],
      ),
    );
  }
}

class TeamMemberListBuilder extends StatelessWidget {
  const TeamMemberListBuilder({
    Key key,
    @required this.name,
    @required this.designation,
    @required this.linkdnID,
  }) : super(key: key);

  final String name;
  final String designation;
  final String linkdnID;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: EdgeInsets.only(
              left: 8.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    color: MyColor.primaryTheme,
                    fontSize: 18.0,
                  ),
                ),
                SizedBox(
                  height: 3.0,
                ),
                Text(
                  designation,
                  style: TextStyle(
                    color: MyColor.redSecondary,
                    fontSize: 12.0,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 30.0,
          ),
          Row(
            children: [
              if (linkdnID != null)
                Container(
                  padding: EdgeInsets.all(4.0),
                  child: InkWell(
                    onTap: () {},
                    child: Icon(
                      Icons.description,
                      color: MyColor.primaryTheme,
                      size: 18.0,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class OrganizerComponent extends StatefulWidget {
  OrganizerComponent({
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
  _OrganizerComponentState createState() => _OrganizerComponentState();
}

class _OrganizerComponentState extends State<OrganizerComponent> {
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
                size: widget.screenHeight * 0.2,
                color: MyColor.primaryTheme,
              )
            : MyNetworkImage(
                imageURL: widget.imageURL,
                totalHeight: widget.screenHeight * 0.2,
                totalWidth: widget.screenHeight * 0.2,
                width: widget.screenHeight * 0.2,
                height: widget.screenHeight * 0.2,
              ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Text(
                  widget.title,
                  style: TextStyle(
                    fontSize: 18.0,
                    color: MyColor.primaryTheme,
                  ),
                ),
                Text(
                  widget.description,
                  style: TextStyle(
                    fontSize: 14.0,
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
                ))
          ],
        ),
        if (isSelected)
          Container(
            padding: EdgeInsets.all(4.0),
            margin: EdgeInsets.all(4.0),
            child: Text(
              widget.briefInfo,
              textAlign: TextAlign.justify,
              style: TextStyle(
                color: MyColor.primaryTheme,
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
