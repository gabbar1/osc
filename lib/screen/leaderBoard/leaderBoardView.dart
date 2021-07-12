import 'package:flutter/material.dart';
import 'package:upen/commonWidget/commonWidget.dart';
import 'package:upen/commonWidget/silverHeader.dart';
import 'package:upen/screen/helper/constant.dart';

class LeaderBoardView extends StatelessWidget {
  Widget headerBackground(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 40, right: 40, top: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [CommonText(text: "LEADS"), CommonText(text: "0")],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                children: [
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.all(Radius.circular(25))),
                    child: Icon(
                      Icons.account_circle_outlined,
                      size: 45,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: CircleAvatar(
                      radius: 15,
                      backgroundColor: Colors.grey,
                      child: Icon(
                        Icons.share,
                        size: 15,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              CommonText(text: "ABHISHEK")
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [CommonText(text: "EARNING"), CommonText(text: "0")],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SliverHeader(
      title: CommonText(text: "LeaderBoard"),
      headerBackgroundBody: headerBackground(context),
      body: ListView.builder(
          itemCount: 5,
          itemBuilder: (BuildContext context, index) {
            return Card(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 8,bottom: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Row(children: [ Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.all(Radius.circular(15))),
                        child: Icon(
                          Icons.account_circle_outlined,
                          size: 45,
                        ),
                      ),
                        SizedBox(
                          width: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CommonText(
                                text: "Abhishek Mishrs",
                                textColor: Constants().mainColor),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                CommonText(
                                    text: "Earn : ${"0"}",
                                    textColor: Constants().mainColor),
                                CommonText(
                                    text: "Leads : ${50}",
                                    textColor: Constants().mainColor)
                              ],
                            )
                          ],
                        ),],),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Constants().mainColor,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(15))),
                      height: 30,
                      width: 30,
                      child: Center(child: CommonText(text: index.toString())),

                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}
