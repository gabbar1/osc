import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:upen/commonWidget/commonWidget.dart';
import 'package:upen/screen/helper/constant.dart';

class LeadView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: CommonText(text: "My Leads"),
      ),
      body: ListView.builder(
          itemCount: 4,
          itemBuilder: (BuildContext contexrt, index) {
            return Card(
              child: Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, top: 5.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CommonText(
                            fontStyle: FontWeight.bold,
                            textColor: Constants().mainColor,
                            text: "Home Loan".toString().toUpperCase()),
                        Container(
                          margin: EdgeInsets.all(8),
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                              border: Border.all(color: Constants().mainColor)),
                          child: CommonText(
                              fontStyle: FontWeight.bold,
                              textColor: Constants().mainColor,
                              text: "Document Pending"),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                CommonText(
                                    text: "Lead BY - ", textColor: Colors.grey),
                                CommonText(
                                    text: "Abhishek Mishra ",
                                    textColor: Constants().mainColor),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                CommonText(
                                    text: "Assign To - ",
                                    textColor: Colors.grey),
                                CommonText(
                                    text: "Abhishek Mishra ",
                                    textColor: Constants().mainColor),
                              ],
                            ),
                          ],
                        ),
                        InkWell(
                          onTap: () {},
                          child: Column(
                            children: [
                              Icon(
                                Icons.access_time,
                                color: Constants().mainColor,
                              ),
                              CommonText(
                                  text: "Reminder",
                                  textColor: Constants().mainColor)
                            ],
                          ),
                        )
                      ],
                    ),
                    Divider(
                      thickness: 1,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CommonText(
                            text: "Create Date :", textColor: Colors.grey),
                        CommonText(
                            text: "08/06/2021",
                            textColor: Constants().mainColor),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CommonText(
                            text: "Close Date :  ", textColor: Colors.grey),
                        CommonText(
                            text: "08/06/2021",
                            textColor: Constants().mainColor),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Constants().mainColor,
        onPressed: (){
          CommonBottomSheet().bottomSheet(
              context: context,
              content: Padding(
                padding: const EdgeInsets.only(
                    top: 10,
                    left: 20,
                    right: 20,
                    bottom: 10),
                child: Container(
                    height: MediaQuery.of(context)
                        .size
                        .height /
                        2.5,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          ListView.builder(
                              shrinkWrap: true,
                              itemCount: 2,
                              itemBuilder:
                                  (context, index) {
                                return Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment
                                      .start,
                                  children: [
                                    Row(
                                      children: [
                                        CommonText(
                                            text:
                                            "Loan",
                                            textColor:
                                            Constants()
                                                .mainColor),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Expanded(
                                            child:
                                            Container(
                                              width: MediaQuery.of(
                                                  context)
                                                  .size
                                                  .width -
                                                  100,
                                              height: 2,
                                              color: Constants()
                                                  .mainColor,
                                            ))
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Container(
                                      height: MediaQuery.of(
                                          context)
                                          .size
                                          .height /
                                          12,
                                      child: ListView
                                          .builder(
                                          shrinkWrap:
                                          true,
                                          scrollDirection:
                                          Axis
                                              .horizontal,
                                          itemCount:
                                          3,
                                          itemBuilder:
                                              (context,
                                              index) {
                                            return Container(
                                              padding:
                                              EdgeInsets.only(right: 50),
                                              child:
                                              Column(
                                                children: [
                                                  ImageNetworkTap(height: 20, width: 20, imagePathAPI: "https://e7.pngegg.com/pngimages/567/773/png-clipart-computer-icons-home-black-home-icon-miscellaneous-angle-thumbnail.png"),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  CommonText(text: "Home Loan", textColor: Constants().mainColor),
                                                  SizedBox(
                                                    height: 20,
                                                  )
                                                ],
                                              ),
                                            );
                                          }),
                                    ),
                                  ],
                                );
                              }),
                          SingleChildScrollView(
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    CommonText(
                                        text:
                                        "Credit Card",
                                        textColor:
                                        Constants()
                                            .mainColor),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Expanded(
                                      child: Container(
                                        width: MediaQuery.of(
                                            context)
                                            .size
                                            .width -
                                            100,
                                        height: 2,
                                        color: Constants()
                                            .mainColor,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Card(
                                      color: Constants()
                                          .mainColor,
                                      clipBehavior: Clip
                                          .antiAliasWithSaveLayer,
                                      shape:
                                      RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius
                                            .circular(
                                            20.0),
                                      ),
                                      elevation: 0,
                                      child: Center(
                                        child:
                                        Container(
                                          margin:
                                          EdgeInsets
                                              .all(
                                              8),
                                          padding:
                                          EdgeInsets
                                              .all(
                                              8),
                                          height: 50,
                                          width: 60,
                                          child: SvgPicture
                                              .asset(
                                              "assets/icons/card.svg"),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Column(
                                      children: [
                                        CommonText(
                                            text:
                                            "Get a Extra Credit Line",
                                            textColor:
                                            Constants()
                                                .mainColor,
                                            fontSize:
                                            22),
                                        CommonText(
                                          text:
                                          "Give yourSelf a financial protection",
                                          textColor:
                                          Constants()
                                              .mainColor,
                                        )
                                      ],
                                    ),
                                    Spacer(),
                                    Icon(Icons.arrow_forward_ios_rounded)
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    )),
              ));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
