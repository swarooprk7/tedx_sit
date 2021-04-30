import 'package:flutter/material.dart';
import 'package:tedx_sit/components/drawer_item/drawer_item_bean.dart';
import 'package:tedx_sit/resources/color.dart';

class DrawerItem extends StatelessWidget {
  final DrawerItemBean drawerItemBean;

  DrawerItem({
    this.drawerItemBean,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: drawerItemBean.onTap,
      leading: Icon(
        drawerItemBean.icon,
        color: MyColor.primaryTheme,
        size: 25,
      ),
      title: Text(
        drawerItemBean.title,
        style: TextStyle(
          color: MyColor.primaryTheme,
          fontSize: 20,
          fontWeight: FontWeight.normal,
        ),
      ),
    );
  }
}
