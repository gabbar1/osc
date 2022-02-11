import 'dart:io';
import 'dart:typed_data';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:upen/commonWidget/commonWidget.dart';
import 'package:upen/screen/helper/constant.dart';
import 'package:upen/screen/myWork/my_work.dart';
import 'package:upen/screen/myWork/controller/my_work_controller.dart';
import 'package:upen/screen/myWork/user_list_view.dart';
import 'package:upen/screen/profile/personalDetails/personalDetailController.dart';
import 'package:upen/screen/partner/partner.dart';
import 'package:upen/screen/partner/controller/partner_controller.dart';
import 'dart:ui' as ui;
import 'package:upen/screen/partner/refer_product_view.dart';

import 'controller/dashBoardController.dart';

class DashBoardView extends StatefulWidget {
  @override
  _DashBoardViewState createState() => _DashBoardViewState();
}

class _DashBoardViewState extends State<DashBoardView> {
  DashBoardController dashBoardController = Get.put(DashBoardController());
  MyWorkController _myWorkController = Get.put(MyWorkController());
  PersonalDetailsController _personalDetailsController = Get.put(PersonalDetailsController());
  PartnerController _PartnerController = Get.put(PartnerController());

  @override
  void initState() {
    // TODO: implement initState
   if(dashBoardController.getIsRecall){
     print("===============inti====================");
     _PartnerController.productCategoryDashBoard();
     dashBoardController.getBannerList();
     dashBoardController.setIsRecall(false);
   }
    super.initState();
  }

  GlobalKey imagekey = GlobalKey();
  Uint8List pngBytes;
  File capturedFile;

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: SingleChildScrollView(

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10,right: 10),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                color: Color(0xFF0F1B25),
                child: Container(
                  padding: EdgeInsets.only(top: 10,left: 10,right: 10),
                  width: MediaQuery.of(context).size.width,
                  child: Column(children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(

                          children: [
                            SvgPicture.asset(

                              "assets/icons/earning.svg",
                              height: 50,
                              color: Constants().mainColor,
                            ),
                            SizedBox(width: 20,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                              CommonText(text: "BALANCE"),
                              Obx(()=>CommonText(text: "₹ ${_personalDetailsController.getCurrentWallet==null ? 0:_personalDetailsController.getCurrentWallet}")),
                            ],)

                                              ],),
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [
                                    const Color(0xFFD88BBC),
                                    const Color(0xFF9361A8),
                                  ],
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  stops: [0.0, 2.0],
                                  tileMode: TileMode.clamp),
                              color: Colors.white24,
                              borderRadius: BorderRadius.all(Radius.circular(20))
                          ),
                          child: CommonText(
                              text: "Redeem Money"
                          ),
                        )

                      ],
                    ),
                    SizedBox(height: 10,),
                    Row(
                      children: List.generate(150~/2, (index) => Expanded(
                        child: Container(
                          color: index%2==0?Colors.transparent
                              :Color(0xFF1E2E46),
                          height: 2,
                        ),
                      )),
                    ),
                    SizedBox(height: 5,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                      CommonText(
                        text: "Total Earning"
                      ),
                      Obx(()=>CommonText(
                          text:  "₹ ${_personalDetailsController.getTotalWallet==null ? 0:_personalDetailsController.getTotalWallet}"
                      )),

                    ],),
                    SizedBox(height: 10,),

                  ],),
                ),
              ),
            ),
            SizedBox(height: 20,),
            SizedBox(
              height: 150,
              child: Obx(()=>CarouselSlider(
                options: CarouselOptions(height: 400.0),
                items: dashBoardController.getBanners.map((bannerIndex) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(bannerIndex.image),
                              fit: BoxFit.fill,
                            ),

                              borderRadius: BorderRadius.all(Radius.circular(15))
                          ),
                         // child: Text(bannerIndex.url, style: TextStyle(fontSize: 16.0),)
                      );
                    },
                  );
                }).toList(),
              ))
            ),
            SizedBox(height: 20,),
            sellEndEarn(),
            SizedBox(height: 5,),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: CommonText(
                  text: "Lead",
                  fontSize: 15,
                  fontStyle: FontWeight.bold
              ),
            ),
            SizedBox(height: 5,),
            Obx(() =>
            _personalDetailsController.getIsAdmin !=
                null &&
                _personalDetailsController.getIsAdmin ? Container(
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
                          SizedBox(
                            height: 5,
                          ),
                          CommonText(
                              text: "Team Status and Assignment",
                              textColor: Colors.grey,
                              fontSize: 20,
                              fontStyle: FontWeight.bold),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {
                                  Get.to(AssignLead());
                                },
                                child: Column(
                                  children: [
                                    Icon(Icons.assignment,
                                      color: Constants().mainColor,),
                                    SizedBox(height: 5),
                                    CommonText(
                                        text: "Assign Lead",
                                        textColor: Constants().mainColor)

                                  ],
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  showDialog(
                                      context: context, builder: (context) {
                                    return AlertDialog(
                                      backgroundColor: Colors.white,
                                      title: Text("Employees Lead",
                                        textAlign: TextAlign.center,),
                                      actions: [
                                        Padding(padding: EdgeInsets.only(
                                            left: 10, right: 10, bottom: 10),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment
                                                  .spaceBetween,
                                              children: [InkWell(
                                                onTap: () {
                                                  Get.to(
                                                      UserListView(type: 0,));
                                                },
                                                child: Column(
                                                  children: [
                                                    Icon(
                                                      Icons.calendar_view_month,
                                                      color: Constants()
                                                          .mainColor,),
                                                    SizedBox(height: 5),
                                                    CommonText(
                                                        text: "today",
                                                        textColor: Constants()
                                                            .mainColor)
                                                  ],
                                                ),
                                              ),
                                                InkWell(
                                                  onTap: () {
                                                    Get.to(
                                                        UserListView(type: 1,));
                                                  },
                                                  child: Column(
                                                    children: [
                                                      Icon(Icons
                                                          .calendar_view_month,
                                                        color: Constants()
                                                            .mainColor,),
                                                      SizedBox(height: 5),
                                                      CommonText(
                                                          text: "monthly",
                                                          textColor: Constants()
                                                              .mainColor)
                                                    ],
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    Get.to(
                                                        UserListView(type: 2,));
                                                  },
                                                  child: Column(
                                                    children: [
                                                      Icon(Icons
                                                          .calendar_view_month,
                                                        color: Constants()
                                                            .mainColor,),
                                                      SizedBox(height: 5),
                                                      CommonText(
                                                          text: "lifetime",
                                                          textColor: Constants()
                                                              .mainColor)
                                                    ],
                                                  ),
                                                ),
                                              ],))
                                      ],
                                    );
                                  });

                                },
                                child: Column(
                                  children: [
                                    Icon(Icons.leaderboard,
                                      color: Constants().mainColor,),
                                    SizedBox(height: 5),
                                    CommonText(
                                        text: "Employee Lead",
                                        textColor: Constants().mainColor)
                                  ],
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Get.to(PartnerView());
                                },

                                child: Column(
                                  children: [
                                    Icon(Icons.production_quantity_limits,
                                      color: Constants().mainColor,),
                                    SizedBox(height: 5),
                                    CommonText(
                                        text: "Partners",
                                        textColor: Constants().mainColor)

                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Divider(
                            thickness: 2,
                            color: Colors.grey,
                          ),
                          SizedBox(height: 10),

                        ],
                      ),
                    ))) : SizedBox(),),
            SizedBox(
              height: 20,
            ),
            Obx(() =>
            _personalDetailsController.getIsEnable !=
                null &&
                _personalDetailsController.getIsEnable ? Container(
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
                          SizedBox(
                            height: 5,
                          ),
                          CommonText(
                              text: "Today's Statistics",
                              textColor: Colors.grey,
                              fontSize: 20,
                              fontStyle: FontWeight.bold),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {
                                  Get.to(MyWork(
                                      status: "accepted_by_day_number",
                                      isHide: false));
                                },
                                child: Column(
                                  children: [

                                    CommonText(
                                        text: "Leads",
                                        textColor: Constants().mainColor)
                                  ],
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Get.to(MyWork(status: "calling_by_day_number",
                                      isHide: false));
                                },
                                child: Column(
                                  children: [

                                    CommonText(
                                        text: "Calling",
                                        textColor: Constants().mainColor)
                                  ],
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Get.to(MyWork(status: "query_by_day_number",
                                      isHide: false));
                                },
                                child: Column(
                                  children: [

                                    CommonText(
                                        text: "Query",
                                        textColor: Constants().mainColor)
                                  ],
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Get.to(MyWork(
                                      status: "rejected_by_day_number",
                                      isHide: false));
                                },
                                child: Column(
                                  children: [

                                    CommonText(
                                        text: "Rejected",
                                        textColor: Constants().mainColor)
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Divider(
                            thickness: 2,
                            color: Colors.grey,
                          ),
                          SizedBox(height: 10),
                          InkWell(onTap: (){
                            Get.to(MyWork(
                                status: "login_by_day_number",
                                isHide: false));
                          },
                            child: Row(
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
                                        textColor: Colors.grey,
                                        fontStyle: FontWeight.bold)
                                  ],
                                ),
                                Row(
                                  children: [

                                    Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      color: Constants().mainColor,
                                      size: 15,
                                    ),
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ))) : SizedBox()),
            SizedBox(
              height: 20,
            ),
            Obx(() =>
            _personalDetailsController.getIsEnable !=
                null &&
                _personalDetailsController.getIsEnable ? Container(
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
                          SizedBox(
                            height: 5,
                          ),
                          CommonText(
                              text: "Monthly Statistics",
                              textColor: Colors.grey,
                              fontSize: 20,
                              fontStyle: FontWeight.bold),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {
                                  Get.to(MyWork(
                                      status: "accepted_by_month_number",
                                      isHide: false));
                                },
                                child: Column(
                                  children: [

                                    CommonText(
                                        text: "Leads",
                                        textColor: Constants().mainColor)
                                  ],
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Get.to(MyWork(
                                      status: "calling_by_month_number",
                                      isHide: false));
                                },
                                child: Column(
                                  children: [

                                    CommonText(
                                        text: "Calling",
                                        textColor: Constants().mainColor)
                                  ],
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Get.to(MyWork(status: "query_by_month_number",
                                      isHide: false));
                                },
                                child: Column(
                                  children: [

                                    CommonText(
                                        text: "Query",
                                        textColor: Constants().mainColor)
                                  ],
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Get.to(MyWork(
                                      status: "rejected_by_month_number",
                                      isHide: false));
                                },
                                child: Column(
                                  children: [

                                    CommonText(
                                        text: "Rejected",
                                        textColor: Constants().mainColor)
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Divider(
                            thickness: 2,
                            color: Colors.grey,
                          ),
                          SizedBox(height: 10),
                          InkWell(onTap: (){

                            Get.to(MyWork(
                                status: "login_by_month_number",
                                isHide: false));

                          },
                            child: Row(
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
                                        textColor: Colors.grey,
                                        fontStyle: FontWeight.bold)
                                  ],
                                ),
                                Row(
                                  children: [

                                    Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      color: Constants().mainColor,
                                      size: 15,
                                    ),
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ))) : SizedBox()),
            SizedBox(
              height: 70,
            ),
            Obx(() =>
            _personalDetailsController.getIsEnable !=
                null &&
                _personalDetailsController.getIsEnable ? Center(
                child: InkWell(

                  onTap: () {
                    Get.to(MyWork(status: "new_number", isHide: false,));
                  },
                  child: CircleAvatar(
                    radius: 60,
                    backgroundColor: Constants().mainColor.withOpacity(0.3),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.call,
                          color: Constants().mainColor,
                          size: 30,
                        ),
                        SizedBox(height: 5,),
                        CommonText(text: "Go to Calling", fontStyle: FontWeight
                            .bold, textColor: Constants().mainColor)
                      ],
                    ),
                  ),
                )) : SizedBox())
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          showModalBottomSheet(
              backgroundColor: Constants().appBackGroundColor,
              //isScrollControlled: true,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30)),
              ),
              context: context,
              builder: (builder){
                return Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: sellEndEarn(),
                );
              }
          );
        },
        backgroundColor: Constants().inactiveColor,
        child: SvgPicture.asset("assets/icons/add.svg"),
      )
    );
  }

  Widget sellEndEarn(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      Padding(
        padding: const EdgeInsets.only(left: 20),
        child: CommonText(
            text: "Sell & Earn",
            fontSize: 15,
            fontStyle: FontWeight.bold
        ),
      ),
      SizedBox(height: 5,),
      Obx(()=>Container(
        padding: EdgeInsets.only(left: 10,right: 5),
        height:_PartnerController.getProductCategoryDashBoardList.length<=2 ? 100:200,
        child: _PartnerController.getProductCategoryDashBoardList.isEmpty? SizedBox():
        MasonryGridView.count(
          crossAxisCount:_PartnerController.getProductCategoryDashBoardList.length<=2 ? 1:2,
          mainAxisSpacing: 2,
          crossAxisSpacing: 2,
          scrollDirection: Axis.horizontal,
          itemCount: _PartnerController.getProductCategoryDashBoardList.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: (){
                Get.to(ReferPartnerView(category : _PartnerController.getProductCategoryDashBoardList[index].categoryName));
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                color: Color(0xFF1E2E46),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10,right: 10),
                  child: Container(
                    padding: EdgeInsets.only(top: 10,left: 10,right: 10),
                    width: MediaQuery.of(context).size.width/2.5,
                    child: Column(children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: CommonText(
                                text: _PartnerController.getProductCategoryDashBoardList[index].categoryName,
                                fontStyle: FontWeight.bold
                            ),
                          ),
                          Image.network(_PartnerController.getProductCategoryDashBoardList[index].categoryUrl)
                        ],),
                      SizedBox(height: 10,),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            border: Border.all(color: Colors.white24)
                        ),
                        padding: EdgeInsets.all(5),
                        child: CommonText(
                            text:_PartnerController.getProductCategoryDashBoardList[index].earnUpto,
                            fontSize: 12,
                            textColor: Colors.white
                        ),
                      )
                    ],),
                  ),
                ),
              ),
            );
          },
        ),
      )),
    ],);
  }
}