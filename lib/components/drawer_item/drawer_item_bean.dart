import 'package:flutter/material.dart';

class DrawerItemBean {
  final IconData icon;
  final String title;
  final Function onTap;

  DrawerItemBean({
    this.icon,
    this.title,
    this.onTap,
  });
}
