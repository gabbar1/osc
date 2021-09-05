import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:upen/screen/CustomerVerification/customerVerificationView.dart';
import 'package:upen/screen/customerCrediCardVerification/customerCreditCardVerification.dart';
import 'package:upen/screen/helper/constant.dart';
import 'package:upen/screen/profile/personalDetails/personalDetailController.dart';
import 'package:upen/screen/profile/profilePage.dart';
import 'package:upen/screen/startPage/startPage.dart';
import 'package:upen/test/testView.dart';
import 'dateTimePickerFromTextField.dart';

import 'dateTimePickerFromTextField.dart';


Widget CommonDropDown({
  Function onChanged,
}){
  return DropdownButton<String>(
    items: <String>['A', 'B', 'C', 'D'].map((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: new Text(value),
      );
    }).toList(),
    onChanged: onChanged,
  );
}

Widget CommonText(
    {String text,
    double fontSize = 14.00,
    Color textColor = Colors.white,

    FontWeight fontStyle = FontWeight.normal,
    bool isCenter=false}) {
  return Text(
    text,
    style:

        TextStyle(fontSize: fontSize, color: textColor, fontWeight: fontStyle,fontFamily: 'Cambria'),
        /*TextStyle(fontSize: fontSize, color: textColor, fontWeight: fontStyle),*/
    textAlign: TextAlign.center,

  );
}

Widget CommanDateTimePicker({
  String labelText = "",
}) {
  return DatePicker(
    labelText: labelText,
  );
}


Widget TextWidget({String name}) {
  return TestView(
    name: name,
  );
}



Widget CommonTextInput(
    {String lable = "",
    bool isValidationRequired = true,
    int maxLength,
    int minLength,
    int length,
    hint = "",
    labeltext = "Enter Value",
    FontWeight lableFontStyle,
    double lableFontSize,
    lableTextColor,
    TextEditingController inputController,
    TextInputType textInputType = TextInputType.text,
    String regexp,
    errortext,
    bool isRequired = false,
    bool isReadOnly = false,
      TextInputAction textInputAction = TextInputAction.done}) {

  /*int maxLength,
      int minLength,
      int length,
      hint = "",
      labeltext = "Enter Value",
      FontWeight lableFontStyle,
      double lableFontSize,
      lableTextColor,
      TextEditingController inputController,
      TextInputType textInputType = TextInputType.text,
      String regexp,
      errortext,
      bool isRequired = false}) {*/


  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: CommonText(
            text: lable,
            fontStyle: lableFontStyle,
            fontSize: lableFontSize,
            textColor: lableTextColor),
      ),
      SizedBox(
        height: 5,
      ),

      /*Container(
          padding: EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(30),
              ),
              border: Border.all(color: Colors.blue[700])),
          child:*/
      TextFormField(
        textInputAction: textInputAction,
        cursorColor:   Constants().mainColor,
        readOnly: isReadOnly,
        maxLength: maxLength,
        keyboardType: textInputType,
        controller: inputController,
        style: TextStyle(color: Constants().mainColor),
        decoration: InputDecoration(

          labelStyle:   TextStyle(color:  Constants().mainColor),
          hintText: hint,
          labelText: labeltext,
          border: new OutlineInputBorder(
            borderRadius: BorderRadius.circular(40.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xff523374), width: 2.0),
            borderRadius: BorderRadius.circular(25.0),
          ),
        ),
        validator: (value) {
          if (value.toString().isEmpty) {
            if (isValidationRequired) {
              return 'Field required';
            } else if (value.toString().isNotEmpty && isRequired) {
              if (RegExp(regexp).hasMatch(value.toString())) {
                return null;
              } else {
                return errortext;
              }
            } else {
              return null;
            }
          }
          return null;
        },
      ) //)
    ],
  );
}

class CommonDatePicker extends GetxController {
  var selectedDate = DateFormat('dd-MM-yyyy').format(DateTime.now()).obs;
  String get getSelectedDate => selectedDate.value;

  setSelectedDate(String date) {
    selectedDate.value = date;
  }

  CommonDateDropdown(
      {String text, bool futureDate = true, BuildContext context}) {
    DateTime selectedStartDate = DateTime.now();
    DateFormat formatter = DateFormat('dd-MM-yyyy');

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CommonText(
              text: text,
              fontSize: 20,
              textColor: Constants().mainColor,
              fontStyle: FontWeight.bold),
          SizedBox(height: 5),
          GestureDetector(
            onTap: () async {
              final DateTime picked = await showDatePicker(
                  context: context,
                  initialDate: selectedStartDate, // Refer step 1
                  firstDate: futureDate ? DateTime.now() : DateTime(2000),
                  lastDate: futureDate ? DateTime(3500) : DateTime.now(),
                  builder: (BuildContext context, Widget child) {
                    return Theme(
                      data: ThemeData.light().copyWith(
                        primaryColor: Constants().mainColor,
                        accentColor: Constants().mainColor,
                        colorScheme:
                            ColorScheme.light(primary: Constants().mainColor),
                        buttonTheme:
                            ButtonThemeData(textTheme: ButtonTextTheme.primary),
                      ),
                      child: child,
                    );
                  });
              print("---------------PickedDate------------------");
              print(picked);
              if (picked != null && picked != selectedStartDate) {
                selectedStartDate = picked;
                print(selectedStartDate);
              }

              // strStartDate = formatter.format(selectedStartDate);
              selectedDate(formatter.format(selectedStartDate));
            },
            child: Container(
              padding:
                  EdgeInsets.only(left: 15, right: 10, top: 11, bottom: 11),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 15,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(5)),
              child: Row(
                children: [
                  Expanded(
                    child: Obx(() => CommonText(
                        text: getSelectedDate, textColor: Colors.black87)),
                  ),
                  Icon((Icons.arrow_drop_down))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

Widget CommonInkWellButton(
    {Function onTap,
    BuildContext context,
    String buttonText,
    Color buttonTextColor,
    buttonColor,
    FontWeight buttonTextStyle,
    double buttonTextSize = 14.00,
    Color shdowColor}) {
  return InkWell(
    onTap: onTap,
    child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 15,
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: Center(
            child: CommonText(
                text: buttonText,
                textColor: buttonTextColor,
                fontStyle: buttonTextStyle,
                fontSize: buttonTextSize))),
  );
}

Widget CommonInkwellButtonProfile({
  Function onTap,
  BuildContext context,
  String buttonText,
  Color buttonTextColor,
  buttonColor,
  double width,
  double height,
  FontWeight buttonTextStyle,
  double buttonTextSize = 14.00,
  Color shdowColor
}){
  return InkWell(
    onTap: onTap,
    child: Container(
        width:width,
        height: height,
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: Center(
            child: CommonText(
                text: buttonText,
                textColor: buttonTextColor,
                fontStyle: buttonTextStyle,
                fontSize: buttonTextSize))),
  );
}


Widget CommonButton({
  Function onPressed,
  BuildContext context,
  String buttonText="My Button",
  Color buttonTextColor,
  Color buttonColor,
  Color shdowColor,
  FontWeight buttonTextStyle,
  double buttonTextSize = 14.00,
  double vPadding=25,
  double hPadding=130,
  Icon buttonIcon,
}) {
  return ElevatedButton(

    onPressed: () {
      onPressed();
    },
    child: Text(buttonText,style: TextStyle(color: buttonTextColor),),
    style: ButtonStyle(

        shadowColor: MaterialStateProperty.all(shdowColor),
        backgroundColor: MaterialStateProperty.all(buttonColor),
        padding: MaterialStateProperty.all(
            EdgeInsets.symmetric(vertical: vPadding, horizontal: hPadding)),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40.0),
                side: BorderSide(color: Constants().mainColor)))),
  );
}

Widget AppDrawer() {
  PersonalDetailsController _personalDetailsController = Get.put(PersonalDetailsController());
  _personalDetailsController.personalDetails();
  return Drawer(
    child: Column(
      // Important: Remove any padding from the ListView.

      children: <Widget>[
        DrawerHeader(
          decoration: BoxDecoration(
            color: Constants().mainColor,
          ),
          child: InkWell(onTap: (){
            Get.to(ProfileScreen(isHide: false,));
          },child: Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.black45,
                radius: 35,
                child: _personalDetailsController.getDocumentUrl.isBlank ?Icon(Icons.camera_alt_outlined):Container(

                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: Obx(()=>CachedNetworkImage(
                    imageUrl: _personalDetailsController.getDocumentUrl,
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        borderRadius:
                        BorderRadius.all(Radius.circular(50)),
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  )),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Obx(()=> CommonText(text: _personalDetailsController.getNameController.text)),
                  Obx(()=> CommonText(text: _personalDetailsController.getPhoneController.text)),
                  Obx(()=> CommonText(text: _personalDetailsController.getEmailController.text)),

                ],
              )
            ],
          ),),
        ),
        InkWell(
          child: Row(
            children: [
              Container(
                height: 65,
                width: 40,
                padding: EdgeInsets.only(left: 20),
                child: SvgPicture.asset(
                  "assets/icons/about.svg",
                  color: Constants().mainColor,
                ),
              ),
              SizedBox(
                width: 15,
              ),
              CommonText(text: "About Us", textColor: Constants().mainColor)
            ],
          ),
          onTap: () {},
        ),
        Divider(),
        InkWell(
          child: Row(
            children: [
              Container(
                height: 65,
                width: 40,
                padding: EdgeInsets.only(left: 20),
                child: SvgPicture.asset(
                  "assets/icons/privacy.svg",
                  color: Constants().mainColor,
                ),
              ),
              SizedBox(
                width: 15,
              ),
              CommonText(
                  text: "Privacy Policy", textColor: Constants().mainColor)
            ],
          ),
          onTap: () {},
        ),
        Divider(),
        InkWell(
          child: Row(
            children: [
              Container(
                height: 65,
                width: 40,
                padding: EdgeInsets.only(left: 20),
                child: Icon(
                  Icons.settings,
                  color: Constants().mainColor,
                ),
              ),
              SizedBox(
                width: 15,
              ),
              CommonText(text: "Settings", textColor: Constants().mainColor)
            ],
          ),
          onTap: () {},
        ),
        Divider(),
        InkWell(
          child: Row(
            children: [
              Container(
                height: 65,
                width: 40,
                padding: EdgeInsets.only(left: 20),
                child: Icon(
                  Icons.logout,
                  color: Constants().mainColor,
                ),
              ),
              SizedBox(
                width: 15,
              ),
              CommonText(text: "Logout", textColor: Constants().mainColor)
            ],
          ),

          onTap: () {
            FirebaseAuth.instance
                .signOut()
                .whenComplete(() => Get.offAll(StartPage()));
          },

        ),
        Divider(),
        Expanded(
            child: Align(
          alignment: Alignment.bottomCenter,
          child: Center(
            child: CommonText(
                text: "Version 1.0", textColor: Constants().mainColor),
          ),
        ))
      ],
    ),
  );
}

ImageNetworkTap(
    {String imagePathAPI,
    double width,
    double height,
    BoxFit fit,
    Function ontap}) {
  return GestureDetector(
    onTap: () {
      ontap();
    },
    child: CachedNetworkImage(
        imageUrl: imagePathAPI,
        progressIndicatorBuilder: (context, url, downloadProgress) =>
            LinearProgressIndicator(
              value: downloadProgress.progress,
              backgroundColor: Colors.transparent,
            ),
        errorWidget: (context, url, error) => Icon(Icons.error_outline),
        width: width,
        height: height,
        fit: fit),

    /*Image.network(
      imagePathAPI,
      width: width,
      height: height,
      fit: fit,
    ),*/
  );
}


class CommonBottomSheet {
  bottomSheet({BuildContext context, String title="title", Widget content}) {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (builder) {
          return Container(

            decoration:  BoxDecoration(
                color: Colors.white,
                borderRadius: new BorderRadius.only(
                    topLeft: const Radius.circular(25.0),
                    topRight: const Radius.circular(25.0))),

            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 30,right: 30,top: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CommonText(text: title,textColor: Constants().mainColor,fontSize: 20,fontStyle: FontWeight.bold),
                      IconButton(onPressed: (){
                        Navigator.pop(context);
                      }, icon: Icon(Icons.clear,color: Constants().mainColor,))
                    ],
                  ),
                ),
                SizedBox(height: 25,),
                content
              ],
            ),
          );
        });
  }
}

Widget AddLead(){
  return  CommonBottomSheet().bottomSheet(
      title: "Add Lead",
      context: Get.context,
      content: Padding(
        padding: const EdgeInsets.only(
            top: 10,
            left: 20,
            right: 20,
            bottom: 10),
        child: Column(
          children: [
            InkWell(
              onTap: (){
                Get.to(CustomerVerificationView());
              },
              child: Column(
                children: [
                  Row(
                    children: [
                      CommonText(
                          text:
                          "Loans",
                          textColor:
                          Constants()
                              .mainColor),
                      SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        child: Container(
                          width: MediaQuery.of(
                              Get.context)
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
                                "assets/icons/loans.svg"),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CommonText(
                              text:
                              "Get a Loan ",
                              textColor:
                              Constants()
                                  .mainColor,
                              fontSize:
                              22),
                          CommonText(
                            text:
                            "Give yourself a financial protection",
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
            ),
            SizedBox(height: 20,),
            InkWell(
              onTap: (){
                Get.to(CustomerCreditCardVerificationView());
              },
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
                              Get.context)
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
            ),

          ],
        ),
      ));
}

