import 'package:flutter/material.dart';
import 'package:tedx_sit/commons/network_image/network_image_component.dart';
import 'package:tedx_sit/components/organizer/organizer_bean.dart';
import 'package:tedx_sit/resources/color.dart';

class OrganizerComponent extends StatefulWidget {
  OrganizerComponent({
    @required this.screenHeight,
    @required this.screenWidth,
    @required this.organizersBean,
  });

  final double screenHeight;
  final double screenWidth;
  final OrganizersBean organizersBean;

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
        widget.organizersBean.imageURL.length < 2 ||
                widget.organizersBean.imageURL == null
            ? Icon(
                Icons.account_circle,
                size: widget.screenHeight * 0.2,
                color: MyColor.primaryTheme,
              )
            : MyNetworkImage(
                imageURL: widget.organizersBean.imageURL,
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
                  widget.organizersBean.title,
                  style: TextStyle(
                    fontSize: 18.0,
                    color: MyColor.primaryTheme,
                  ),
                ),
                Text(
                  widget.organizersBean.description,
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
              widget.organizersBean.briefInfo,
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
