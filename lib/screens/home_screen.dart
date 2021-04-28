import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:tedx_sit/components/home_page_info/home_page_info.dart';
import 'package:tedx_sit/components/home_page_info/home_page_info_bean.dart';
import 'package:tedx_sit/components/icon_info_event_details/IconInfoEventDetails.dart';
import 'package:tedx_sit/components/icon_info_event_details/icon_info_event_details_bean.dart';
import 'package:tedx_sit/resources/color.dart';
import 'package:tedx_sit/resources/resource.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: Drawer(
          child: Container(
            color: MyColor.blackBG,
            height: double.infinity,
            width: double.infinity,
            child: ListView(
              children: [],
            ),
          ),
        ),
        appBar: AppBar(
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
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.network(
                  //ToDo add theme image
                  '',
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
                        //Todo add desc from firebase
                        'In the spirit of ideas worth spreading, TED has created a program called TEDx. TEDx is a program of local, self-organized events that bring people together to share a TED-like experience. Our event is called TEDxSiddganagaInstituteofTechnology, where x = independently organized TED event. At our event, TED Talks video and live speakers will combine to spark deep discussion and connection in a small group. The TED Conference provides general guidance for the TEDx program, but individual TEDx events, including ours, are self-organized.',
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
                          images: [
                            //Todo add network images for carousel
                            Image.network(
                              '',
                            ),
                          ],
                        ),
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
                          Colors.white.withOpacity(0.4), BlendMode.dstATop),
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
                          //Todo add desc
                          'Our audience consists of a large multi-cultural community extending beyond that of university campus. As a platform to share ideas, we represent an opportunities to engage in a with our community and inspire others. TEDxSiddagangaInstituteofTechnology is a catalyst for meaningful change in ou campus and beyond.',
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
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            HomePageInfo(
                              //Todo get this info from firebase
                              homePageInfoBean: HomePageInfoBean(
                                title: '12',
                                info: 'Live speakers',
                              ),
                            ),
                            HomePageInfo(
                              //Todo get this info from firebase
                              homePageInfoBean: HomePageInfoBean(
                                title: '3k+',
                                info: 'Community reach',
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            HomePageInfo(
                              //Todo get this info from firebase
                              homePageInfoBean: HomePageInfoBean(
                                title: '600+',
                                info: 'Social media\naudience',
                              ),
                            ),
                            HomePageInfo(
                              //Todo get this info from firebase
                              homePageInfoBean: HomePageInfoBean(
                                title: '100k+',
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
                      Row(
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
                            style: TextStyle(
                              color: MyColor.primaryTheme,
                              fontSize: 40,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        //Todo add desc
                        'TEDxSiddagangaInstituteofTechnology Conference is our biggest event organised in January. It’s an exciting all-day event where attendants can expect to hear 10 live speakers presenting their ideas in engaging and concise TED-like fashion. Every year, a different theme is chosen to encompass all performances.',
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
                          //ToDo redirect to upcoming event screen
                        },
                        child: IconInfoEventDetails(
                          iconInfoEventDetailsBean: IconInfoEventDetailsBean(
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
        ),
      ),
    );
  }
}
