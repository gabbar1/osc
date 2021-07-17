import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:upen/screen/helper/constant.dart';
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
    FontWeight fontStyle = FontWeight.normal}) {
  return Text(
    text,
    style:
        TextStyle(fontSize: fontSize, color: textColor, fontWeight: fontStyle,fontFamily: 'Cambria'),
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
    bool isRequired = false}) {
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
        maxLength: maxLength,
        keyboardType: textInputType,
        controller: inputController,
        style: TextStyle(color: Constants().mainColor),
        decoration: InputDecoration(
          hintText: hint,
          labelText: labeltext,
          border: new OutlineInputBorder(
            borderRadius: BorderRadius.circular(40.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xff123374), width: 2.0),
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
                side: BorderSide(color: Color(0xff123374))))),
  );
}

Widget AppDrawer() {
  return Drawer(
    child: Column(
      // Important: Remove any padding from the ListView.

      children: <Widget>[
        DrawerHeader(
          decoration: BoxDecoration(
            color: Constants().mainColor,
          ),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.black45,
                radius: 35,
                child: Icon(Icons.camera_alt_outlined),
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CommonText(text: "Name"),
                  CommonText(text: "phone"),
                  CommonText(text: "email"),
                ],
              )
            ],
          ),
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
