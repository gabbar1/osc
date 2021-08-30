import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upen/commonWidget/loader.dart';
import 'package:upen/screen/CustomerVerification/customerVerificationController.dart';
import 'package:upen/screen/customerCrediCardVerification/creditCardModel.dart';
import 'package:upen/screen/dashBoard/homeNavigator.dart';

class CreditCardController extends GetxController{


  var alreadyCardList = <CreditCardModel>[].obs;
  List<CreditCardModel> get getAlreadyCardList => alreadyCardList.value;
  setCardList(CreditCardModel creditCardModel){
    alreadyCardList.value.add(creditCardModel);
    alreadyCardList.refresh();
  }
  var listBank =<String>[].obs;
  List<String> get getList => listBank.value;
  setList(String val){
    listBank.value.add(val);
    listBank.refresh();
  }
  var availableBank = <String>[].obs;
  var availableBankList = <String>[].obs;
  List<String> get getAvailableBank => availableBank.value;

  setAvailableBank(String val){
    availableBankList.value.add(val);
    availableBank.value = availableBankList.toSet().toList();
    availableBank.refresh();
  }
  CustomerVerificationController _controller =
  Get.put(CustomerVerificationController());
  Future<void> checkEligibility({ String phone,
    name,
    pan,
    email,
    dob,
    address,
    pinCode,
    companyName,
    monthlySalary,
    designation,
    firmName,
    itr,
    bool salaried, alreadyCreditCard,List<CreditCardModel> creditCardList}) async{
    print("-------------Eligible---------------");
    print( _controller.getDonController.text);
    listBank.clear();
    showLoader();
    CheckEligibilityModel checkEligibilityModel = CheckEligibilityModel(pinCode: pinCode,pan:pan,dob: dob,email:email,name:name,phone:phone,address:address,alreadyCreditCard:alreadyCreditCard,companyName: companyName,creditCardModel: creditCardList,designation: designation,firmName: firmName,itr:itr,monthlySalary: monthlySalary,salaried: salaried);


      FirebaseFirestore.instance.collection("leads").doc(FirebaseAuth.instance.currentUser.phoneNumber.replaceAll("+91", "")).collection(FirebaseAuth.instance.currentUser.phoneNumber.replaceAll("+91", "")).add(
          {
            "backend_comment":"no comments",
            "create_date":DateTime.now().toString(),
            "userDetails":checkEligibilityModel.toJson(),
            "cardChoice":"no preference",
            "status":"pending",
            "leadType":"creditCard"
          }).then((value) {
        closeLoader();
        Get.offAll(HomeNavigator(),duration: Duration(seconds: 1),fullscreenDialog: true);
        Get.snackbar("Done", "Thank you for submitting the application we will review and update you soon",backgroundColor: Colors.amber);
      }).onError((error, stackTrace) {
        closeLoader();
        Get.snackbar("Error", error.toString(), backgroundColor: Colors.amber);
      });
  }
}