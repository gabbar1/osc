import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upen/lib/commonWidget/commonWidget.dart';
import 'package:upen/lib/screen/helper/constant.dart';
import 'package:upen/lib/screen/login/loginPage.dart';
import 'package:upen/lib/screen/register/registerPage.dart';

class StartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: CommonText(text: "Welcome to Samaj",textColor: Colors.black,fontSize: 24)),
          SizedBox(height: MediaQuery.of(context).size.width),
          InkWell(onTap: (){
            Get.to(LoginPageView());
          },child: Container(

            decoration: BoxDecoration(
                color: Constants().mainColor,
                borderRadius: BorderRadius.all(Radius.circular(5))
            ),
            margin: EdgeInsets.only(left: 20,right: 20),
            height: MediaQuery.of(context).size.height / 15,
            width: MediaQuery.of(context).size.width,
            child: Center(child: CommonText(text: "Login",fontStyle: FontWeight.bold)),
          ),),
          SizedBox(height: 10,),
          InkWell(
            onTap: (){
              Get.to(RegisterPageView());
            },
            child: Container(

              decoration: BoxDecoration(
                  color: Constants().mainColor,
                  borderRadius: BorderRadius.all(Radius.circular(5))
              ),
              margin: EdgeInsets.only(left: 20,right: 20),
              height: MediaQuery.of(context).size.height / 15,
              width: MediaQuery.of(context).size.width,
              child: Center(child: CommonText(text: "Register",fontStyle: FontWeight.bold)),
            ),
          )
        ],
      ),
    );
  }
}
