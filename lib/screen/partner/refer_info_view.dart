import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:html/parser.dart';
import 'package:share/share.dart';
import 'package:upen/commonWidget/commonWidget.dart';
import 'package:upen/screen/helper/constant.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../myWork/controller/my_work_controller.dart';
import '../myWork/model/contact_model.dart';
import '../profile/personalDetails/personalDetailController.dart';
import 'controller/partner_controller.dart';
import 'customer_details.dart';
import 'model/leadModel.dart';
import 'model/referModel.dart';
import 'package:flutter_html/flutter_html.dart';

class ReferInfoView extends StatefulWidget {
  ReferModel referModel;

  ReferInfoView({this.referModel});

  @override
  _ReferInfoViewState createState() => _ReferInfoViewState();
}

class _ReferInfoViewState extends State<ReferInfoView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  PartnerController _partnerController = Get.put(PartnerController());
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  List<String> productInstructionList = <String>[
    "Benefits",
    "Description",
    "How to Earn",
    "FAQ's"
  ];
  YoutubePlayerController _controller;

  @override
  void initState() {
    // TODO: implement initState
    nameController.clear();
    emailController.clear();
    phoneController.clear();
    _partnerController.referralInfo(widget.referModel.key);
    _partnerController.setCategoryIndex(0);

    _controller = YoutubePlayerController(
      initialVideoId: widget.referModel.youtube,
      flags: YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(_partnerController.getAboutList.length);

    return Scaffold(
      appBar: AppBar(
        title: CommonText(text: widget.referModel.name),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 50,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: productInstructionList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: InkWell(
                      onTap: () {
                        _partnerController.setCategoryIndex(index);
                      },
                      child: Container(
                        padding: EdgeInsets.only(
                            left: 20, right: 20, top: 10, bottom: 10),
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: [
                                  const Color(0xFFD88BBC),
                                  const Color(0xFF9361A8),
                                ],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                stops: [0.0, 2.0],
                                tileMode: TileMode.clamp),
                            color: Colors.white24,
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        child: Center(
                            child: CommonText(
                                text: productInstructionList[index])),
                      ),
                    ),
                  );
                }),
          ),
          Expanded(child: Obx(() {
            if (_partnerController.getCategoryIndex == 0) {
              return about();
            } else if (_partnerController.getCategoryIndex == 1) {
              return knowMore();
            } else if (_partnerController.getCategoryIndex == 2) {
              return howToEarn();
            } else {
              return faq();
            }
          }))
        ],
      ),
      floatingActionButton: widget.referModel.url == "static"
          ? Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: InkWell(
                  onTap: () {
                    /* final RenderBox box = Get.context.findRenderObject();
              widget.referModel.name;
              widget.referModel.price;
              var referralID =FirebaseAuth.instance.currentUser.phoneNumber.replaceAll("+91", "");
              Share.share("https://cardkarobar.in/referal.html?id=$referralID&product=${widget.referModel.name}&price=${widget.referModel.price}", sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
*/

                    Get.to(StatusUpdate(
                      appliedBank: widget.referModel.name,
                      referModel: widget.referModel,
                    ));
                  },
                  child: Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width / 2,
                      //width: 300,
                      decoration: const BoxDecoration(
                          color: Color(0xffFFFFFF),
                          borderRadius: BorderRadius.all(
                            Radius.circular(5.0),
                          )),
                      child: Center(
                        child: Text(
                          "Refer To Customer",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                      )),
                ),
              ),
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    final RenderBox box = Get.context.findRenderObject();
                    widget.referModel.name;
                    widget.referModel.price;
                    var referralID = FirebaseAuth
                        .instance.currentUser.phoneNumber
                        .replaceAll("+91", "");
                    Share.share(
                        "https://cardkarobar.in/referal.html?id=$referralID&product=${widget.referModel.name}&price=${widget.referModel.price}",
                        sharePositionOrigin:
                            box.localToGlobal(Offset.zero) & box.size);
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width / 2.5,
                        //width: 300,
                        decoration: const BoxDecoration(
                            color: Color(0xffFFFFFF),
                            borderRadius: BorderRadius.all(
                              Radius.circular(5.0),
                            )),
                        child: Center(
                          child: Text(
                            "Refer To Customer",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                        )),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                InkWell(
                  onTap: () {
                    nameController.clear();
                    emailController.clear();
                    phoneController.clear();
                    showModalBottomSheet(
                        backgroundColor: Constants().appBackGroundColor,
                        isScrollControlled: true,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30)),
                        ),
                        context: context,
                        builder: (context) {
                          return Form(
                              key: _formKey,
                              child: SizedBox(
                                height: MediaQuery.of(context).size.width,
                                child: Padding(
                                  padding: MediaQuery.of(context).viewInsets,
                                  child: Container(
                                    height: 400,
                                    padding:
                                        EdgeInsets.only(left: 20, right: 20),
                                    child: SingleChildScrollView(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 25,
                                          ),
                                          CommonText(
                                              text: "Customer Details",
                                              fontSize: 20),
                                          SizedBox(
                                            height: 25,
                                          ),
                                          CommonTextInput1(
                                              textInputAction:
                                                  TextInputAction.next,
                                              hint: "Enter Name",
                                              labeltext: "Name",
                                              inputController: nameController),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          CommonTextInput1(
                                              textInputAction:
                                                  TextInputAction.next,
                                              hint: "Enter Email",
                                              labeltext: "Email",
                                              inputController: emailController),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          CommonTextInput1(
                                              maxLines: 10,
                                              textInputType:
                                                  TextInputType.number,
                                              textInputAction:
                                                  TextInputAction.done,
                                              hint: "Enter Phone",
                                              labeltext: "Phone",
                                              inputController: phoneController),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Center(
                                            child: CommonButton(
                                                buttonText: "Submit",
                                                buttonColor:
                                                    Constants().mainColor,
                                                vPadding: 20,
                                                onPressed: () {
                                                  if (_formKey.currentState
                                                      .validate()) {
                                                    LeadModel leadModel =
                                                        LeadModel(
                                                      status: "submitted",
                                                      customerEmail:
                                                          emailController.text,
                                                      customerName:
                                                          nameController.text,
                                                      customerPhone: int.parse(
                                                          phoneController.text),
                                                      product: widget
                                                          .referModel.name,
                                                      referralId: int.parse(
                                                          FirebaseAuth
                                                              .instance
                                                              .currentUser
                                                              .phoneNumber
                                                              .replaceAll(
                                                                  "+91", "")),
                                                      referralPrice: widget
                                                          .referModel.price,
                                                      time: Timestamp.now(),
                                                    );
                                                    _partnerController
                                                        .submitReferral(
                                                            leadModel,
                                                            widget.referModel
                                                                .url);
                                                  }
                                                }),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ));
                        });
                  },
                  child: Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width / 2.5,
                      //width: 300,
                      decoration: const BoxDecoration(
                          color: Color(0xffFFFFFF),
                          borderRadius: BorderRadius.all(
                            Radius.circular(5.0),
                          )),
                      child: Center(
                        child: Text(
                          "Open Account",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                      )),
                ),
              ],
            ),
    );
  }

  Widget about() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10, top: 10),
            child:
                CommonText(text: "Watch video for steps to sell", fontSize: 20),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: YoutubePlayer(
              controller: _controller,
              showVideoProgressIndicator: true,
              onReady: () {},
            ),
          ),
          SizedBox(
            height: 20,
          ),
          ListView.builder(
              shrinkWrap: true,
              itemCount: _partnerController.getAboutList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    padding: EdgeInsets.only(left: 20, right: 20, bottom: 0),
                    child: Html(
                      data: _partnerController.getAboutList[index].html,
                      style: {
                        "body": Style(
                          margin: EdgeInsets.zero,
                          padding: EdgeInsets.zero,
                        )
                      },
                    ),
                  ),
                );
              }),
        ],
      ),
    );
  }

  Widget faq() {
    return ListView.builder(
        padding: EdgeInsets.only(bottom: 100),
        shrinkWrap: true,
        itemCount: _partnerController.getFaqList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: EdgeInsets.only(left: 20, right: 20, bottom: 0),
              child: Html(
                data: _partnerController.getFaqList[index].html,
                style: {
                  "body": Style(
                    margin: EdgeInsets.zero,
                    padding: EdgeInsets.zero,
                  )
                },
              ),
            ),
          );
        });
  }

  Widget howToEarn() {
    return ListView.builder(
        padding: EdgeInsets.only(bottom: 100),
        shrinkWrap: true,
        itemCount: _partnerController.getHowToEarnListList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: EdgeInsets.only(left: 20, right: 20, bottom: 0),
              child: Html(
                data: _partnerController.getHowToEarnListList[index].html,
                style: {
                  "body": Style(
                    margin: EdgeInsets.zero,
                    padding: EdgeInsets.zero,
                  )
                },
              ),
            ),
          );
        });
  }

  Widget knowMore() {
    return ListView.builder(
        padding: EdgeInsets.only(bottom: 100),
        shrinkWrap: true,
        itemCount: _partnerController.getKnowMoreList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: EdgeInsets.only(left: 20, right: 20, bottom: 0),
              child: Html(
                data: _partnerController.getKnowMoreList[index].html,
                style: {
                  "body": Style(
                    margin: EdgeInsets.zero,
                    padding: EdgeInsets.zero,
                  )
                },
              ),
            ),
          );
        });
  }
}

class StatusUpdate extends StatefulWidget {
  StatusUpdate({this.appliedBank, this.referModel});

  ReferModel referModel;
  String appliedBank;

  @override
  _StatusUpdateState createState() => _StatusUpdateState();
}

class _StatusUpdateState extends State<StatusUpdate> {
  StatusCharacter _character = StatusCharacter.a;
  LeadCharacter _leadType = LeadCharacter.a;
  PartnerController _partnerController = Get.find();
  String existingBank;
  String cardBank;
  String appliedBank;
  String leadStatus = "--Lead Type--";
  String leadSerougate = "--Lead Type--";
  String existingCreditCard = "--Select Bank--";
  var items;
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController salaryController = TextEditingController();
  TextEditingController businessController = TextEditingController();
  TextEditingController c2cController = TextEditingController();
  TextEditingController commentController = TextEditingController();
  TextEditingController leadBankController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    clearText();
    leadBankController.text = widget.appliedBank;
    super.initState();
  }

  clearText() {
    salaryController.clear();
    businessController.clear();
    c2cController.clear();
    nameController.clear();
    phoneController.clear();
    cityController.clear();
    stateController.clear();
    commentController.clear();
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
            color: Constants().appBackGroundColor,
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
                    hint: "Enter Customer Name",
                    inputController: nameController),
                SizedBox(
                  height: 10,
                ),
                CommonTextInput1(
                    labeltext: "Enter Customer Email",
                    hint: "Enter Customer Email",
                    inputController: emailController),
                SizedBox(
                  height: 10,
                ),
                CommonTextInput1(
                    hint: "Enter Customer Mobile",
                    inputController: phoneController),
                SizedBox(
                  height: 10,
                ),
                CommonTextInput1(
                    hint: "Enter Customer State",
                    inputController: stateController),
                SizedBox(
                  height: 10,
                ),
                CommonTextInput1(
                    hint: "Enter Customer City",
                    inputController: cityController),
                SizedBox(
                  height: 10,
                ),
                CommonTextInput1(
                    hint: "Enter Applied Bank",
                    isReadOnly: true,
                    inputController: leadBankController),
                SizedBox(
                  height: 10,
                ),
                if (widget.referModel.type == "Credit Card") ...[
                  Container(
                    child: Column(
                      children: [
                        if (_character == StatusCharacter.a) ...{
                          Container(
                            decoration: const BoxDecoration(
                              color: Color(0xff0F1B25),
                              borderRadius: BorderRadius.all(
                                Radius.circular(5.0),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 10, top: 10),
                                  child: CommonText(text: "Choose Lead Type"),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 10, top: 10),
                                  child: DropdownButtonFormField<String>(
                                    dropdownColor:
                                        Constants().appBackGroundColor,
                                    value: leadSerougate,
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.zero,
                                        ),
                                        enabledBorder: InputBorder.none,
                                        disabledBorder: InputBorder.none,
                                        focusedBorder: InputBorder.none
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
                                            leadStatus = value;
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
                                        child: CommonText(text: leadSerougate),
                                      );
                                    }).toList(),
                                    validator: (value) {
                                      print(
                                          "-----------ValidatedOr not------------");
                                      print(value);
                                      if (value == null) {
                                        return 'Field required';
                                      }
                                      return null;
                                    },
                                    onChanged: (val) {},
                                  ),
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
                          Container(
                            decoration: const BoxDecoration(
                              color: Color(0xff0F1B25),
                              borderRadius: BorderRadius.all(
                                Radius.circular(5.0),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 10, top: 10),
                                  child:
                                      CommonText(text: "Choose Existing Bank"),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 10, top: 10),
                                  child: DropdownButtonFormField<String>(
                                    dropdownColor:
                                        Constants().appBackGroundColor,
                                    value: cardBank,
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.zero,
                                        ),
                                        enabledBorder: InputBorder.none,
                                        disabledBorder: InputBorder.none,
                                        focusedBorder: InputBorder.none
                                        // labelText: "Existing Bank",
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
                                        print(existingCreditCard);
                                        cardBank = value;
                                      });
                                      return DropdownMenuItem<String>(
                                        onTap: () {
                                          setState(() {
                                            existingCreditCard = value;
                                          });

                                          //cardBank = value;
                                        },
                                        value: cardBank,
                                        child: CommonText(
                                          text: cardBank,
                                        ),
                                      );
                                    }).toList(),
                                    validator: (value) {
                                      print(
                                          "-----------ValidatedOr not------------");
                                      print(value);
                                      if (value == null) {
                                        return 'Field required';
                                      }
                                      return null;
                                    },
                                    onChanged: (val) {},
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          )
                        },
                        if (_character == StatusCharacter.a &&
                            _leadType == LeadCharacter.a) ...{
                          CommonTextInput1(
                              inputController: salaryController,
                              hint: "Enter Monthly Salary",
                              textInputAction: TextInputAction.next,
                              textInputType: TextInputType.number),
                        },
                        if (_character == StatusCharacter.a &&
                            _leadType == LeadCharacter.b) ...{
                          CommonTextInput1(
                              inputController: businessController,
                              hint: "Enter ITR Amount",
                              textInputAction: TextInputAction.next,
                              textInputType: TextInputType.number),
                        },
                        if (_character == StatusCharacter.a &&
                            _leadType == LeadCharacter.c) ...{
                          CommonTextInput1(
                              inputController: c2cController,
                              hint: "Enter Card Limit",
                              textInputAction: TextInputAction.next,
                              textInputType: TextInputType.number),
                        },
                        SizedBox(
                          height: 10,
                        ),
                        CommonTextInput1(
                            maxLines: 5,
                            minLines: 5,
                            inputController: commentController,
                            hint: "Enter any Comment",
                            textInputAction: TextInputAction.done,
                            textInputType: TextInputType.name),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ] else if (widget.referModel.type == "Insurance" ) ...[
                  SizedBox(
                    height: 10,
                  ),
                  CommonTextInput1(
                      maxLines: 5,
                      minLines: 5,
                      inputController: commentController,
                      hint: "Enter any Comment",
                      textInputAction: TextInputAction.done,
                      textInputType: TextInputType.name),
                  SizedBox(
                    height: 10,
                  ),
                ],
                CommonButton(
                    buttonText: "Submit",
                    vPadding: 20,
                    buttonColor: Constants().mainColor,
                    onPressed: () {
                      // nameController
                      if (widget.referModel.type == "Credit Card"){
                        if (nameController.text.isEmpty) {
                          Get.snackbar("Alert", "Name should not be Empty");
                        }
                        else if (emailController.text.isEmpty) {
                          Get.snackbar(
                              "Alert", "Email Address should not be Empty");
                        }
                        else if (phoneController.text.isEmpty) {
                          Get.snackbar(
                              "Alert", "Mobile Number should not be Empty");
                        }
                        else if (stateController.text.isEmpty) {
                          Get.snackbar("Alert", "State should not be Empty");
                        } else if (cityController.text.isEmpty) {
                          Get.snackbar("Alert", "City should not be Empty");
                        }
                        else if (leadStatus == '--Lead Type--') {
                          Get.snackbar(
                              "Alert", "Customer type should not be Empty");
                        }
                        else if (leadStatus == 'Salary' &&
                            salaryController.text.isEmpty) {
                          Get.snackbar("Alert", "Enter Customer Monthly Salary");
                        } else if (leadStatus == 'Business' &&
                            businessController.text.isEmpty) {
                          Get.snackbar("Alert", "Enter Customer ITR Amount");
                        } else if (leadStatus == 'C2C' &&
                            existingCreditCard == "--Select Bank--" &&
                            c2cController.text.isEmpty) {
                          Get.snackbar("Alert", "Enter Existing Card Bank Name");
                        } else if (leadStatus == 'C2C' &&
                            existingCreditCard != "--Select Bank--" &&
                            c2cController.text.isEmpty) {
                          Get.snackbar("Alert", "Enter Existing Card Bank Name");
                        } else {
                          LeadModel leadModel = LeadModel(
                            status: "submitted",
                            customerEmail: emailController.text,
                            customerName: nameController.text,
                            customerPhone: int.parse(phoneController.text),
                            product: widget.referModel.name,
                            referralId: int.parse(FirebaseAuth
                                .instance.currentUser.phoneNumber
                                .replaceAll("+91", "")),
                            referralPrice: widget.referModel.price,
                            comment: commentController.text,
                            customerCardLimit: c2cController.text,
                            customerCity: cityController.text,
                            customerItr: businessController.text,
                            customerLeadType: leadStatus,
                            customerSalary: salaryController.text,
                            customerState: stateController.text,
                            time: Timestamp.now(),
                          );
                          _partnerController.submitReferral(
                              leadModel, widget.referModel.url);
                        }
                      }else{
                        if (nameController.text.isEmpty) {
                          Get.snackbar("Alert", "Name should not be Empty");
                        }
                        else if (emailController.text.isEmpty) {
                          Get.snackbar(
                              "Alert", "Email Address should not be Empty");
                        }
                        else if (phoneController.text.isEmpty) {
                          Get.snackbar(
                              "Alert", "Mobile Number should not be Empty");
                        }
                        else if (stateController.text.isEmpty) {
                          Get.snackbar("Alert", "State should not be Empty");
                        }
                        else if (cityController.text.isEmpty) {
                          Get.snackbar("Alert", "City should not be Empty");
                        }
                        else {
                          LeadModel leadModel = LeadModel(
                            status: "submitted",
                            customerEmail: emailController.text,
                            customerName: nameController.text,
                            customerPhone: int.parse(phoneController.text),
                            product: widget.referModel.name,
                            referralId: int.parse(FirebaseAuth
                                .instance.currentUser.phoneNumber
                                .replaceAll("+91", "")),
                            referralPrice: widget.referModel.price,
                            comment: commentController.text,
                            customerCardLimit: c2cController.text,
                            customerCity: cityController.text,
                            customerItr: businessController.text,
                            customerLeadType: leadStatus,
                            customerSalary: salaryController.text,
                            customerState: stateController.text,
                            time: Timestamp.now(),
                          );
                          _partnerController.submitReferral(
                              leadModel, widget.referModel.url);
                        }
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
