import 'package:flutter/material.dart';
import 'package:tedx_sit/components/contact_us_info/contact_us_info_bean.dart';
import 'package:tedx_sit/resources/color.dart';

class ContactUsInfo extends StatelessWidget {
  final ContactUsInfoBean contactUsInfoBean;

  ContactUsInfo({
    this.contactUsInfoBean,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(
          contactUsInfoBean.icon,
          size: 40,
          color: MyColor.primaryTheme,
        ),
        SizedBox(
          width: 20,
        ),
        Text(
          contactUsInfoBean.info,
          style: TextStyle(
            color: MyColor.primaryTheme,
            fontSize: 18,
            height: 1.2,
            letterSpacing: 1,
          ),
        ),
      ],
    );
  }
}
