import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:get/get.dart';
import 'package:upen/commonWidget/commonWidget.dart';
import 'package:upen/commonWidget/loader.dart';
import 'package:upen/screen/helper/constant.dart';

import 'my_work.dart';
import 'controller/user_list_controller.dart';

class UserListView extends StatefulWidget {
  UserListView({this.type});
  int type=0;
  @override
  _UserListViewState createState() => _UserListViewState();
}

class _UserListViewState extends State<UserListView> {
  UserListController _userListController = Get.put(UserListController());
  @override
  void initState() {
    // TODO: implement initState
    _userListController.getUserList();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      print("");
    });
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: CommonText(text: "Employees "),
      ),
      body: Obx(() => _userListController.getUsersList.isEmpty
          ? Center(
        child: CircularProgressIndicator(
          valueColor:
          new AlwaysStoppedAnimation<Color>(Constants().mainColor),
        ),
      )
          : Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
            itemCount: _userListController.getUsersList.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: (){
                  _userListController.getUserLeadDetails(_userListController.getUsersList[index].mobile,_userListController.getUsersList[index].name,_userListController.getUsersList[index].isEnabled);
                  showModalBottomSheet(
                      context: context,
                      builder: (builder){
                        return new Container(
                          height: 350.0,
                          color: Colors.transparent, //could change this to Color(0xFF737373),
                          //so you don't have to change MaterialApp canvasColor
                          child: Obx(()=> _userListController
                              .getUserDetailsList.isEmpty ? Center(
                            child: CircularProgressIndicator(
                              valueColor:
                              new AlwaysStoppedAnimation<Color>(Constants().mainColor),
                            ),
                          ):AlertDialog(
                            title: Text("Lead Status"),
                            content:     Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    CommonText(
                                        text: _userListController
                                            .getUserDetailsList.first
                                            ==
                                            null
                                            ? "0"
                                            : widget.type ==0 ? _userListController
                                            .getUserDetailsList.first
                                            .userData
                                            .where((element) => element.isCalled!=null &&element.isCalled && DateTime.now().difference(DateTime.parse(element.callDate)).inHours<24).length.toString():widget.type ==1 ? _userListController
                                            .getUserDetailsList.first
                                            .userData
                                            .where((element) => element.isCalled!=null &&element.isCalled && DateTime.now().difference(DateTime.parse(element.callDate)).inDays<30).length.toString():_userListController
                                            .getUserDetailsList.first
                                            .userData
                                            .where((element) => element.isCalled!=null &&element.isCalled ).length.toString(),
                                        textColor: Colors.black,
                                        fontSize: 15),
                                    CommonText(
                                        text: "Calling",
                                        textColor: Colors.black,
                                        fontSize: 10),
                                  ],
                                ),
                                Column(
                                  children: [
                                    CommonText(
                                        text: _userListController
                                            .getUserDetailsList.first
                                            .userData ==
                                            null
                                            ? "0"
                                            :  widget.type==0 ? _userListController
                                            .getUserDetailsList.first
                                            .userData.where((element) => element.isCalled!=null &&element.isCalled && DateTime.now().difference(DateTime.parse(element.callDate)).inHours<24 && element.leadResult =="StatusCharacter.a").length.toString():widget.type==1 ? _userListController
                                            .getUserDetailsList.first
                                            .userData.where((element) => element.isCalled!=null &&element.isCalled && DateTime.now().difference(DateTime.parse(element.callDate)).inDays<30 && element.leadResult =="StatusCharacter.a").length.toString()
                                            :_userListController.getUserDetailsList.first.userData.where((element) => element.isCalled!=null &&element.isCalled && element.leadResult =="StatusCharacter.a").length.toString(),

                                        textColor: Colors.black,
                                        fontSize: 15),
                                    CommonText(
                                        text: "Lead",
                                        textColor: Colors.black,
                                        fontSize: 10),
                                  ],
                                ),
                                Column(
                                  children: [
                                    CommonText(
                                        text: _userListController
                                            .getUserDetailsList.first
                                            .userData ==
                                            null
                                            ? "0"
                                            :  widget.type==0 ? _userListController
                                            .getUserDetailsList.first
                                            .userData.where((element) => element.isCalled!=null &&element.isCalled && DateTime.now().difference(DateTime.parse(element.callDate)).inHours<24 && element.leadResult =="StatusCharacter.c").length.toString():widget.type==1?_userListController
                                            .getUserDetailsList.first
                                            .userData.where((element) => element.isCalled!=null &&element.isCalled && DateTime.now().difference(DateTime.parse(element.callDate)).inDays<30 && element.leadResult =="StatusCharacter.c").length.toString():_userListController
                                            .getUserDetailsList.first
                                            .userData.where((element) => element.isCalled!=null &&element.isCalled && element.leadResult =="StatusCharacter.c").length.toString(),
                                        textColor: Colors.black,
                                        fontSize: 15),
                                    CommonText(
                                        text: "Query",
                                        textColor: Colors.black,
                                        fontSize: 10),
                                  ],
                                ),
                                Column(
                                  children: [
                                    CommonText(
                                        text: _userListController
                                            .getUserDetailsList.first
                                            .userData ==
                                            null
                                            ? "0"
                                            :  widget.type==0 ? _userListController
                                            .getUserDetailsList.first
                                            .userData.where((element) => element.isCalled!=null &&element.isCalled && DateTime.now().difference(DateTime.parse(element.callDate)).inHours<24 && element.leadResult =="StatusCharacter.b").length.toString():widget.type ==1 ? _userListController
                                            .getUserDetailsList.first
                                            .userData.where((element) => element.isCalled!=null &&element.isCalled && DateTime.now().difference(DateTime.parse(element.callDate)).inDays<30 && element.leadResult =="StatusCharacter.b").length.toString():_userListController
                                            .getUserDetailsList.first
                                            .userData.where((element) => element.isCalled!=null &&element.isCalled &&  element.leadResult =="StatusCharacter.b").length.toString(),
                                        textColor: Colors.black,
                                        fontSize: 15),
                                    CommonText(
                                        text: "Rejected",
                                        textColor: Colors.black,
                                        fontSize: 10),
                                  ],
                                ),
                              ],
                            ),
                          )),
                        );
                      }
                  );

                },
                child: Card(
                  color: Colors.white,
                  child: SizedBox(
                    height: 100,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 40),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width:
                            MediaQuery.of(context).size.width - 200,
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  _userListController
                                      .getUsersList[index].name,
                                  style: TextStyle(fontSize: 15),
                                ),
                                SizedBox(
                                  height: 10,
                                ),

                              ],
                            ),
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                ),
                                child: IconButton(
                                    onPressed: () {
                                      FlutterPhoneDirectCaller.callNumber(
                                          _userListController
                                              .getUsersList[index].mobile);
                                    },
                                    icon: CircleAvatar(
                                        backgroundColor: Constants()
                                            .mainColor
                                            .withOpacity(0.4),
                                        child: CommonText(
                                            text: _userListController
                                                .getUsersList[
                                            index]
                                                .userData ==
                                                null
                                                ? "0"
                                                : widget.type == 0 ?  _userListController
                                                .getUsersList[index]
                                                .userData.where((element) => element.isCalled!=null &&element.isCalled && DateTime.now().difference(DateTime.parse(element.callDate)).inHours<24 && element.leadResult =="StatusCharacter.a").length.toString():widget.type==1 ?  _userListController
                                                .getUsersList[index]
                                                .userData.where((element) => element.isCalled!=null &&element.isCalled && DateTime.now().difference(DateTime.parse(element.callDate)).inDays<30 && element.leadResult =="StatusCharacter.a").length.toString(): _userListController
                                                .getUsersList[index]
                                                .userData.where((element) => element.isCalled!=null &&element.isCalled &&  element.leadResult =="StatusCharacter.a").length.toString(),

                                            textColor: Colors.black))),
                              ),
                              Switch(
                                  activeColor: Constants().mainColor
                                  ,value: _userListController.getUsersList[index].isEnabled, onChanged:(_){

                                _userListController.updateStatus(!_userListController.getUsersList[index].isEnabled,_userListController.getUsersList[index].mobile);
                              } )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }),
      )),
    );
  }
}
