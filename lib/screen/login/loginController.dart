import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upen/commonWidget/commonWidget.dart';
import 'package:upen/screen/dashBoard/homeNavigator.dart';
import 'package:upen/screen/helper/constant.dart';
import 'package:upen/screen/login/loginPage.dart';
import 'package:upen/screen/register/registerPage.dart';

class LoginController extends GetxController {
  TextEditingController phoneController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  String phoneNo, verficationId;
  bool codeSent = false;
  bool isLogin=true;

  Future<void> login({String phone}) async {
    print("--- login called---");
    this.phoneNo = phone;

    DocumentSnapshot getSpecificData = await FirebaseFirestore.instance
        .collection('user_details')
        .doc("+91$phone")
        .get();
    print("-----------------getSpecificData-------------------");
    print(getSpecificData.data());
    if (!getSpecificData.data().isBlank || getSpecificData.data() != null) {
      print("Verification step");
      verifyPhone("+91 ${phone}");
    } else {
      return showDialog<void>(
        context: Get.context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Constants().mainColor,
            title: CommonText(text: 'Information', textColor: Colors.blue),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  CommonText(
                    text: 'User not found please do registration first',
                  )
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: CommonText(text: 'Ok', textColor: Colors.red),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  Future<void> verifyPhone(phoneNo) async {
    final PhoneVerificationCompleted verified = (AuthCredential authResult) {};

    final PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException authException) {
      print('${authException.message}');
      Get.snackbar("Error Code 1 : ", authException.message.toString());
    };

    final PhoneCodeSent smsSent = (String verId, [int forceResend]) {
      this.codeSent = true;
      this.verficationId = verId;
      Get.snackbar("title", codeSent.toString());
      if (codeSent) {
        print("OTP screen redirect");
        Get.to(VerifyOtpScreen());
      } else {
        print("code sent false");
      }
      //Fluttertoast.showToast(msg: verficationId.toString());
    };

    final PhoneCodeAutoRetrievalTimeout autoTimeout = (String verId) {
      this.verficationId = verId;
    };
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNo,
        timeout: const Duration(seconds: 60),
        verificationCompleted: verified,
        verificationFailed: verificationFailed,
        codeSent: smsSent,
        codeAutoRetrievalTimeout: autoTimeout);
  }


  Future<void> loginUser({String otp,BuildContext context}) async {
    try{
      showDialog(context: context,
          builder: (BuildContext context) {
            return Center(child: CircularProgressIndicator(),);
          });
      var result= await FirebaseAuth.instance.signInWithCredential(PhoneAuthProvider.credential(
        verificationId: verficationId,
        smsCode: otp,
        //8160137998
      ));
      if(!result.additionalUserInfo.isBlank){
        Get.offAll(HomeNavigator());
      }else{
        print("Message-- Error to Login");
       // Get.snackbar("Message", result.additionalUserInfo.isBlank.toString());
      }
      /*if(!result.additionalUserInfo.isBlank){
        addUserDetails();
        Get.offAll(HomeNavigator());
      }*/
      /*Get.snackbar("Message", result.additionalUserInfo.isBlank.toString());*/
      // updateDetail(context: context);

    } on Exception catch(e){
      Get.snackbar("Erro", e.toString());
      otp=null;
    }

  }
}
