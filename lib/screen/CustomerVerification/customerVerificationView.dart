import 'package:flutter/material.dart';
import 'package:upen/commonWidget/commonWidget.dart';
import 'package:upen/screen/helper/constant.dart';

class CustomerVerificationView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold( appBar: AppBar(
      centerTitle: true,
      title: CommonText(
        text: "Products",
      ),
    ),
    body: Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.0),
      child: CommonTextInput(
          textInputType: TextInputType.phone,
          labeltext: "Enter Phone",
        //  inputController: loginController.phoneController,
          maxLength: 10,
          lableFontSize: 20,
          lableFontStyle: FontWeight.bold,
          lableTextColor: Constants().mainColor,
          regexp: r"^[0-9]{10}$",
          errortext: "Enter valid Mobile No"),
    ),);
  }
}
