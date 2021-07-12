import 'package:flutter/material.dart';
import 'package:upen/commonWidget/commonWidget.dart';
import 'package:upen/screen/helper/constant.dart';

class MyTeamView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: CommonText(text: "My Team"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Container(
                padding: EdgeInsets.only(left: 20, right: 20),
                margin: EdgeInsets.only(top: 10),
                height: 100,
                child: Card(
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CommonText(
                                text: "₹ ${"0"}",
                                textColor: Constants().mainColor),
                            CommonText(
                                text: "Earning of This Month",
                                textColor: Constants().mainColor)
                          ],
                        ),
                        VerticalDivider(
                          color: Constants().mainColor,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CommonText(
                                text: "₹ ${"0"}",
                                textColor: Constants().mainColor),
                            CommonText(
                                text: "Earning of This Month",
                                textColor: Constants().mainColor)
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 20, right: 20),
              height: MediaQuery.of(context).size.height,
              child: ListView.builder(
                  itemCount: 25,
                  itemBuilder: (BuildContext context, index) {
                    return Container(
                      height: 100,
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Row(
                            children: [
                              CircleAvatar(
                                backgroundColor: Constants().mainColor,
                                radius: 40,
                                child: ImageNetworkTap(
                                    fit: BoxFit.fill,
                                    height: 50,
                                    width: 50,
                                    imagePathAPI:
                                        "https://i.pinimg.com/originals/0b/c3/ad/0bc3ad38b427beb0d8ff38af962aa070.png"),
                              ),
                              SizedBox(width: 20,),
                              CommonText(text: "Abhishek Mishra",textColor: Constants().mainColor)
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
