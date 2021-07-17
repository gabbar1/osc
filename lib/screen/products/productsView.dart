import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:readmore/readmore.dart';
import 'package:upen/commonWidget/commonWidget.dart';
import 'package:upen/screen/helper/constant.dart';

class ProductsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: CommonText(
          text: "Products",
        ),
      ),
      body: Container(
        child: ListView.builder(
            itemCount: 10,
            itemBuilder: (context, index) {
              return Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        margin: EdgeInsets.only(bottom: 5),
                        height: 70,
                        width: 150,
                        child: SvgPicture.asset("assets/icons/star.svg",fit: BoxFit.fill,),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10,top: 5),
                      child: CommonText(text: "Used Vehicle Loan",textColor: Constants().mainColor,fontStyle: FontWeight.bold,fontSize: 20),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5,top: 5,right: 10,bottom: 5),
                      child: ReadMoreText(
                          "Used Vehicle LoanUsed Vehicle LoanUsed Vehicle LoanUsed Vehicle LoanUsed Vehicle \n"
                              "LoanUsed Vehicle LoanUsed Vehicle LoanUsed Vehicle LoanUsed Vehicle LoanUsed \n\n"
                              " KYC \n"
                              " Aadhar card \n"
                              " PAN card Vehicle LoanUsed Vehicle LoanUsed Vehicle LoanUsed Vehicle LoanUsed Vehicle LoanUsed Vehicle LoanUsed Vehicle LoanUsed Vehicle LoanUsed Vehicle LoanUsed Vehicle LoanUsed Vehicle LoanUsed Vehicle LoanUsed Vehicle LoanUsed Vehicle LoanUsed Vehicle LoanUsed Vehicle LoanUsed Vehicle LoanUsed Vehicle LoanUsed Vehicle LoanUsed Vehicle LoanUsed Vehicle LoanUsed Vehicle LoanUsed Vehicle LoanUsed Vehicle LoanUsed Vehicle LoanUsed Vehicle LoanUsed Vehicle LoanUsed Vehicle LoanUsed Vehicle LoanUsed Vehicle LoanUsed Vehicle LoanUsed Vehicle LoanUsed Vehicle LoanUsed Vehicle LoanUsed Vehicle LoanUsed Vehicle LoanUsed Vehicle LoanUsed Vehicle LoanUsed Vehicle LoanUsed Vehicle LoanUsed Vehicle LoanUsed Vehicle LoanUsed Vehicle LoanUsed Vehicle LoanUsed Vehicle LoanUsed Vehicle LoanUsed Vehicle LoanUsed Vehicle LoanUsed Vehicle LoanUsed Vehicle LoanUsed Vehicle LoanUsed Vehicle LoanUsed Vehicle LoanUsed Vehicle LoanUsed Vehicle LoanUsed Vehicle LoanUsed Vehicle LoanUsed Vehicle LoanUsed Vehicle LoanUsed Vehicle LoanUsed Vehicle LoanUsed Vehicle LoanUsed Vehicle LoanUsed Vehicle LoanUsed Vehicle LoanUsed Vehicle LoanUsed Vehicle LoanUsed Vehicle LoanUsed Vehicle LoanUsed Vehicle LoanUsed Vehicle LoanUsed Vehicle LoanUsed Vehicle LoanUsed Vehicle LoanUsed Vehicle LoanUsed Vehicle LoanUsed Vehicle LoanUsed Vehicle LoanUsed Vehicle LoanUsed Vehicle LoanUsed Vehicle LoanUsed Vehicle LoanUsed Vehicle LoanUsed Vehicle LoanUsed Vehicle LoanUsed Vehicle LoanUsed Vehicle LoanUsed Vehicle LoanUsed Vehicle LoanUsed Vehicle LoanUsed Vehicle LoanUsed Vehicle LoanUsed Vehicle LoanUsed Vehicle LoanUsed Vehicle LoanUsed Vehicle LoanUsed Vehicle LoanUsed Vehicle LoanUsed Vehicle LoanUsed Vehicle LoanUsed Vehicle LoanUsed Vehicle LoanUsed Vehicle LoanUsed Vehicle LoanUsed Vehicle Loan",
                        trimLines: 2,
                        colorClickableText: Colors.pink,
                        trimMode: TrimMode.Line,
                        trimCollapsedText: 'Show more',
                        trimExpandedText: 'Show less',
                        style: TextStyle(fontSize: 14,color: Constants().mainColor),
                        moreStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold,color: Constants().mainColor),),
                    )

                  ],
                ),
              );
            }),
      ),
      floatingActionButton: FloatingActionButton(backgroundColor: Constants().mainColor,onPressed: (){
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
                                mainAxisAlignment:
                                MainAxisAlignment
                                    .spaceBetween,
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
                                  Icon(Icons
                                      .arrow_forward_ios_rounded)
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  )),
            ));
      },child: Icon(Icons.add),),
    );
  }
}
