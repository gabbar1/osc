import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:upen/commonWidget/commonWidget.dart';
import 'package:upen/screen/helper/constant.dart';

class EarningScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 30, top: 20),
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    CommonText(
                        text: "Current Balance",
                        textColor: Constants().mainColor,
                        fontSize: 16),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: <Widget>[
                        CommonText(
                            text: "₹",
                            textColor: Constants().mainColor,
                            fontSize: 40),
                        SizedBox(
                          width: 10,
                        ),
                        CommonText(
                            text: "2000.25",
                            textColor: Constants().mainColor,
                            fontSize: 35),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * .10,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 10,
                      ),
                    ]),
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 18.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        child: Row(
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                Text("₹" + "" + "2000.0"),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Text("Total Earning"),
                              ],
                            ),
                            SizedBox(
                              width: 80,
                            ),
                            Column(
                              children: <Widget>[
                                Text("₹" + "" + "200.0"),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Text("Withdraw"),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Container(
                width: MediaQuery.of(context).size.width * .1,
                height: MediaQuery.of(context).size.height * .11,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 10,
                      ),
                    ]),
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        child: Column(
                          children: <Widget>[
                            Text("No Transaction Found"),
                            SizedBox(
                              height: 5.0,
                            ),
                            InkWell(
                              onTap: () {},
                              child: Container(
                                width: 100,
                                height: 30,
                                decoration: BoxDecoration(
                                  color: Constants().mainColor,
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: Center(
                                  child: Text(
                                    "Retry",
                                    style: TextStyle(fontSize: 16,color: Colors.white),
                                  ),
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
            Container(
              alignment: Alignment.bottomRight,
              child: InkWell(
                onTap: () {},
                child: Container(

                  width: 100,
                  height: 30,
                  decoration: BoxDecoration(
                    color: Constants().mainColor,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Center(
                    child: Text(
                      "Withdraw",
                      style: TextStyle(fontSize: 16,color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ],

        ),

      ),
    );
  }
}
