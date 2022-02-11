import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upen/commonWidget/commonWidget.dart';
import 'package:upen/screen/helper/constant.dart';
import 'package:upen/screen/login/loginController.dart';


class RegsiterView extends StatelessWidget {

  LoginController loginController = Get.put(LoginController());
  GlobalKey<FormState> registerFormKey = new GlobalKey<FormState>();
  CommonDatePicker commonDatePicker = Get.put(CommonDatePicker());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 25,right: 25,),
        child: Form(
           key: registerFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  "Enter Your Details",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Constants().textColor,
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                "Name",
                style: TextStyle(
                  color: Constants().textColor,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                decoration: const BoxDecoration(
                  color: Color(0xff0F1B25),
                  borderRadius: BorderRadius.all(
                    Radius.circular(5.0),
                  ),
                ),
                child:  TextFormField(
                  keyboardType: TextInputType.name,
                  controller:  loginController.nameController,
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
                    /* prefixIcon: Padding(
                              padding: EdgeInsets.all(15),
                              child: Icon(Icons.otp)),*/
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                "Email",
                style: TextStyle(
                  color: Constants().textColor,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                decoration: const BoxDecoration(
                  color: Color(0xff0F1B25),
                  borderRadius: BorderRadius.all(
                    Radius.circular(5.0),
                  ),
                ),
                child:  TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller:  loginController.emailController,
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
                    /* prefixIcon: Padding(
                              padding: EdgeInsets.all(15),
                              child: Icon(Icons.otp)),*/
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                "Date of Birth",
                style: TextStyle(
                  color: Constants().textColor,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              CommanDateTimePicker(labelText: "Date of Birth"),
              const SizedBox(
                height: 15,
              ),
              Text(
                "Referal Code",
                style: TextStyle(
                  color: Constants().textColor,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                decoration: const BoxDecoration(
                  color: Color(0xff0F1B25),
                  borderRadius: BorderRadius.all(
                    Radius.circular(5.0),
                  ),
                ),
                child:  TextFormField(
                  keyboardType: TextInputType.phone,
                  controller:  loginController.referalCodeController,
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
                    /* prefixIcon: Padding(
                              padding: EdgeInsets.all(15),
                              child: Icon(Icons.otp)),*/
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              InkWell(
                onTap: (){
                  if (registerFormKey.currentState.validate()) {
                    loginController.register(name: loginController.nameController.text,phone: loginController.phoneController.text,email: loginController.emailController.text,
                    referalCode: loginController.referalCodeController.text,dob: commonDatePicker.getSelectedDate);
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 25,right: 25),
                  child: Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      //width: 300,
                      decoration: const BoxDecoration(
                          color: Color(0xffFFFFFF),
                          borderRadius: BorderRadius.all(
                            Radius.circular(5.0),
                          )),
                      child: Center(
                        child: Text(
                          "Submit",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                  ),
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}


