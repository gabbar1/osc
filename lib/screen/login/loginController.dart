import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upen/commonWidget/loader.dart';
import 'package:upen/screen/dashBoard/homeNavigator.dart';
import 'package:upen/screen/helper/constant.dart';
import 'package:upen/screen/login/registerPage.dart';



class LoginController extends GetxController {
  TextEditingController phoneController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController referalCodeController = TextEditingController();
  String phoneNo, verficationId;
  bool codeSent = false;
  bool isLogin=false;
  var isOtp = false.obs;
  bool get getIsOtp => isOtp.value;
  set setIsOtp(bool val){
    isOtp.value = val;
    isOtp.refresh();
  }

  Future<void> login({String phone}) async {
    this.phoneNo = phone;
    try{
      showLoader();
      verifyPhone("+91 ${phone}");
    }catch(e){
      closeLoader();
      Get.snackbar("Error", e.toString());
      throw e;
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

      if (codeSent) {
        print("OTP screen redirect");
        setIsOtp = true;
        closeLoader();
       // Get.to(VerifyOtpScreen());
      } else {
       Get.snackbar("Error", "Code not sent");
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
        codeAutoRetrievalTimeout: autoTimeout).then((value) {
      isLogin = true;
    });
  }


  Future<void> loginUser({String otp,BuildContext context}) async {
    try{
      showLoader();
      FirebaseAuth.instance.signInWithCredential(PhoneAuthProvider.credential(
        verificationId: verficationId,
        smsCode: otp,
        //8160137998
      )).then((value) {
        closeLoader();
        if(value.additionalUserInfo.isNewUser) {
          Get.offAll(RegsiterView());
          }
          else{
          Get.offAll(HomeNavigator());
          }
      });
    } on Exception catch(e){
      closeLoader();
      Get.snackbar("Error", e.toString());
      otp=null;
    }
  }


  Future<void> register({String name,email,phone,dob,referalCode})async{
    showLoader();
    try{
      FirebaseFirestore.instance.collection(Constants().userDetailsCollectionName).doc(phone).set(  {
        "advisor_name" : name,
        "advisor_email" : email,
        "advisor_phone_number" : phoneNo,
        "advisor_dob" : dob,
        "refered_By":referalCode,
        "isEnabled":false,
        'total_wallet':"0",
        'current_wallet':"0"
      }).then((value) {
        closeLoader();
        Get.offAll(HomeNavigator());
      });
    }catch(e){
      closeLoader();
      Get.snackbar("Error", e.toString());
      throw e;
    }
  }

}
