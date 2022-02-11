import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:get/get.dart';
import 'package:upen/commonWidget/commonWidget.dart';
import 'package:upen/screen/helper/constant.dart';
import 'package:upen/screen/myWork/controller/my_work_controller.dart';
import 'package:upen/screen/profile/personalDetails/personalDetailController.dart';

import 'model/contact_model.dart';

//https://cardkarobar.in/referal.html?ID=8200127649&product=demat&name=upstocx

class MyWork extends StatefulWidget {
  MyWork({this.status, this.isHide});

  String status = "new_number";
  bool isHide = false;

  @override
  _MyWorkState createState() => _MyWorkState();
}

class _MyWorkState extends State<MyWork> {
  MyWorkController _myWorkController = Get.put(MyWorkController());
  PersonalDetailsController _personalDetailsController =
      Get.put(PersonalDetailsController());
  CommonBottomSheet _commonBottomSheet = CommonBottomSheet();

  @override
  void initState() {
    // TODO: implement initState

   // _myWorkController.getUserList();
   // _personalDetailsController.personalDetails();


    if(widget.status =="new_number"){
      print("''''''''''''''''''''_myWorkController.getContactList(status: widget.status);''");
      if(!_myWorkController.getIsPreventNewCalling){
        print("''''''''''''''''''''tatus);''");

        _myWorkController.setIsPreventNewCalling(true);
        _myWorkController.getContactList(status: widget.status);
      }
    }else{
      _myWorkController.getHistoryLeadLists(status: widget.status);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: widget.isHide
          ? null
          : AppBar(
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);

                },
                icon: Icon(
                  Icons.arrow_back_ios_outlined,
                  color: Colors.white,
                ),
              ),
              title: Text("My Work"),
              centerTitle: true,
        actions: [
          widget.status=="new_number"?
          Obx(()=>CircleAvatar(backgroundColor: Constants().mainColor.withOpacity(0.5),child: Text(_myWorkController.getContacts.length.toString()),)):
          Obx(()=>CircleAvatar(backgroundColor: Constants().mainColor.withOpacity(0.5),child: Text(_myWorkController.getHistoryLeadList.length.toString()),)),SizedBox(width: 20,)],
            ),
      body: widget.status=="new_number"? Obx(() => _myWorkController.getContacts.isEmpty
          ? Center(
        child: CircularProgressIndicator(
          valueColor:
          new AlwaysStoppedAnimation<Color>(Constants().mainColor),
        ),
      )
          : Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
            itemCount: _myWorkController.getContacts.length,
            itemBuilder: (context, index) {
              return Card(
                color: Colors.white,
                child: InkWell(
                  onTap: () {
                    Get.to(StatusUpdate(
                      index: index,
                      isNewEntry: false,
                      userContactModel:
                      _myWorkController.getContacts[index],
                      status: widget.status,
                    ));
                  },
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
                                SizedBox(
                                  width:
                                  MediaQuery.of(context).size.width *
                                      .6,
                                  child: Text(
                                    _myWorkController
                                        .getContacts[index].name,
                                    style: TextStyle(fontSize: 15),
                                  ),
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.location_on),
                                    CommonText(
                                        text:
                                        "${_myWorkController.getContacts[index].city} ( ${_myWorkController.getContacts[index].state})",
                                        textColor: Colors.black,
                                        fontSize: 10),
                                  ],
                                ),

                                /* CommonText(
                                              text:
                                              "${_myWorkController.getContacts[index].comment}",
                                              textColor: Colors.black,
                                              fontSize: 10),*/
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 50.0, right: 5),
                            child: IconButton(
                                onPressed: () {
                                  FlutterPhoneDirectCaller.callNumber(
                                      _myWorkController
                                          .getContacts[index].mobile);
                                },
                                icon: CircleAvatar(
                                    backgroundColor: Constants()
                                        .mainColor
                                        .withOpacity(0.4),
                                    child: Icon(
                                      Icons.call,
                                      color: Constants().mainColor,
                                      size: 20,
                                    ))),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }),
      )):
      Obx(() => _myWorkController.getHistoryLeadList.isEmpty
          ? Center(
        child: CircularProgressIndicator(
          valueColor:
          new AlwaysStoppedAnimation<Color>(Constants().mainColor),
        ),
      )
          : Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
            itemCount: _myWorkController.getHistoryLeadList.length,
            itemBuilder: (context, index) {
              return Card(
                color: Colors.white,
                child: InkWell(
                  onTap: () {
                    Get.to(StatusUpdate(
                      index: index,
                      isNewEntry: false,
                      userContactModel:
                      _myWorkController.getHistoryLeadList[index],
                      status: widget.status,
                    ));
                  },
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
                                SizedBox(
                                  width:
                                  MediaQuery.of(context).size.width *
                                      .6,
                                  child: Text(
                                    _myWorkController
                                        .getContacts[index].name,
                                    style: TextStyle(fontSize: 15),
                                  ),
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.location_on),
                                    CommonText(
                                        text:
                                        "${_myWorkController.getHistoryLeadList[index].city} ( ${_myWorkController.getHistoryLeadList[index].state})",
                                        textColor: Colors.black,
                                        fontSize: 10),
                                  ],
                                ),

                                /* CommonText(
                                              text:
                                              "${_myWorkController.getHistoryLeadList[index].comment}",
                                              textColor: Colors.black,
                                              fontSize: 10),*/
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 50.0, right: 5),
                            child: IconButton(
                                onPressed: () {
                                  FlutterPhoneDirectCaller.callNumber(
                                      _myWorkController
                                          .getContacts[index].mobile);
                                },
                                icon: CircleAvatar(
                                    backgroundColor: Constants()
                                        .mainColor
                                        .withOpacity(0.4),
                                    child: Icon(
                                      Icons.call,
                                      color: Constants().mainColor,
                                      size: 20,
                                    ))),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }),
      )),
      floatingActionButton: Obx(() =>
          _personalDetailsController.getIsAdmin != null &&
                  _personalDetailsController.getIsAdmin
              ? FloatingActionButton(
                  onPressed: () {
                    Get.to(StatusUpdate(
                      isNewEntry: true,
                    ));
                    /*   _commonBottomSheet.bottomSheet(
                    context: Get.context,
                    title: "Assign Phone Numbers",
                    content: userList(_myWorkController.getUsersList));*/
                  },
                  child: Icon(Icons.add),
                  backgroundColor: Constants().mainColor,
                )
              : SizedBox()),
    );
  }
}

class StatusUpdate extends StatefulWidget {
  StatusUpdate(
      {this.userContactModel, this.status, this.isNewEntry, this.index});

  UserContactModel userContactModel;
  String status = "new_number";
  bool isNewEntry = false;
  int index = 0;

  @override
  _StatusUpdateState createState() => _StatusUpdateState();
}

class _StatusUpdateState extends State<StatusUpdate> {
  StatusCharacter _character = StatusCharacter.a;
  LeadCharacter _leadType = LeadCharacter.a;
  MyWorkController _myWorkController = Get.find();
  String existingBank;
  String cardBank;
  String appliedBank;
  String leadStatus = "--Lead Type--";
  String leadSerougate = "--Lead Type--";

  var items;

  @override
  void initState() {
    // TODO: implement initState
    _myWorkController.clearText();
    if (widget.isNewEntry == false) {
      _myWorkController.applicationController.text =
          widget.userContactModel.application;
      _myWorkController.nameController.text = widget.userContactModel.name;
      _myWorkController.phoneController.text = widget.userContactModel.mobile;
      if (widget.userContactModel.isCalled != null &&
          widget.userContactModel.isCalled) {
        _myWorkController.c2cController.text =
            widget.userContactModel.cardLimit;
        _myWorkController.salaryController.text =
            widget.userContactModel.salary;
        _myWorkController.businessController.text = widget.userContactModel.itr;
        _myWorkController.commentController.text =
            widget.userContactModel.comment;
        print(
            "-------------------------------------LeadType-------------------");

        print(widget.userContactModel.leadResult);
        print(widget.userContactModel.leadType);
        if (widget.userContactModel.leadResult == "StatusCharacter.a") {
          _character = StatusCharacter.a;
          leadStatus = 'Interested';
        } else if (widget.userContactModel.leadResult == "StatusCharacter.b") {
          _character = StatusCharacter.b;
          leadStatus = 'Not-Interested';
        } else if (widget.userContactModel.leadResult == "StatusCharacter.c") {
          _character = StatusCharacter.c;
          leadStatus = 'Query';
        } else if (widget.userContactModel.leadResult == "StatusCharacter.d") {
          _character = StatusCharacter.d;
          leadStatus = 'Lead-Closed';
        } else if (widget.userContactModel.leadResult == "StatusCharacter.e") {
          _character = StatusCharacter.e;
          leadStatus = 'Lead-Rejected';
        } else if (widget.userContactModel.leadResult == "StatusCharacter.f") {
          _character = StatusCharacter.f;
          leadStatus = 'Lead-Login';
        }
        if (widget.userContactModel.leadType == "LeadCharacter.a") {
          _leadType = LeadCharacter.a;
           leadSerougate ='Salary';

        } else if (widget.userContactModel.leadType == "LeadCharacter.b") {
          _leadType = LeadCharacter.b;
          leadSerougate = 'Business';
        } else if (widget.userContactModel.leadType == "LeadCharacter.c") {
          _leadType = LeadCharacter.c;
          leadSerougate = 'C2C';
        }else if (widget.userContactModel.leadType == "LeadCharacter.d") {
    _leadType = LeadCharacter.b;
    leadSerougate = 'Car';
    }else if (widget.userContactModel.leadType == "LeadCharacter.e") {
    _leadType = LeadCharacter.b;
    leadSerougate =  'Cibil';
    }
    print("==============widget.userContactModel.existingBank===========");
        print(widget.userContactModel.existingBank);
        cardBank = widget.userContactModel.existingBank;
        appliedBank = widget.userContactModel.appliedBank;
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Status"),
        centerTitle: true,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: new BorderRadius.only(
                topLeft: const Radius.circular(25.0),
                topRight: const Radius.circular(25.0))),
        child: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 10),
            child: Column(
              children: [
                CommonTextInput1(
                    labeltext: "Name",
                    inputController: _myWorkController.nameController),
                SizedBox(
                  height: 10,
                ),
                CommonTextInput1(
                    labeltext: "Mobile",
                    inputController: _myWorkController.phoneController),
                SizedBox(
                  height: 10,
                ),
                widget.isNewEntry
                    ? CommonTextInput1(
                        labeltext: "State",
                        inputController: _myWorkController.stateController)
                    : SizedBox(),
                widget.isNewEntry
                    ? SizedBox(
                        height: 10,
                      )
                    : SizedBox(),
                widget.isNewEntry
                    ? CommonTextInput1(
                        labeltext: "City",
                        inputController: _myWorkController.cityController)
                    : SizedBox(),
                widget.isNewEntry
                    ? SizedBox(
                        height: 10,
                      )
                    : SizedBox(),
                widget.isNewEntry
                    ? CommonTextInput1(
                        textInputType: TextInputType.number,
                        labeltext: "Zip Code",
                        inputController: _myWorkController.zipController)
                    : SizedBox(),
                widget.isNewEntry
                    ? SizedBox(
                        height: 10,
                      )
                    : SizedBox(),
                widget.isNewEntry
                    ? CommonTextInput1(
                        labeltext: "Designation",
                        inputController:
                            _myWorkController.designationController)
                    : SizedBox(),
                widget.isNewEntry
                    ? SizedBox(
                        height: 10,
                      )
                    : SizedBox(),
                Container(
                  padding: const EdgeInsets.all(3.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.grey)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10, top: 10),
                        child: CommonText(
                            text: "Status",
                            textColor: Constants().mainColor,
                            fontSize: 25),
                      ),
                      DropdownButtonFormField<String>(
                        value: leadStatus,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          // labelText: "Existing Bank",
                        ),
                        items: <String>[
                          '--Lead Type--',
                          'Interested',
                          'Not-Interested',
                          'Query',
                          'Lead-Closed',
                          'Lead-Rejected',
                          'Lead-Login'
                        ].map((String value) {
                          setState(() {
                            existingBank = value;
                          });
                          return DropdownMenuItem<String>(
                            onTap: () {
                              setState(() {
                                if (value == "Interested") {
                                  _character = StatusCharacter.a;
                                } else if (value == "Not-Interested") {
                                  _character = StatusCharacter.b;
                                } else if (value == "Query") {
                                  _character = StatusCharacter.c;
                                } else if (value == "Lead-Closed") {
                                  _character = StatusCharacter.d;
                                } else if (value == "Lead-Rejected") {
                                  _character = StatusCharacter.e;
                                } else if (value == "Lead-Login") {
                                  _character = StatusCharacter.f;
                                }
                              });
                            },
                            value: existingBank,
                            child: CommonText(
                                text: existingBank,
                                textColor: Constants().mainColor),
                          );
                        }).toList(),
                        validator: (value) {
                          print("-----------ValidatedOr not------------");
                          print(value);
                          if (value == null) {
                            return 'Field required';
                          }
                          return null;
                        },
                        onChanged: (val) {},
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                if (_character == StatusCharacter.f) ...{
                  CommonTextInput1(
                      inputController: _myWorkController.applicationController,
                      labeltext: "Application No:",
                      textInputAction: TextInputAction.next),
                },
                SizedBox(
                  height: 10,
                ),
                if (_character == StatusCharacter.a) ...{
                  Container(
                    padding: const EdgeInsets.all(3.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.grey)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10, top: 10),
                          child: CommonText(
                              text: "Lead Type",
                              textColor: Constants().mainColor,
                              fontSize: 25),
                        ),
                        DropdownButtonFormField<String>(
                          value: leadSerougate,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            // labelText: "Existing Bank",
                          ),
                          items: <String>[
                            '--Lead Type--',
                            'Salary',
                            'Business',
                            'C2C',
                            'Car',
                            'Cibil',
                          ].map((String value) {
                            setState(() {
                              leadSerougate = value;
                            });
                            return DropdownMenuItem<String>(
                              onTap: () {
                                setState(() {
                                  if (value == "Salary") {
                                    _leadType = LeadCharacter.a;
                                  } else if (value == "Business") {
                                    _leadType = LeadCharacter.b;
                                  } else if (value == "C2C") {
                                    _leadType = LeadCharacter.c;
                                  } else if (value == "Car") {
                                    _leadType = LeadCharacter.d;
                                  } else if (value == "Cibil") {
                                    _leadType = LeadCharacter.e;
                                  }
                                });
                              },
                              value: leadSerougate,
                              child: CommonText(
                                  text: leadSerougate,
                                  textColor: Constants().mainColor),
                            );
                          }).toList(),
                          validator: (value) {
                            print("-----------ValidatedOr not------------");
                            print(value);
                            if (value == null) {
                              return 'Field required';
                            }
                            return null;
                          },
                          onChanged: (val) {},
                        ),
                      ],
                    ),
                  ),
                },
                SizedBox(
                  height: 10,
                ),
                if (_character == StatusCharacter.a &&
                    _leadType == LeadCharacter.c) ...{
                  DropdownButtonFormField<String>(
                    value: cardBank,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      labelText: "Existing Bank",
                    ),
                    items: <String>[
                      '--Select Bank--',
                      'Axis',
                      'BOB',
                      'HDFC',
                      "Yes",
                      "SBI",
                      "ICICI",
                      "RBL",
                      "IndusInd"
                    ].map((String value) {
                      setState(() {
                        cardBank = value;
                      });
                      return DropdownMenuItem<String>(
                        onTap: () {
                          cardBank = value;
                        },
                        value: cardBank,
                        child: CommonText(
                            text: cardBank, textColor: Constants().mainColor),
                      );
                    }).toList(),
                    validator: (value) {
                      print("-----------ValidatedOr not------------");
                      print(value);
                      if (value == null) {
                        return 'Field required';
                      }
                      return null;
                    },
                    onChanged: (val) {},
                  ),
                },
                if (_character == StatusCharacter.a &&
                    _leadType == LeadCharacter.a) ...{
                  CommonTextInput1(
                      inputController: _myWorkController.salaryController,
                      labeltext: "Enter Monthly Salary",
                      textInputAction: TextInputAction.next,
                      textInputType: TextInputType.number),
                },
                if (_character == StatusCharacter.a &&
                    _leadType == LeadCharacter.b) ...{
                  CommonTextInput1(
                      inputController: _myWorkController.businessController,
                      labeltext: "Enter ITR Amount",
                      textInputAction: TextInputAction.next,
                      textInputType: TextInputType.number),
                },
                if (_character == StatusCharacter.a &&
                    _leadType == LeadCharacter.c) ...{
                  CommonTextInput1(
                      inputController: _myWorkController.c2cController,
                      labeltext: "Enter Card Limit",
                      textInputAction: TextInputAction.next,
                      textInputType: TextInputType.number),
                },
                SizedBox(
                  height: 10,
                ),
                if (_character == StatusCharacter.a &&
                    _character == StatusCharacter.a) ...{
                  DropdownButtonFormField<String>(
                    value: appliedBank,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      labelText: "Applied Bank",
                    ),
                    items: <String>[
                      '--Select Bank--',
                      'Axis',
                      'BOB',
                      'HDFC',
                      "Yes",
                      "SBI",
                      "ICICI",
                      "RBL",
                      "IndusInd"
                    ].map((String value) {
                      setState(() {
                        appliedBank = value;
                      });
                      return DropdownMenuItem<String>(
                        onTap: () {
                          appliedBank = value;
                        },
                        value: value,
                        child: CommonText(
                            text: value, textColor: Constants().mainColor),
                      );
                    }).toList(),
                    validator: (value) {
                      print("-----------ValidatedOr not------------");
                      print(value);
                      if (value == null) {
                        return 'Field required';
                      }
                      return null;
                    },
                    onChanged: (val) {},
                  ),
                },
                CommonTextInput1(
                    maxLines: 5,
                    minLines: 5,
                    inputController: _myWorkController.commentController,
                    labeltext: "Comment",
                    textInputAction: TextInputAction.done,
                    textInputType: TextInputType.name),
                SizedBox(
                  height: 10,
                ),
                CommonButton(
                    buttonText: "Submit",
                    vPadding: 20,
                    buttonColor: Constants().mainColor,
                    onPressed: () {
                      if (widget.isNewEntry) {
                        // _myWorkController.nameController
                        if (_myWorkController.nameController.text.isEmpty) {
                          Get.snackbar("Alert", "Name should not be Empty");
                        } else if (_myWorkController
                            .phoneController.text.isEmpty) {
                          Get.snackbar("Alert", "Phone should not be Empty");
                        } else if (_myWorkController
                            .stateController.text.isEmpty) {
                          Get.snackbar("Alert", "State should not be Empty");
                        } else if (_myWorkController
                            .cityController.text.isEmpty) {
                          Get.snackbar("Alert", "City should not be Empty");
                        } else if (_myWorkController
                            .designationController.text.isEmpty) {
                          Get.snackbar(
                              "Alert", "Designation should not be Empty");
                        } else if (_myWorkController
                            .applicationController.text.isEmpty) {
                          Get.snackbar(
                              "Alert", "Application No: should not be Empty");
                        } else if (_myWorkController
                            .zipController.text.isEmpty) {
                          Get.snackbar("Alert", "zip should not be Empty");
                        } else {
                          UserContactModel _userContactModel = UserContactModel(
                            mobile: _myWorkController.phoneController.text,
                            city: _myWorkController.cityController.text,
                            name: _myWorkController.nameController.text,
                            email: _myWorkController.emailController.text,
                            state: _myWorkController.stateController.text,
                            status: true,
                            comment: _myWorkController.commentController.text,
                            salary: _myWorkController.salaryController.text,
                            application:
                                _myWorkController.applicationController.text,
                            designation:
                                _myWorkController.designationController.text,
                            itr: _myWorkController.businessController.text,
                            cardLimit: _myWorkController.c2cController.text,
                            appliedBank: appliedBank,
                            assignedTo: FirebaseAuth
                                .instance.currentUser.phoneNumber
                                .replaceAll("+91", ""),
                            existingBank: cardBank,
                            leadResult: _character.toString(),
                            leadType: _leadType.toString(),
                            zip: _myWorkController.zipController.text,
                            callDate: DateTime.now().toIso8601String(),
                            isCalled: true,
                            testCallDate: Timestamp.now(),
                          );
                          _myWorkController.UpdateLead(_userContactModel,
                              isUpdate: false, status: widget.status,index: widget.index);
                          //_myWorkController.removeIndexValue(widget.index);
                          //_myWorkController.getTeamList();
                          // _myWorkController.getContactList(status: widget.status);
                        }
                      } else {
                        UserContactModel _userContactModel = UserContactModel(
                            mobile: widget.userContactModel.mobile,
                            secondNumber: widget.userContactModel.secondNumber,
                            city: widget.userContactModel.city,
                            name: _myWorkController.nameController.text,
                            email: widget.userContactModel.email,
                            state: widget.userContactModel.state,
                            status: widget.userContactModel.status,
                            comment: _myWorkController.commentController.text,
                            salary: _myWorkController.salaryController.text,
                            application:
                                _myWorkController.applicationController.text,
                            designation: widget.userContactModel.designation,
                            itr: _myWorkController.businessController.text,
                            cardLimit: _myWorkController.c2cController.text,
                            key: widget.userContactModel.key,
                            appliedBank: appliedBank,
                            assignedTo: widget.userContactModel.assignedTo,
                            existingBank: cardBank,
                            leadResult: _character.toString(),
                            leadType: _leadType.toString(),
                            zip: widget.userContactModel.zip,
                            callDate: DateTime.now().toIso8601String(),
                            isCalled: true,
                            testCallDate: Timestamp.now());
                        _myWorkController.UpdateLead(_userContactModel,
                            isUpdate: true, status: widget.status,index: widget.index);
                        //_myWorkController.removeIndexValue(widget.index);
                       // _myWorkController.getTeamList();
                        //_myWorkController.getContactList(status: widget.status);
                      }
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AssignLead extends StatefulWidget {
  AssignLead();

  @override
  _AssignLeadState createState() => _AssignLeadState();
}

class _AssignLeadState extends State<AssignLead> {
  MyWorkController _myWorkController = Get.find();
  SearchByValue _searchByValue = SearchByValue.a;
  TextEditingController assignController = TextEditingController();
  TextEditingController unAssignController = TextEditingController();

  Widget userList(List<UserContactModel> userList) {

    return userList.isEmpty
        ? Center(
            child: CircularProgressIndicator(
              valueColor:
                  new AlwaysStoppedAnimation<Color>(Constants().mainColor),
            ),
          )
        : Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CommonText(
                            text: 'City',
                            textColor: Colors.black,
                            fontSize: 18),
                        Radio<SearchByValue>(
                          activeColor: Constants().mainColor,
                          value: SearchByValue.a,
                          groupValue: _searchByValue,
                          onChanged: (SearchByValue value) {
                            _myWorkController.searchByCityController.clear();
                            _myWorkController.contacCategoryList.value.clear();
                            _myWorkController.contacCategoryList.refresh();
                            setState(() {
                              print("-------------------");
                              print(_searchByValue);
                              _searchByValue = value;
                            });
                          },
                        ),
                        CommonText(
                            text: 'State',
                            textColor: Colors.black,
                            fontSize: 18),
                        Radio<SearchByValue>(
                          activeColor: Constants().mainColor,
                          value: SearchByValue.b,
                          groupValue: _searchByValue,
                          onChanged: (SearchByValue value) {
                            _myWorkController.searchByCityController.clear();
                            _myWorkController.contacCategoryList.value.clear();
                            _myWorkController.contacCategoryList.refresh();
                            setState(() {
                              _searchByValue = value;
                            });
                          },
                        ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                              onTap: () {
                                _myWorkController.uploadData();
                              },
                              child: CircleAvatar(
                                backgroundColor: Constants().mainColor,
                                radius: 25,
                                child: CommonText(text: "upload"),
                              )),
                        )
                      ],
                    ),
                    CommonTextInput1(
                        inputController:
                            _myWorkController.searchByCityController,
                        labeltext: _searchByValue == SearchByValue.a
                            ? "Search by City"
                            : "Search by State"),
                    Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * .7,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(right: 5.0, bottom: 10),
                              child: CommonTextInput1(
                                  inputController:
                                      _myWorkController.searchLimitController,
                                  labeltext: "Search Limit"),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 5, left: 20, bottom: 10),
                            child: SizedBox(
                              width: 50,
                              child: Obx(() => DropdownButtonFormField(
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                      labelText: "version",
                                    ),
                                    items: _myWorkController.getVersionData
                                        .map((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: new Text(value),
                                      );
                                    }).toList(),
                                    onChanged: (val) {
                                      print(
                                          "---------------value----------------");
                                      print(val);
                                      _myWorkController.setSelectedVersion(val);
                                    },
                                  )),
                            ),
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Constants().mainColor,
                            ),
                            onPressed: () {
                              //  _myWorkController. updateList();
                              FocusScope.of(context).unfocus();
                              _myWorkController.getSearchList(
                                  limit: int.parse(_myWorkController
                                      .searchLimitController.text),
                                  searchKey: _myWorkController
                                      .searchByCityController.text,
                                  searchType: _searchByValue == SearchByValue.a
                                      ? "city"
                                      : "state");
                            },
                            child: Text("Search")),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Constants().mainColor,
                            ),
                            onPressed: () {
                              // AssignToEmployee( userController.getUserList);
                            },
                            child: Obx(() => Text(_myWorkController
                                        .getContactCategoryList.length !=
                                    0
                                ? _searchByValue == SearchByValue.a
                                    ? _myWorkController
                                            .getContactCategoryList.first.city +
                                        " has " +
                                        _myWorkController
                                            .getContactCategoryList.length
                                            .toString()
                                    : _myWorkController.getContactCategoryList
                                            .first.state +
                                        " has " +
                                        _myWorkController
                                            .getContactCategoryList.length
                                            .toString()
                                : "Search Data"))),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    SizedBox(
                      //  height: 100,
                      width: MediaQuery.of(context).size.width / 2,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 50,
                            child: TextField(
                              controller: assignController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Assign Data',
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding: const EdgeInsets.only(
                                    left: 14.0, bottom: 6.0, top: 8.0),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Constants().mainColor),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Constants().mainColor),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                              onChanged: (val) {
                                print(userList.length);
                                print(val);
                                /* _myWorkController.getUsersList.where((element) => element.name.contains(val));
                                _myWorkController.userList.refresh();*/

                                setState(() {
                                  userList.where(
                                      (element) => element.name.contains(val));
                                  print(userList
                                      .where((element) =>
                                          element.name.contains(val))
                                      .length);
                                  print(userList.length);
                                });
                              },
                            ),
                          ),
                          SizedBox(
                            height: 50,
                            child: Card(
                              color: Constants().mainColor,
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20, top: 10, bottom: 10),
                                  child: CommonText(
                                      text: "Assign Data",
                                      textColor: Colors.white,
                                      fontSize: 15),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 200,
                            child: ListView.builder(
                              //scrollDirection: Axis.vertical,
                              itemCount: userList.length,
                              shrinkWrap: true,
                              padding: EdgeInsets.all(10),
                              itemBuilder: (context, index) {
                                if (assignController.text.isEmpty) {
                                  return InkWell(
                                    onTap: () {
                                      _myWorkController.updateData(
                                          name: userList[index].name,
                                          mobile: userList[index].mobile);
                                    },
                                    child: Card(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(userList[index].name),
                                      ),
                                    ),
                                  );
                                } else if (userList[index]
                                    .name
                                    .toLowerCase()
                                    .contains(assignController.text)) {
                                  return InkWell(
                                    onTap: () {
                                      _myWorkController.updateData(
                                          name: userList[index].name,
                                          mobile: userList[index].mobile);
                                    },
                                    child: Card(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(userList[index].name),
                                      ),
                                    ),
                                  );
                                } else {
                                  return Container();
                                }
                                return InkWell(
                                  onTap: () {
                                    _myWorkController.updateData(
                                        name: userList[index].name,
                                        mobile: userList[index].mobile);
                                  },
                                  child: Card(
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: assignController.text.isEmpty
                                            ? CommonText(
                                                text: userList[index].name,
                                                textColor: Colors.red,
                                                fontSize: 15)
                                            : CommonText(
                                                text: userList[index]
                                                        .name
                                                        .contains(
                                                            assignController
                                                                .text)
                                                    ? userList[index].name
                                                    : userList[index].name,
                                                textColor: Colors.red,
                                                fontSize: 15),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      //  height: 100,
                      width: MediaQuery.of(context).size.width / 2,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 50,
                            child: TextField(
                              controller: unAssignController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Un-Assign Data',
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding: const EdgeInsets.only(
                                    left: 14.0, bottom: 6.0, top: 8.0),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Constants().mainColor),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Constants().mainColor),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                              onChanged: (val) {
                                print(val);
                                setState(() {});
                              },
                            ),
                          ),
                          SizedBox(
                            height: 50,
                            child: Card(
                              color: Constants().mainColor,
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20, top: 10, bottom: 10),
                                  child: CommonText(
                                      text: "Un-Assign Data",
                                      textColor: Colors.white,
                                      fontSize: 15),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 200,
                            child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: userList.length,
                              shrinkWrap: true,
                              padding: EdgeInsets.all(10),
                              itemBuilder: (context, index) {
                                if (unAssignController.text.isEmpty) {
                                  return InkWell(
                                    onTap: () {
                                      _myWorkController.getUnAssignList(
                                          mobile: userList[index].mobile);
                                    },
                                    child: Card(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(userList[index].name),
                                      ),
                                    ),
                                  );
                                } else if (userList[index]
                                    .name
                                    .toLowerCase()
                                    .contains(unAssignController.text)) {
                                  return InkWell(
                                    onTap: () {
                                      _myWorkController.getUnAssignList(
                                          mobile: userList[index].mobile);
                                    },
                                    child: Card(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(userList[index].name),
                                      ),
                                    ),
                                  );
                                } else {
                                  return Container();
                                }
                                return InkWell(
                                  onTap: () {
                                    _myWorkController.getUnAssignList(
                                        mobile: userList[index].mobile);
                                  },
                                  child: Card(
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: CommonText(
                                            text: userList[index].name,
                                            textColor: Colors.red,
                                            fontSize: 15),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Divider(
                thickness: 5,
              ),
              CommonText(
                  text: "--------------UnAssign Number--------------",
                  textColor: Constants().mainColor,
                  fontSize: 20),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Constants().mainColor,
                  ),
                  onPressed: () {
                    // AssignToEmployee( userController.getUserList);
                    _myWorkController.UnAssignContactList();
                  },
                  child: Obx(() => Text(
                      _myWorkController.getUnAssignListList.length != 0
                          ? _myWorkController.getUnAssignListList.length
                                  .toString() +
                              " can be unAssigned"
                          : "UnAssign Data"))),
            ],
          );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Lead"),
        centerTitle: true,
      ),
      body: Obx(() => userList(_myWorkController.getUsersList
          .where((element) => element.isEnabled == true)
          .toList())),
    );
  }

  @override
  void initState() {
    _myWorkController.getUserList();
    _myWorkController.getVersion();
    _myWorkController.searchByCityController.clear();
    _myWorkController.searchByStateController.clear();
    _myWorkController.contacCategoryList.clear();
    _myWorkController.unAssignList.clear();
    _myWorkController.searchLimitController.text = "150";
  }
}
