import 'package:flutter/material.dart';
import 'package:tedx_sit/components/team_members/team_members_bean.dart';
import 'package:tedx_sit/resources/color.dart';
import 'package:url_launcher/url_launcher.dart';

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
                    fontSize: 14.0,
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
                    onTap: () async {
                      await launch(linkdnID);
                    },
                    child: Image(
                      image: AssetImage(
                        'assets/images/linkdn.png',
                      ),
                      height: 18.0,
                      fit: BoxFit.fill,
                      // color: MyColor.primaryTheme,
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
