import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:upen/screen/helper/constant.dart';
import 'package:upen/test/testView.dart';
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
    bool isCenter=false, TextAlign textAlign, inputController, TextInputAction textInputAction, String labeltext}) {
  return Text(
    text,
     style: GoogleFonts.lato(
  textStyle: Theme.of(Get.context).textTheme.headline4,
  fontSize: fontSize,
  fontWeight: fontStyle,
 // fontStyle: FontStyle.italic,
  color: textColor,
  ));

       // TextStyle(fontSize: fontSize, color: textColor, fontWeight: fontStyle,fontFamily: 'Cambria'),
        /*TextStyle(fontSize: fontSize, color: textColor, fontWeight: fontStyle),*/
   // textAlign: TextAlign.center,

 // );
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


Widget CommonTextInput1(
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
      int  minLines =1,
      int maxLines =50,
      TextInputAction textInputAction = TextInputAction.done}) {


  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [

      //Text(),
      SizedBox(
        height: 5,
      ),

      Container(
        decoration: const BoxDecoration(
          color: Color(0xff0F1B25),
          borderRadius: BorderRadius.all(
            Radius.circular(5.0),
          ),
        ),
        child: TextFormField(
          inputFormatters: [
             LengthLimitingTextInputFormatter(maxLines),// for mobile
          ],
          minLines: minLines,
          maxLines: maxLines,
          textInputAction: textInputAction,
          readOnly: isReadOnly,
          keyboardType: textInputType,
          controller: inputController,
          style: TextStyle(color: Colors.white),
          cursorColor: Colors.white,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Colors.transparent, width: 0.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius:
              BorderRadius.all(Radius.circular(4)),
              borderSide: BorderSide(
                  width: 1, color: Colors.transparent),
            ),
            fillColor: Colors.white,
            focusColor: Colors.white,
            border: OutlineInputBorder(),
            hintText: hint,
            hintStyle: TextStyle(
              color: Colors.white38
            )

            /* prefixIcon: Padding(
                            padding: EdgeInsets.all(15),
                            child: Icon(Icons.otp)),*/
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
        ),
      ) //)
    ],
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
    double lableFontSize=14,
    lableTextColor,
    TextEditingController inputController,
    TextInputType textInputType = TextInputType.text,
    String regexp,
    errortext,
    bool isRequired = false,
    bool isReadOnly = false,
    bool isEnabled = true,
    int  minLines =1,
     int maxLines =1,
      TextInputAction textInputAction = TextInputAction.done}) {


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
      Padding(
        padding: const EdgeInsets.only(
          left: 5.0,
          right: 5.0,
        ),
        child: Container(
          decoration: const BoxDecoration(
            color: Color(0xff0F1B25),
            borderRadius: BorderRadius.all(
              Radius.circular(5.0),
            ),
          ),
          child: TextFormField(
            minLines: minLines,
            maxLines: maxLines,
            textInputAction: textInputAction,
            cursorColor:   Constants().mainColor,
            enabled: isEnabled,
            readOnly: isReadOnly,
            maxLength: maxLength,
            keyboardType: textInputType,
            controller: inputController,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              labelStyle: TextStyle(color: Colors.white54),
              hintStyle: TextStyle(color: Colors.white24),
              hintText: hint,
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent, width: 0.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(4)),
                borderSide: BorderSide(width: 1, color: Colors.transparent),
              ),
              fillColor: Colors.white,
              focusColor: Colors.white,
              // border: OutlineInputBorder(),
              /*prefixIcon: Padding(
                padding: EdgeInsets.all(1),
                child:
                    Text("",
                  style: TextStyle(color: Colors.white54),
                ),
              ),*/
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
          ) ,
        ),
      ),
     //)
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
  return InkWell(
    onTap: (){
      onPressed();
    },
    child: Container(
      height: 60,
      width: 300,
      decoration: const BoxDecoration(
          color: Color(0xffFFFFFF),
          borderRadius: BorderRadius.all(
            Radius.circular(5.0),
          )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: TextButton(
              child: Text(
                buttonText,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    ),
  );;

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
        isScrollControlled: true,
        context: context,
        backgroundColor: Colors.transparent,
        builder: (builder) {
          return Container(
            height: MediaQuery.of(context).size.height,
            decoration:  BoxDecoration(
                color: Colors.white,
                borderRadius: new BorderRadius.only(
                    topLeft: const Radius.circular(25.0),
                    topRight: const Radius.circular(25.0))),

            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 30,right: 30,top: 35.0),
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
            ),
          );
        });
  }
}



