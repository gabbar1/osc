import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upen/commonWidget/commonWidget.dart';
import 'package:upen/screen/helper/constant.dart';

import 'registerController.dart';

class RegisterPageView extends StatelessWidget {
  RegisterController registerController = Get.put(RegisterController());
  CommonDatePicker commonDatePicker = Get.put(CommonDatePicker());
  GlobalKey<FormState> registerFormKey = new GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    registerController.clearRecord();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Registration"),
        backgroundColor: Color(0xff123374),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 10, left: 15, right: 15),
        child: Form(
          key: registerFormKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                CommonTextInput(
                    labeltext: "Enter Name",
                    inputController: registerController.nameController,
                    /* lable: "Name",*/
                    lableFontSize: 20,
                    lableFontStyle: FontWeight.bold,
                    lableTextColor: Constants().mainColor),
                CommonTextInput(
                    isRequired: true,
                    textInputType: TextInputType.emailAddress,
                    labeltext: "Enter Email",
                    inputController: registerController.emailController,
                    /*  lable: "Email",*/
                    lableFontSize: 20,
                    lableFontStyle: FontWeight.bold,
                    lableTextColor: Constants().mainColor,
                    regexp:
                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                    errortext: "Enter valid email"),
                CommonTextInput(
                  textInputType: TextInputType.phone,
                  labeltext: "Enter Phone",
                  inputController: registerController.phoneController,
                  maxLength: 10,
                  lableFontSize: 20,
                  lableFontStyle: FontWeight.bold,
                  lableTextColor: Constants().mainColor,
                ),
                CommanDateTimePicker(labelText: "Date of Birth"),
                CommonTextInput(
                  isValidationRequired: false,
                  textInputType: TextInputType.number,
                  labeltext: "Referal Code",
                  inputController: registerController.referalCodeController,
                  maxLength: 10,
                  lableFontSize: 20,
                  lableFontStyle: FontWeight.bold,
                  lableTextColor: Constants().mainColor,
                ),

                /*CommonDatePicker()
                    .CommonDateDropdown(text: "DOB", context: context),*/
                SizedBox(
                  height: 10,
                ),
                CommonButton(
                    onPressed: () {
                      if (registerFormKey.currentState.validate()) {
                        print("Validated");
                        registerController.register(
                            email: registerController.emailController.text,
                            phone: registerController.phoneController.text,
                            name: registerController.nameController.text,
                            dob: commonDatePicker.getSelectedDate);
                      } else {
                        print("not validated");
                      }
                    },
                    context: context,
                    buttonText: "Register",
                    buttonColor: Constants().mainColor,
                    shdowColor: Colors.lightBlue,
                    buttonTextColor: Colors.white,
                    buttonTextSize: 18,
                    buttonTextStyle: FontWeight.bold)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class VerifyOtpScreen extends StatelessWidget {
  RegisterController registerController = Get.put(RegisterController());
  String name, email, phone, dob;
  GlobalKey<FormState> otpFormKey = new GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    print("OTP screen Module");
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: CommonText(text: "Verify OTP", fontSize: 20),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 15, left: 15, right: 15),
        child: Form(
          key: otpFormKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                CommonTextInput(
                    textInputType: TextInputType.phone,
                    hint: "Enter OTP",
                    inputController: registerController.otpController,
                    lable: "OPT",
                    lableFontSize: 20,
                    lableFontStyle: FontWeight.bold,
                    lableTextColor: Constants().mainColor),
                SizedBox(
                  height: 20,
                ),
                CommonButton(
                    onPressed: () {
                      if (otpFormKey.currentState.validate()) {
                        print("Validated");
                        registerController.signUp(
                            context: context,
                            otp: registerController.otpController.text);
                      } else {
                        print("not validated");
                      }
                    },
                    context: context,
                    buttonText: "Register",
                    buttonColor: Constants().mainColor,
                    buttonTextColor: Colors.white,
                    buttonTextSize: 18,
                    buttonTextStyle: FontWeight.bold)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
