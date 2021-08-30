import 'dart:io';
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share/share.dart';
import 'package:upen/commonWidget/commonWidget.dart';
import 'package:upen/screen/CustomerVerification/customerVerificationView.dart';
import 'package:upen/screen/customerCrediCardVerification/customerCreditCardVerification.dart';
import 'package:upen/screen/dashBoard/dashBoardController.dart';
import 'package:upen/screen/helper/constant.dart';
import 'package:upen/screen/leaderBoard/leaderBoardView.dart';
import 'package:upen/screen/leads/LeadView.dart';
import 'package:upen/screen/myLevel/myLevelView.dart';
import 'package:upen/screen/notes/notesView.dart';
import 'package:upen/screen/payout/payOutView.dart';
import 'package:upen/screen/products/productsView.dart';
import 'package:upen/screen/refer/referView.dart';
import 'package:upen/screen/team/teamView.dart';
import 'package:upen/screen/training/trainingView.dart';
import 'dart:ui' as ui;
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



  ScreenshotController imageController = ScreenshotController();
  GlobalKey imagekey = GlobalKey();
  Uint8List pngBytes ;
  File capturedFile;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(top: 5, left: 10, right: 10),
              height: MediaQuery.of(context).size.height / 5.5,
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
                              InkWell(
                                onTap: () {
                                  AddLead();
                                },
                                child: Column(
                                  children: [
                                    Container(
                                      height: 30,
                                      width: 40,
                                      child: SvgPicture.asset(
                                          "assets/icons/add.svg"),
                                    ),
                                    SizedBox(height: 5),
                                    CommonText(
                                        text: "Add Lead",
                                        textColor: Constants().mainColor)
                                  ],
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Get.to(LeadView());
                                },
                                child: Column(
                                  children: [
                                    Container(
                                      height: 35,
                                      width: 40,
                                      child: SvgPicture.asset(
                                          "assets/icons/lead.svg"),
                                    ),
                                    SizedBox(height: 5),
                                    CommonText(
                                        text: "My Leads",
                                        textColor: Constants().mainColor)
                                  ],
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Get.to(MyTeamView());
                                },
                                child: Column(
                                  children: [
                                    Container(
                                      height: 35,
                                      width: 40,
                                      child: SvgPicture.asset(
                                          "assets/icons/team.svg"),
                                    ),
                                    SizedBox(height: 5),
                                    CommonText(
                                        text: "My Team",
                                        textColor: Constants().mainColor)
                                  ],
                                ),
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
                              InkWell(
                                onTap: () {
                                  Get.to(PayOutView());
                                },
                                child: Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(bottom: 5),
                                        height: 30,
                                        width: 40,
                                        child: SvgPicture.asset(
                                            "assets/icons/pay.svg"),
                                      ),
                                      SizedBox(height: 5),
                                      CommonText(
                                          text: "Payout",
                                          textColor: Constants().mainColor)
                                    ],
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Get.to(TrainingView());
                                },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(bottom: 5),
                                      height: 35,
                                      width: 40,
                                      child: SvgPicture.asset(
                                          "assets/icons/idea.svg"),
                                    ),
                                    SizedBox(height: 5),
                                    CommonText(
                                        text: "Idea",
                                        textColor: Constants().mainColor)
                                  ],
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Get.to(NotesView());
                                },
                                child: Column(
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
                                        text: "Notes",
                                        textColor: Constants().mainColor)
                                  ],
                                ),
                              ),
                              InkWell(
                                onTap: (){
                                  Get.to(ReferView());
                                },
                                child: Column(
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
                              InkWell(
                                onTap: () {
                                  CommonBottomSheet().bottomSheet(
                                      title: "My Visiting Card",
                                      context: context,
                                      content: Column(children: [RepaintBoundary(child: Screenshot(
                                        key: imagekey,
                                        controller: imageController,
                                        child: Container(
                                          padding: EdgeInsets.only(left: 50,right: 50,top: 50,bottom: 50),
                                          decoration: BoxDecoration(
                                              border: Border.all(color: Constants().mainColor,width: 5)
                                          ),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(

                                                margin:
                                                EdgeInsets.only(bottom: 10),
                                                height: 80,
                                                width: 80,
                                                child: SvgPicture.asset(
                                                    "assets/icons/employee.svg"),
                                              ),
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  CommonText(
                                                      text: "ABHISHEK MISHRA",fontSize: 22,textColor: Constants().mainColor,fontStyle: FontWeight.bold),
                                                  CommonText(
                                                      text: "(ADVISOR)",fontSize: 16,textColor: Colors.black,fontStyle: FontWeight.bold),
                                                  SizedBox(height: 30,),
                                                  Row(children: [Icon(Icons.phone), CommonText(
                                                      text: "(9725131037",fontSize: 14,textColor: Colors.black,fontStyle: FontWeight.bold),],),
                                                  Row(children: [Icon(Icons.mail_outline), CommonText(
                                                      text: "(msachin213@gmail.com",fontSize: 14,textColor: Colors.black,fontStyle: FontWeight.bold),],),
                                                  Row(children: [Icon(Icons.location_on), CommonText(
                                                      text: ", Surat, Gujarat, 394221",fontSize: 14,textColor: Colors.black,fontStyle: FontWeight.bold),],),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),),
                                        SizedBox(height: 20,),
                                        InkWell(
                                        onTap: () async {
                                          final RenderRepaintBoundary boundary =
                                          imagekey.currentContext.findRenderObject();
                                          final ui.Image image = await boundary.toImage(pixelRatio: 3.0);
                                          final ByteData byteData =
                                          await image.toByteData(format: ui.ImageByteFormat.png);
                                          pngBytes = byteData.buffer.asUint8List();
                                          String dir = (await getApplicationDocumentsDirectory()).path;

                                          final String fullPath = '$dir/${DateTime.now().millisecond}.png';

                                          capturedFile = File(fullPath);

                                          await capturedFile.writeAsBytes(pngBytes);

                                          capturedFile = File(fullPath);
                                          List<String> imgPath = [capturedFile.path];
                                          Share.shareFiles(
                                            imgPath,
                                            subject: "My Visiting Card",
                                            text: "Contact Me" ,
                                          );
                                        },
                                        child: ClipRRect(

                                          borderRadius: BorderRadius.all(Radius.circular(12)),
                                          child: Container(
                                            margin: EdgeInsets.only(left: 20,right: 20),
                                            height: 50,
                                            width: MediaQuery.of(context).size.width,
                                            color: Colors.amber,
                                            child:  Container(
                                              height: 100,
                                              width: MediaQuery.of(context).size.width,
                                              child:
                                              Center(child: CommonText(text: "Share Visiting Card",fontSize: 18)),
                                            ),
                                          ),
                                        ),
                                      )],));
                                },
                                child: Column(
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
                                        text: "ID Card",
                                        textColor: Constants().mainColor)
                                  ],
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Get.to(LeaderBoardView());
                                },
                                child: Column(
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
                                        text: "Graph",
                                        textColor: Constants().mainColor)
                                  ],
                                ),
                              ),
                              InkWell(
                                onTap: (){
                                  Get.to(MyLevelView());
                                },
                                child: Column(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(bottom: 5),
                                      height: 35,
                                      width: 40,
                                      child: SvgPicture.asset(
                                          "assets/icons/ribbon.svg"),
                                    ),
                                    SizedBox(height: 5),
                                    CommonText(
                                        text: "Level",
                                        textColor: Constants().mainColor)
                                  ],
                                ),
                              ),
                              Column(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(bottom: 5),
                                    height: 35,
                                    width: 40,
                                    child: SvgPicture.asset(
                                        "assets/icons/task.svg"),
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
            InkWell(
              onTap: () {
                Get.to(ReferView());
              },
              child: Container(
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
            ),
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
                      child: Container(
                        child: ImageNetworkTap(
                            fit: BoxFit.fill,
                            width: MediaQuery.of(context).size.width / 2,
                            height: 100,
                            imagePathAPI:
                                "https://a57.foxnews.com/static.foxbusiness.com/foxbusiness.com/content/uploads/2020/02/931/506/Credible-credit-cards-guide-iStock-1165129876.jpg?ve=1&tl=1"),
                      ),
                    );
                  }),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.only(top: 5, left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CommonText(
                      text: "Our Products",
                      textColor: Constants().mainColor),
                  InkWell(onTap: (){
                    Get.to(ProductsView());
                  },child: CommonText(text: "View All", textColor: Colors.black))
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
                    return SizedBox(
                      width: MediaQuery.of(context).size.width - 50,
                      child: InkWell(
                        onTap: (){
                          AddLead();

                        },
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
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                    width: 100,
                                    height: 40,
                                    decoration: BoxDecoration(
                                        color: Constants().mainColor,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20))),
                                    child: Center(
                                      child: CommonText(text: "Add lead"),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
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

    );
  }
}
