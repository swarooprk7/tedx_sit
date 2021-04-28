import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tedx_sit/components/sponsors/sponsors_bean.dart';
import 'package:tedx_sit/resources/color.dart';

class BuildSponsor extends StatelessWidget {
  const BuildSponsor({
    @required this.screenHeight,
    @required this.screenWidth,
    @required this.sponsorBean,
  });

  final double screenHeight;
  final double screenWidth;
  final SponsorBean sponsorBean;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BuildLogo(
          screenHeight: screenHeight,
          screenWidth: screenWidth,
          imageURL: sponsorBean.imageURL,
        ),
        if (sponsorBean.title != null)
          Text(
            sponsorBean.title,
            style: TextStyle(
              color: MyColor.primaryTheme,
              fontSize: screenHeight * 0.03,
            ),
            overflow: TextOverflow.fade,
          ),
      ],
    );
  }
}

class BuildLogo extends StatelessWidget {
  const BuildLogo({
    Key key,
    @required this.screenHeight,
    @required this.screenWidth,
    @required this.imageURL,
  }) : super(key: key);

  final double screenHeight;
  final double screenWidth;
  final String imageURL;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CachedNetworkImage(
        imageUrl: imageURL,
        height: screenHeight * 0.25,
        fit: BoxFit.contain,
        width: screenWidth * 0.75,
      ),
    );
  }
}

class BuildSponsorList extends StatelessWidget {
  const BuildSponsorList({
    @required this.screenHeight,
    @required this.sponsorList,
    @required this.screenWidth,
    @required this.heading,
  });

  final double screenHeight;
  final List<SponsorBean> sponsorList;
  final double screenWidth;
  final String heading;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          heading,
          style: TextStyle(
            color: MyColor.primaryTheme,
            fontSize: screenHeight * 0.035,
          ),
        ),
        SizedBox(height: 15.0),
        ListView.builder(
            physics: ScrollPhysics(),
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: sponsorList.length,
            itemBuilder: (BuildContext ctxt, int index) {
              return BuildSponsor(
                sponsorBean: sponsorList[index],
                screenWidth: screenWidth,
                screenHeight: screenHeight,
              );
            }),
      ],
    );
  }
}
