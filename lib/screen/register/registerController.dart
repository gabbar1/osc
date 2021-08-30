
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upen/commonWidget/commonWidget.dart';
import 'package:upen/screen/dashBoard/dashBoard.dart';
import 'package:upen/screen/dashBoard/homeNavigator.dart';
import 'package:upen/screen/helper/constant.dart';
import 'registerPage.dart';

class RegisterController extends GetxController{
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  TextEditingController referalCodeController = TextEditingController();
  String phoneNo,referalCode,verficationId,smsCode,dob,email,password,name;
  bool codeSent = false;
  bool isLogin=false;
  Future<void> register({String name,email,phone,dob,referalCode})async{

    this.name = name;
    this.email = email;
    this.phoneNo = phone;
    this.email = email;
    this.dob = dob;
    this.referalCode=referalCode;
    DocumentSnapshot  getSpecificData = await FirebaseFirestore.instance.collection('user_details').doc(phone).get();
    print("-----------------NotFound-------------------");
    print(getSpecificData.data());
    if (getSpecificData.data().isBlank||getSpecificData.data()==null) {
        print("Verification step");
        verifyPhone("+91 ${phone}");
    }
    else{
      return showDialog<void>(
        context: Get.context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Constants().mainColor,
            title: CommonText(text:'Warning',textColor:  Colors.red),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  CommonText(text:'Number is already registered do Login ',),
                  CommonText(text: ''),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: CommonText(text:'Ok', textColor: Colors.red),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

  //

  }

  Future<void>  verifyPhone(phoneNo) async {
    final PhoneVerificationCompleted verified  = (AuthCredential authResult){

    };



    final PhoneVerificationFailed verificationFailed  = (FirebaseAuthException authException){
      print('${authException.message}');
      Get.snackbar("Error Code 1 : ", authException.message.toString());
    };

    final PhoneCodeSent smsSent  = (String verId,[int forceResend]){
      this.codeSent = true;
      this.verficationId = verId;

      Get.snackbar("title", codeSent.toString());
      if (codeSent) {
        print("OTP screen redirect");
        Get.to(VerifyOtpScreen());
      }else{
        print("code sent false");
      }
      //Fluttertoast.showToast(msg: verficationId.toString());
    };

    final  PhoneCodeAutoRetrievalTimeout autoTimeout = (String verId){
      this.verficationId = verId;
    };
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNo,
        timeout: const Duration(seconds: 60),
        verificationCompleted: verified,
        verificationFailed: verificationFailed,
        codeSent: smsSent, codeAutoRetrievalTimeout: autoTimeout);


  }


  Future<void> signUp({String otp,BuildContext context}) async {
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
       addUserDetails();
       Get.offAll(HomeNavigator());
     }
     Get.snackbar("Message", result.additionalUserInfo.isBlank.toString());
      // updateDetail(context: context);

    } on Exception catch(e){
       Get.snackbar("Erro", e.toString());
       otp=null;
    }

  }


  Future<void> addUserDetails() async {

    FirebaseFirestore.instance.collection(Constants().userDetailsCollectionName).doc(phoneNo).set(  {
      "advisor_name" : name,
      "advisor_email" : email,
      "advisor_phone_number" : phoneNo,
      "advisor_dob" : dob,
      "refered_By":referalCode,
    });

  }

  void clearRecord(){
    emailController.clear();
    nameController.clear();
    phoneController.clear();
    referalCodeController.clear();
  }
}




