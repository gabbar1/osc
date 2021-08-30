import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upen/commonWidget/commonWidget.dart';
import 'package:upen/screen/helper/constant.dart';
import 'package:upen/screen/team/team_controller.dart';

class MyTeamView extends StatefulWidget {
  @override
  _MyTeamViewState createState() => _MyTeamViewState();
}

class _MyTeamViewState extends State<MyTeamView> {
  TeamController teamController = Get.put(TeamController());
  @override
  void initState() {
    // TODO: implement initState
    teamController.getLead();
    super.initState();
  }

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
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 3,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Obx(() => CommonText(
                                  text:
                                      "₹ ${teamController.getThisMonthEarning}",
                                  textColor: Constants().mainColor)),
                              SizedBox(
                                height: 5,
                              ),
                              CommonText(
                                  text: "This Month",
                                  textColor: Constants().mainColor)
                            ],
                          ),
                        ),
                        VerticalDivider(
                          color: Constants().mainColor,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 3,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Obx(
                                () => CommonText(
                                    text:
                                        "₹ ${teamController.getThisTotalEarning}",
                                    textColor: Constants().mainColor),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              CommonText(
                                  text: "Total Earnings",
                                  textColor: Constants().mainColor)
                            ],
                          ),
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
              child: Obx(()=> teamController.getTeamList.isEmpty ?Center(
              child: CircularProgressIndicator(
    valueColor: new AlwaysStoppedAnimation<Color>(Colors.amber),
    ),
    ):ListView.builder(
                  itemCount: teamController.getTeamList.length,
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
                              SizedBox(
                                width: 20,
                              ),
                              CommonText(
                                  text: teamController.getTeamList[index],
                                  textColor: Constants().mainColor)
                            ],
                          ),
                        ),
                      ),
                    );
                  })),
            )
          ],
        ),
      ),
    );
  }
}
