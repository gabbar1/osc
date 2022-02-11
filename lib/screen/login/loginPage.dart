import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:upen/screen/helper/constant.dart';
import 'package:delayed_display/delayed_display.dart';
import '../../commonWidget/loader.dart';
import 'loginController.dart';
class LoginView extends StatelessWidget {

  LoginController loginController = Get.put(LoginController());

  GlobalKey<FormState> loginFormKey = new GlobalKey<FormState>();
  GlobalKey<FormState> otpFormKey = new GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset("assets/icons/background.png",fit: BoxFit.cover,),
          Obx(()=> loginController.getIsOtp ? DelayedDisplay(
            delay: Duration(seconds: 1),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(left: 25,right: 25,bottom: 80),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      "Enter Otp",
                      style: TextStyle(
                        color:Constants().textColor,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Verify 6 digit Otp",
                      style: TextStyle(
                        color: Constants().textColor,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Text(
                      "Otp",
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
                      child:  Form(
                        key: otpFormKey,
                        child: TextFormField(
                          inputFormatters: [
                            new LengthLimitingTextInputFormatter(10),// for mobile
                          ],
                          keyboardType: TextInputType.phone,
                          controller: loginController.otpController,
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
                    ),
                    SizedBox(height: 25),
                    InkWell(
                      onTap: (){
                        if (otpFormKey.currentState.validate()) {
                          loginController.loginUser(
                              context: context,
                              otp: loginController.otpController.text);
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
                                "Enter",
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
              ),),
          ):DelayedDisplay(
            delay: Duration(seconds: 1),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(left: 25,right: 25,bottom: 80),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      "Enter Mobile Number",
                      style: TextStyle(
                        color:Constants().textColor,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Login Using The verification code received on\nyour phone and it is done",
                      style: TextStyle(
                        color: Constants().textColor,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Text(
                      "Mobile Number",
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
                      child:  Form(
                        key: loginFormKey,
                        child: TextFormField(
                          inputFormatters: [
                            new LengthLimitingTextInputFormatter(10),// for mobile
                          ],
                          keyboardType: TextInputType.phone,
                          controller: loginController.phoneController,
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
                            prefixIcon: Padding(
                                padding: EdgeInsets.all(15),
                                child: Text(
                                  '+91 ',
                                  style: TextStyle(color: Colors.white54),
                                )),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 25),
                    InkWell(
                      onTap: (){
                        if (loginFormKey.currentState.validate()) {
                          print("Validated");
                          loginController.login(
                            phone: loginController.phoneController.text,
                          );
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
                                "Next",
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
              ),),
          ))

        ],
      ),
    );
  }
}
