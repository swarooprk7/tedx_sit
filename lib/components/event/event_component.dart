import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tedx_sit/components/event/event_bean.dart';
import 'package:tedx_sit/resources/color.dart';
import 'package:url_launcher/url_launcher.dart';

class BuildEventItem extends StatelessWidget {
  const BuildEventItem({
    @required this.screenHeight,
    @required this.screenWidth,
    @required this.eventBean,
  });

  final double screenHeight;
  final double screenWidth;
  final EventBean eventBean;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 4.0,
        horizontal: 4.0,
      ),
      margin: EdgeInsets.symmetric(vertical: 2.0),
      child: Material(
        borderRadius: BorderRadius.circular(20.0),
        color: MyColor.black,
        elevation: 2.0,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 4.0),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  vertical: 2.0,
                  horizontal: 4.0,
                ),
                child: CachedNetworkImage(
                  imageUrl: eventBean.imageURL,
                  height: screenHeight * 0.3,
                  fit: BoxFit.contain,
                  width: screenWidth * 0.8,
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              Text(
                eventBean.name,
                style: TextStyle(
                  color: MyColor.redSecondary,
                  fontSize: screenHeight * 0.028,
                  letterSpacing: 0.8,
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              Container(
                child: Text(
                  eventBean.title,
                  softWrap: true,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: MyColor.primaryTheme,
                    fontSize: screenHeight * 0.033,
                    letterSpacing: 0.2,
                  ),
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              InkWell(
                onTap: () async {
                  await launch(eventBean.youtubeURL);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('Watch on youtube',
                        style: TextStyle(
                          color: MyColor.primaryTheme,
                          fontSize: 14,
                          letterSpacing: 0.8,
                        )),
                    Container(
                      padding: EdgeInsets.all(4.0),
                      child: Image(
                        image: AssetImage(
                          'assets/images/youtube.png',
                        ),
                        height: 22.0,
                        fit: BoxFit.fill,
                      ),
                    ),
                    SizedBox(width: 18.0),
                  ],
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BuildText extends StatelessWidget {
  const BuildText({
    @required this.screenHeight,
    @required this.lhs,
    @required this.rhs,
    this.lhsFontSize,
    this.rhsFontSize,
  });

  final double screenHeight;
  final String lhs;
  final String rhs;
  final double lhsFontSize;
  final double rhsFontSize;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          lhs,
          style: TextStyle(
            color: MyColor.redSecondary,
            fontSize: lhsFontSize ?? screenHeight * 0.026,
            letterSpacing: 0.4,
          ),
          softWrap: true,
        ),
        Flexible(
          child: Text(
            rhs,
            style: TextStyle(
              color: MyColor.primaryTheme,
              fontSize: rhsFontSize ?? screenHeight * 0.026,
              letterSpacing: 0.4,
            ),
            softWrap: true,
          ),
        ),
      ],
    );
  }
}
