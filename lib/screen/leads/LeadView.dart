import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:upen/commonWidget/commonWidget.dart';
import 'package:upen/screen/helper/constant.dart';
import 'package:upen/screen/leads/load_controller.dart';

class LeadView extends StatefulWidget {
  @override
  _LeadViewState createState() => _LeadViewState();
}

class _LeadViewState extends State<LeadView> {
  LeadController _leadController = Get.put(LeadController());
  @override
  void initState() {
    // TODO: implement initState
    _leadController.getLead();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: CommonText(text: "My Leads"),
      ),
      body: Obx(()=> _leadController.getLeadList.isEmpty ? Center(
        child: CircularProgressIndicator(
          valueColor: new AlwaysStoppedAnimation<Color>(Colors.amber),
        ),
      ):ListView.builder(
          itemCount: _leadController.getLeadList.length,
          itemBuilder: (BuildContext contexrt, index) {
            return Card(
              child: ExpansionTile(title: Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, top: 5.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CommonText(
                            fontStyle: FontWeight.bold,
                            textColor: Constants().mainColor,
                            text: _leadController.getLeadList[index].leadType.toString().toUpperCase()),
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
                              text: _leadController.getLeadList[index].status),
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
                            text: _leadController.getLeadList[index].leadDate,
                            textColor: Constants().mainColor),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),children: [Divider(
                thickness: 1,
              ),  CommonText(
                  text: _leadController.getLeadList[index].comment,
                  textColor: Constants().mainColor),SizedBox(height: 20,)],),
            );
          })),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Constants().mainColor,
        onPressed: (){
          AddLead();

        },
        child: Icon(Icons.add),
      ),
    );
  }
}

