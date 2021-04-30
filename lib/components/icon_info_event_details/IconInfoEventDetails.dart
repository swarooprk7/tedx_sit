import 'package:flutter/material.dart';
import 'package:tedx_sit/components/icon_info_event_details/icon_info_event_details_bean.dart';
import 'package:tedx_sit/resources/color.dart';

class IconInfoEventDetails extends StatelessWidget {
  final IconInfoEventDetailsBean iconInfoEventDetailsBean;
  IconInfoEventDetails({
    this.iconInfoEventDetailsBean,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          iconInfoEventDetailsBean.icon,
          color: MyColor.redSecondary,
          size: 70,
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          iconInfoEventDetailsBean.info,
          textAlign: TextAlign.center,
          style: TextStyle(
            letterSpacing: 1,
            fontSize: 20,
            color: MyColor.primaryTheme,
          ),
        ),
      ],
    );
  }
}
