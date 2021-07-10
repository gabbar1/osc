import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:get/get.dart';
import 'package:upen/commonWidget/commonWidget.dart';
import 'package:upen/screen/dashBoard/dashBoardController.dart';
import 'package:upen/screen/helper/constant.dart';

class DashBoardView extends StatefulWidget {
  @override
  _DashBoardViewState createState() => _DashBoardViewState();
}

class _DashBoardViewState extends State<DashBoardView> {
  DashBoardController dashBoardController = Get.put(DashBoardController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dashBoardController.getBannerList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CommonText(text: "Welcome Abhishek Mishra", fontSize: 18),
        actions: [
          IconButton(
            icon: Icon(Icons.notification_important_outlined),
            onPressed: () {},
          ),
          InkWell(
            child: Container(
              height: 65,
              width: 40,
              padding: EdgeInsets.only(left: 10, right: 5),
              child: SvgPicture.asset(
                "assets/icons/support.svg",
                color: Colors.white,
                height: 10,
              ),
            ),
            onTap: () {},
          ),
          SizedBox(
            width: 10,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(

              margin: EdgeInsets.only(top: 5, left: 10, right: 10),
              height: MediaQuery.of(context).size.height / 4.5,
              child: Center(
                child: new Obx(() => Swiper(
                      outer: false,
                      itemCount: dashBoardController.getBanners.length,
                      autoplayDelay: 5000,
                      autoplay: true,
                      viewportFraction: 1.0,
                      scale: 0.9,
                      pagination: new SwiperPagination(),
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: ImageNetworkTap(
                                ontap: () {
                                  if (dashBoardController
                                              .getBanners[index].image !=
                                          null &&
                                      dashBoardController.getBanners[index]
                                          .image.isNotEmpty) {}
                                },
                                imagePathAPI:
                                    dashBoardController.getBanners[index].image,
                                fit: BoxFit.fill));
                      },
                    )),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
                margin: EdgeInsets.only(top: 5, left: 10, right: 10),
                child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                  padding: const EdgeInsets.only(
                      top: 10, left: 20, right: 20, bottom: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CommonText(
                          text: "Add Lead",
                          textColor: Constants().mainColor,
                          fontSize: 20,
                          fontStyle: FontWeight.bold),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Container(
                                height: 30,
                                width: 40,
                                child: SvgPicture.asset("assets/icons/add.svg"),
                              ),
                              SizedBox(height: 5),
                              CommonText(
                                  text: "Add Lead",
                                  textColor: Constants().mainColor)
                            ],
                          ),
                          Column(
                            children: [
                              Container(
                                height: 35,
                                width: 40,
                                child:
                                    SvgPicture.asset("assets/icons/lead.svg"),
                              ),
                              SizedBox(height: 5),
                              CommonText(
                                  text: "My Leads",
                                  textColor: Constants().mainColor)
                            ],
                          ),
                          Column(
                            children: [
                              Container(
                                height: 35,
                                width: 40,
                                child:
                                    SvgPicture.asset("assets/icons/team.svg"),
                              ),
                              SizedBox(height: 5),
                              CommonText(
                                  text: "My Team",
                                  textColor: Constants().mainColor)
                            ],
                          ),
                        ],
                      ),
                      Divider(
                        thickness: 2,
                        color: Constants().mainColor,
                      ),
                      SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.pending_actions,
                                color: Constants().mainColor,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              CommonText(
                                  text: "Pending Leads",
                                  textColor: Constants().mainColor,
                                  fontStyle: FontWeight.bold)
                            ],
                          ),
                          Row(
                            children: [
                              CommonText(
                                  text: "0",
                                  textColor: Constants().mainColor,
                                  fontStyle: FontWeight.bold),
                              SizedBox(
                                width: 5,
                              ),
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: Constants().mainColor,
                                size: 15,
                              ),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ))),
            SizedBox(
              height: 20,
            ),
            Container(
                margin: EdgeInsets.only(top: 5, left: 10, right: 10),
                child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                  padding: const EdgeInsets.only(
                      top: 10, left: 20, right: 20, bottom: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(bottom: 5),
                                  height: 30,
                                  width: 40,
                                  child:
                                      SvgPicture.asset("assets/icons/pay.svg"),
                                ),
                                SizedBox(height: 5),
                                CommonText(
                                    text: "Payout",
                                    textColor: Constants().mainColor)
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                margin: EdgeInsets.only(bottom: 5),
                                height: 35,
                                width: 40,
                                child:
                                    SvgPicture.asset("assets/icons/idea.svg"),
                              ),
                              SizedBox(height: 5),
                              CommonText(
                                  text: "Knowledge",
                                  textColor: Constants().mainColor)
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                margin: EdgeInsets.only(bottom: 5),
                                height: 35,
                                width: 40,
                                child: SvgPicture.asset(
                                    "assets/icons/reminder.svg"),
                              ),
                              SizedBox(height: 5),
                              CommonText(
                                  text: "Reminder",
                                  textColor: Constants().mainColor)
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                margin: EdgeInsets.only(bottom: 5),
                                height: 35,
                                width: 40,
                                child: SvgPicture.asset(
                                    "assets/icons/sharing.svg"),
                              ),
                              SizedBox(height: 5),
                              CommonText(
                                  text: "Share",
                                  textColor: Constants().mainColor)
                            ],
                          ),
                        ],
                      ),
                      Divider(
                        thickness: 2,
                        color: Constants().mainColor,
                      ),
                      SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Container(
                                margin: EdgeInsets.only(bottom: 10),
                                height: 30,
                                width: 40,
                                child: SvgPicture.asset(
                                    "assets/icons/employee.svg"),
                              ),
                              SizedBox(height: 5),
                              CommonText(
                                  text: "Visiting Card",
                                  textColor: Constants().mainColor)
                            ],
                          ),
                          Column(
                            children: [
                              Container(
                                margin: EdgeInsets.only(bottom: 5),
                                height: 35,
                                width: 40,
                                child: SvgPicture.asset(
                                    "assets/icons/presentation.svg"),
                              ),
                              SizedBox(height: 5),
                              CommonText(
                                  text: "Leader Board",
                                  textColor: Constants().mainColor)
                            ],
                          ),
                          Column(
                            children: [
                              Container(
                                margin: EdgeInsets.only(bottom: 5),
                                height: 35,
                                width: 40,
                                child:
                                    SvgPicture.asset("assets/icons/ribbon.svg"),
                              ),
                              SizedBox(height: 5),
                              CommonText(
                                  text: "Advisor Badge",
                                  textColor: Constants().mainColor)
                            ],
                          ),
                          Column(
                            children: [
                              Container(
                                margin: EdgeInsets.only(bottom: 5),
                                height: 35,
                                width: 40,
                                child:
                                    SvgPicture.asset("assets/icons/task.svg"),
                              ),
                              SizedBox(height: 5),
                              CommonText(
                                  text: "My Task",
                                  textColor: Constants().mainColor)
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ))),
            SizedBox(
              height: 10,
            ),
            Container(

                height: 70,
                margin: EdgeInsets.only(top: 5, left: 10, right: 10),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CommonText(
                            text: "Achievements",
                            textColor: Constants().mainColor),
                        Container(
                          margin: EdgeInsets.only(bottom: 5),
                          height: 30,
                          width: 40,
                          child: SvgPicture.asset("assets/icons/wreath.svg"),
                        ),
                      ],
                    ),
                  ),
                )),
            SizedBox(
              height: 10,
            ),
            Container(
                height: 70,
                margin: EdgeInsets.only(top: 5, left: 10, right: 10),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CommonText(
                            text: "Refer & Earn",
                            textColor: Constants().mainColor),
                        Container(
                          margin: EdgeInsets.only(bottom: 5),
                          height: 30,
                          width: 40,
                          child: SvgPicture.asset("assets/icons/sharing.svg"),
                        ),
                      ],
                    ),
                  ),
                )),
            Padding(
              padding: EdgeInsets.only(top: 5, left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CommonText(
                      text: "Personalised Cards",
                      textColor: Constants().mainColor),
                  CommonText(text: "View All", textColor: Colors.black)
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: MediaQuery.of(context).size.height / 4.5,
              padding: EdgeInsets.only(left: 20, right: 20),
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  itemBuilder: (BuildContext context, index) {
                    return Card(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Container(child: ImageNetworkTap(
                          fit: BoxFit.fill,
                          width: MediaQuery.of(context).size.width / 2,
                          height: 100,
                          imagePathAPI:
                          "https://a57.foxnews.com/static.foxbusiness.com/foxbusiness.com/content/uploads/2020/02/931/506/Credible-credit-cards-guide-iStock-1165129876.jpg?ve=1&tl=1"),),
                    );
                  }),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.only(top: 5, left: 20, right: 20),
              child:
    CommonText(
    text: "Our Products",
    textColor: Constants().mainColor),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: MediaQuery.of(context).size.height / 4.5,
              padding: EdgeInsets.only(left: 20, right: 20),
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  itemBuilder: (BuildContext context, index) {
                    return SizedBox(
                      width: MediaQuery.of(context).size.width - 50,
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 15.0),
                              child: Container(
                                margin: EdgeInsets.only(bottom: 5),
                                height: 100,
                                width: 100,
                                child:
                                    SvgPicture.asset("assets/icons/loan.svg"),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: CommonText(
                                      text: "Loan",
                                      textColor: Constants().mainColor),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(bottom: 5),
                                          height: 30,
                                          width: 40,
                                          child: SvgPicture.asset(
                                              "assets/icons/medal.svg"),
                                        ),
                                        CommonText(
                                            text: "Reward",
                                            textColor: Constants().mainColor),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(bottom: 5),
                                          height: 30,
                                          width: 40,
                                          child: SvgPicture.asset(
                                              "assets/icons/healthy.svg"),
                                        ),
                                        CommonText(
                                            text: "Lifestyle",
                                            textColor: Constants().mainColor),
                                      ],
                                    ),

                                  ],
                                ),
                                SizedBox(height: 5,),
                                Container(
                                  width: 100,
                                  height: 40,
                                  decoration: BoxDecoration(
                                     color: Constants().mainColor,

                                      borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                                  child: Center(
                                    child: CommonText(text: "Add lead"),
                                  ),
                                )
                              ],
                            ),


                          ],
                        ),
                      ),
                    );
                  }),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
      drawer: AppDrawer(),
    );
  }
}
