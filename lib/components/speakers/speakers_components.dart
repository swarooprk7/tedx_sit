import 'package:flutter/material.dart';
import 'package:tedx_sit/commons/network_image/network_image_component.dart';
import 'package:tedx_sit/components/speakers/speakers_bean.dart';
import 'package:tedx_sit/resources/color.dart';

class SpeakerComponent extends StatefulWidget {
  SpeakerComponent({
    @required this.screenHeight,
    @required this.screenWidth,
    @required this.speakersBean,
  });

  final double screenHeight;
  final double screenWidth;
  final SpeakersBean speakersBean;

  @override
  _SpeakerComponentState createState() => _SpeakerComponentState();
}

class _SpeakerComponentState extends State<SpeakerComponent> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    return Column(
      children: [
        SizedBox(
          height: 10.0,
        ),
        widget.speakersBean.imageURL.length < 2 ||
                widget.speakersBean.imageURL == null
            ? Icon(
                Icons.account_circle,
                size: widget.screenHeight * 0.25,
                color: MyColor.primaryTheme,
              )
            : MyNetworkImage(
                imageURL: widget.speakersBean.imageURL,
                totalHeight: widget.screenHeight * 0.25,
                totalWidth: widget.screenHeight * 0.25,
                width: widget.screenHeight * 0.25,
                height: widget.screenHeight * 0.25,
              ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Text(
                  widget.speakersBean.name,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: MyColor.primaryTheme,
                  ),
                ),
                Text(
                  widget.speakersBean.designation,
                  style: TextStyle(
                    fontSize: 16.0,
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
                )),
          ],
        ),
        if (isSelected)
          Container(
            padding: EdgeInsets.only(left: 8.0, right: 1.0),
            margin:
                EdgeInsets.only(left: 4.0, right: 1.0, top: 4.0, bottom: 4.0),
            child: Text(
              widget.speakersBean.briefInfo,
              textAlign: TextAlign.justify,
              style: TextStyle(
                color: MyColor.primaryTheme,
                letterSpacing: 1,
                height: 2,
                fontSize: screenHeight * 0.02,
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
