import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:upen/lib/screen/helper/constant.dart';

Widget CommonText(
    {String text,
    double fontSize = 14.00,
    Color textColor = Colors.white,
    FontWeight fontStyle = FontWeight.normal}) {
  return Text(
    text,
    style:
        TextStyle(fontSize: fontSize, color: textColor, fontWeight: fontStyle),
  );
}

Widget CommonTextInput(
    {String lable = "",
    hint = "Enter Value",
    FontWeight lableFontStyle,
    double lableFontSize,
    lableTextColor,
    TextEditingController inputController,
    TextInputType textInputType = TextInputType.text,
    String regexp,
    errortext,
    bool isRequired = false}) {
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
      Container(
          padding: EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
          decoration: BoxDecoration(
            color: Colors.greenAccent[100],
            borderRadius: BorderRadius.all(
              Radius.circular(30),
            ),
          ),
          child: TextFormField(
            keyboardType: textInputType,
            controller: inputController,
            style: TextStyle(color: Constants().mainColor),
            decoration: InputDecoration(
              hintText: hint,
              border: InputBorder.none,
            ),
            validator: (value) {
              if (value.toString().isEmpty) {
                return 'field required';
                //"Please enter valid floor number";
              } else if (value.toString().isNotEmpty && isRequired) {
                if (RegExp(regexp).hasMatch(value.toString())) {
                  return null;
                } else {
                  return errortext;
                }
              } else {
                return null;
              }
              /* if (value.toString().isEmpty) {
                return 'field required';
                //"Please enter valid floor number";
              } else if(RegExp(regexp).hasMatch(value.toString())){

                return errortext;
              } else{
                return null;
              }*/
            },
          ))
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

Widget CommonButton({
  Function onTap,
  BuildContext context,
  String buttonText,
  Color buttonTextColor,
  buttonColor,
  FontWeight buttonTextStyle,
  double buttonTextSize = 14.00,
}) {
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
