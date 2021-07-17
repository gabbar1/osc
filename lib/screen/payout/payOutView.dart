import 'package:flutter/material.dart';
import 'package:upen/commonWidget/commonWidget.dart';
import 'package:upen/screen/helper/constant.dart';

class PayOutView extends StatefulWidget {
  @override
  _PayOutViewState createState() => _PayOutViewState();
}

class _PayOutViewState extends State<PayOutView> {
  List<String> dropDownList = <String>[
    "All",
    "Saving Account",
    "Credit Card",
    "Used Vehicle Loan",
    "Home Loan",
    "Personal Loan",
    "Business Loan"
  ];
  String selectedPayout;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: CommonText(text: "Payout"),
      ),
      body: Card(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            CommonText(
                text: "Select Payouts for", textColor: Constants().mainColor),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.only(left: 10, right: 20),
              margin: EdgeInsets.only(left: 10, right: 10),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(5)),
              child: DropdownButton(
                underline: SizedBox(),
                isExpanded: true,
                hint: CommonText(
                    text: "Select Category",
                    fontSize: 14,
                    textColor: Colors.black),
                value: selectedPayout,
                onChanged: (newValue) {
                  setState(() {
                    selectedPayout = newValue;
                  });
                },
                items: dropDownList.map((pay) {
                  return DropdownMenuItem(
                    child: Text(pay),
                    value: pay,
                  );
                }).toList(),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(left: 10, right: 20),
                margin: EdgeInsets.only(left: 10, right: 10),
               
                child: ListView.builder(
                  shrinkWrap: true,
                    itemCount: 10,
                    itemBuilder: (BuildContext context, index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CommonText(
                              text: "Business Loan",
                              textColor: Constants().mainColor),
                          SizedBox(height: 10,),
                          Container(
                            height: MediaQuery.of(context).size.height / 5,
                            child: ListView.builder(
                                shrinkWrap: true,
                              //  physics: ClampingScrollPhysics(),
                                physics: ScrollPhysics(),
                                itemCount: 5,
                                itemBuilder: (BuildContext context, index) {
                                  return Container(
                                    padding:
                                        EdgeInsets.only(left: 40, right: 40),
                                    height: 30,
                                    decoration: BoxDecoration(
                                        color: index == 0
                                            ? Constants().mainColor
                                            : Colors.white,
                                      border: Border.all(color:
                                           Constants().mainColor
                                          )
                                    ),

                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        CommonText(
                                            text: "Bui",
                                            textColor: index != 0
                                                ? Constants().mainColor
                                                : Colors.white),
                                        CommonText(
                                            text: "Bui",
                                            textColor: index != 0
                                                ? Constants().mainColor
                                                : Colors.white),
                                      ],
                                    ),
                                  );
                                }),
                          )
                        ],
                      );
                    }),
              ),
            )
          ],
        ),
      ),
    );
  }
}
