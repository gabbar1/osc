import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upen/commonWidget/commonWidget.dart';
import 'package:upen/screen/helper/constant.dart';
import 'package:upen/screen/login/loginController.dart';

class LoginPageView extends StatelessWidget {
  LoginController loginController = Get.put(LoginController());

  GlobalKey<FormState> loginFormKey = new GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * .9,
          height: MediaQuery.of(context).size.width * .8,
          decoration: BoxDecoration(color: Colors.white, boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 10,
            ),
          ]),
          child: Form(
            key: loginFormKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Enter Mobile Number to Login"),
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.0),
                  child: CommonTextInput(
                      textInputType: TextInputType.phone,
                      labeltext: "Enter Phone",
                      inputController: loginController.phoneController,
                      maxLength: 10,
                      lableFontSize: 20,
                      lableFontStyle: FontWeight.bold,
                      lableTextColor: Constants().mainColor,
                      regexp: r"^[0-9]{10}$",
                      errortext: "Enter valid Mobile No"),
                ),
                SizedBox(
                  height: 15,
                ),
                CommonButton(
                    onPressed: () {
                      print("-----Clicked------");
                      if (loginFormKey.currentState.validate()) {
                        print("Validated");
                        loginController.login(
                          phone: loginController.otpController.text,
                        );
                      } else {
                        print("not validated");
                      }
                    },
                    context: context,
                    buttonText: "Login",
                    buttonColor: Constants().mainColor,
                    shdowColor: Colors.lightBlue,
                    buttonTextColor: Colors.white,
                    buttonTextSize: 18,
                    buttonTextStyle: FontWeight.bold),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
