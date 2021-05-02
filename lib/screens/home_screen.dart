import 'package:carousel_pro/carousel_pro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tedx_sit/components/drawer/custom_drawer.dart';
import 'package:tedx_sit/components/home_page_info/home_page_info.dart';
import 'package:tedx_sit/components/home_page_info/home_page_info_bean.dart';
import 'package:tedx_sit/components/icon_info_event_details/IconInfoEventDetails.dart';
import 'package:tedx_sit/components/icon_info_event_details/icon_info_event_details_bean.dart';
import 'package:tedx_sit/resources/color.dart';
import 'package:tedx_sit/resources/navigation.dart';
import 'package:tedx_sit/resources/resource.dart';
import 'package:tedx_sit/resources/route.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String speakerYear;
  String eventYear;
  List<String> eventAllYears = [];
  List<String> speakerAllYears = [];

  String whatIsTedx;
  String engagement;
  String mainConference;
  String themeImage;
  bool dataArrived = false;

  String communityReach;
  String liveSpeakers;
  String socialMediaAudience;
  String youtubeViews;

  List imagesList = [];
  Future<void> readData() async {
    DocumentReference defaultYearRef = FirebaseFirestore.instance
        .collection('tedx_sit')
        .doc('default_year_set');

    DocumentReference homeRef =
        FirebaseFirestore.instance.collection('tedx_sit').doc('home');

    CollectionReference detailRef = homeRef.collection('details');

    await defaultYearRef.collection('event_year_history').get().then((value) {
      value.docs.forEach((element) {
        if (element['to_show']) eventAllYears.add(element['year']);
      });
    });
    await defaultYearRef.collection('speaker_year_history').get().then((value) {
      value.docs.forEach((element) {
        if (element['to_show']) speakerAllYears.add(element['year']);
      });
    });
    await defaultYearRef.get().then((value) {
      eventYear = value.get('event_year');
      speakerYear = value.get('speaker_year');
    });

    await homeRef.collection('theme_image').get().then((value) {
      value.docs.forEach((element) {
        themeImage = element.data().values.first;
      });
    });
    await detailRef.doc('about_tedx').get().then((value) {
      whatIsTedx = value.get('what_is_tedx');
    });
    await detailRef.doc('engagement').get().then((value) {
      engagement = value.get('description');
    });
    await detailRef.doc('mainconference').get().then((value) {
      mainConference = value.get('description');
    });
    await homeRef.collection('carousel_images').get().then((value) {
      value.docs.forEach((element) {
        String tempImage = element['image_url'];
        imagesList.add(Image.network(tempImage));
      });
    });
    await homeRef
        .collection('original_data')
        .doc('community_reach')
        .get()
        .then((value) {
      communityReach = value.get('count');
    });
    await homeRef
        .collection('original_data')
        .doc('live_speakers')
        .get()
        .then((value) {
      liveSpeakers = value.get('count');
    });
    await homeRef
        .collection('original_data')
        .doc('social_media_audience')
        .get()
        .then((value) {
      socialMediaAudience = value.get('count');
    });
    await homeRef
        .collection('original_data')
        .doc('youtube_views')
        .get()
        .then((value) {
      youtubeViews = value.get('count');
    });

    setState(() {
      dataArrived = true;
    });
  }

  @override
  void initState() {
    readData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: CustomDrawer(
          eventAllYear: eventAllYears,
          eventYear: eventYear,
          speakerAllYear: speakerAllYears,
          speakerYear: speakerYear,
        ),
        appBar: AppBar(
          brightness: Brightness.light,
          elevation: 10,
          centerTitle: true,
          backgroundColor: MyColor.blackBG,
          title: Image.asset(
            Resource.image.logo,
            height: 50,
          ),
          toolbarHeight: 80,
        ),
        backgroundColor: MyColor.blackBG,
        body: dataArrived
            ? SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 20,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.network(
                        themeImage,
                        height: 200,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20,
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  Resource.string.whatIs,
                                  style: TextStyle(
                                    color: MyColor.primaryTheme,
                                    fontSize: 40,
                                  ),
                                ),
                                Text(
                                  Resource.string.tedx,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: MyColor.redSecondary,
                                    fontSize: 40,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              whatIsTedx,
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                letterSpacing: 1,
                                height: 2,
                                fontSize: 15,
                                color: MyColor.primaryTheme,
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              height: 200,
                              child: Carousel(
                                  autoplay: true,
                                  boxFit: BoxFit.fitWidth,
                                  dotBgColor: Colors.transparent,
                                  dotSize: 5,
                                  images: imagesList),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            colorFilter: ColorFilter.mode(
                                Colors.white.withOpacity(0.4),
                                BlendMode.dstATop),
                            image: AssetImage(
                              Resource.image.engagementSectionBg,
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 20,
                          ),
                          child: Column(
                            children: [
                              Text(
                                Resource.string.engagement,
                                style: TextStyle(
                                  letterSpacing: 1,
                                  fontSize: 40,
                                  color: MyColor.primaryTheme,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                engagement,
                                textAlign: TextAlign.justify,
                                style: TextStyle(
                                  letterSpacing: 1,
                                  height: 2,
                                  fontSize: 15,
                                  color: MyColor.primaryTheme,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  HomePageInfo(
                                    homePageInfoBean: HomePageInfoBean(
                                      title: liveSpeakers,
                                      info: 'Live speakers',
                                    ),
                                  ),
                                  HomePageInfo(
                                    homePageInfoBean: HomePageInfoBean(
                                      title: communityReach,
                                      info: 'Community reach',
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  HomePageInfo(
                                    homePageInfoBean: HomePageInfoBean(
                                      title: socialMediaAudience,
                                      info: 'Social media\naudience',
                                    ),
                                  ),
                                  HomePageInfo(
                                    homePageInfoBean: HomePageInfoBean(
                                      title: youtubeViews,
                                      info: 'Youtube views',
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20,
                        ),
                        child: Column(
                          children: [
                            Text(
                              Resource.string.main,
                              style: TextStyle(
                                color: MyColor.redSecondary,
                                fontSize: 40,
                              ),
                            ),
                            Text(
                              Resource.string.conference,
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                color: MyColor.primaryTheme,
                                fontSize: 40,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              mainConference,
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                letterSpacing: 1,
                                height: 2,
                                fontSize: 15,
                                color: MyColor.primaryTheme,
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            GestureDetector(
                              onTap: () {
                                MyNavigation().push(
                                  context: context,
                                  screen: MyRoute.upcomingEvent,
                                );
                              },
                              child: IconInfoEventDetails(
                                iconInfoEventDetailsBean:
                                    IconInfoEventDetailsBean(
                                  icon: Icons.access_time,
                                  info: Resource.string.checkOut,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation<Color>(MyColor.redSecondary),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
