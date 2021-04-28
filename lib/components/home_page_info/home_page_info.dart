import 'package:flutter/material.dart';
import 'package:tedx_sit/components/home_page_info/home_page_info_bean.dart';
import 'package:tedx_sit/resources/color.dart';

class HomePageInfo extends StatelessWidget {
  final HomePageInfoBean homePageInfoBean;

  HomePageInfo({
    this.homePageInfoBean,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          homePageInfoBean.title,
          textAlign: TextAlign.center,
          style: TextStyle(
            letterSpacing: 1,
            fontSize: 25,
            color: MyColor.redSecondary,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          homePageInfoBean.info,
          textAlign: TextAlign.center,
          style: TextStyle(
            letterSpacing: 1,
            fontSize: 15,
            color: MyColor.primaryTheme,
          ),
        ),
      ],
    );
  }
}
