import 'package:flutter/material.dart';
import 'package:tedx_sit/components/social_media_icon/social_media_icon_bean.dart';
import 'package:tedx_sit/resources/color.dart';

class SocialMediaIcon extends StatelessWidget {
  final SocialMediaIconBean socialMediaIconBean;
  SocialMediaIcon({
    this.socialMediaIconBean,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: socialMediaIconBean.onTap,
      child: Icon(
        socialMediaIconBean.icon,
        color: MyColor.primaryTheme,
        size: 35,
      ),
    );
  }
}
