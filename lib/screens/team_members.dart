import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:tedx_sit/components/organizer/organizer_bean.dart';
import 'package:tedx_sit/components/organizer/organizer_component.dart';
import 'package:tedx_sit/components/team_members/team_member_component.dart';
import 'package:tedx_sit/components/team_members/team_members_bean.dart';
import 'package:tedx_sit/resources/color.dart';

class TeamMembers extends StatefulWidget {
  final String year;
  TeamMembers({
    this.year = '2020',
  });

  @override
  _TeamMembersState createState() => _TeamMembersState();
}

class _TeamMembersState extends State<TeamMembers> {
  String aboutUsData;
  bool dataArrived = false;
  OrganizersBean organizersBean;
  OrganizersBean coOrganizersBean;
  TeamMembersBean teamMembersBean;
  List<TeamMembersBean> artAndDesignList = [];
  List<TeamMembersBean> budgetAndFinanceList = [];
  List<TeamMembersBean> curatorsList = [];
  List<TeamMembersBean> marketingAndPromotionsList = [];
  List<TeamMembersBean> operationsList = [];
  List<TeamMembersBean> technicalTeamList = [];

  Future<void> readOthersData(
      String collectionName, List<TeamMembersBean> dataList) async {
    CollectionReference collectionReference = FirebaseFirestore.instance
        .collection('tedx_sit')
        .doc(widget.year)
        .collection('team_members');
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
    CollectionReference collectionReference = FirebaseFirestore.instance
        .collection('tedx_sit')
        .doc(widget.year)
        .collection('team_members');
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
        centerTitle: true,
        elevation: 10,
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
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.03,
          ),
          child: Container(
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
                            child: Text(
                              aboutUsData,
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                letterSpacing: 1,
                                height: 2,
                                fontSize: screenHeight * 0.02,
                                color: MyColor.primaryTheme,
                              ),
                            ),
                          ),
                        ],
                      ),
                      OrganizerComponent(
                        screenHeight: screenHeight,
                        screenWidth: screenWidth,
                        organizersBean: organizersBean,
                      ),
                      OrganizerComponent(
                        screenWidth: screenWidth,
                        screenHeight: screenHeight,
                        organizersBean: coOrganizersBean,
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
      ),
    );
  }
}
